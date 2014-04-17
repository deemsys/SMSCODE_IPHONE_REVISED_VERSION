//
//  forgetpasswordViewController.m
//  SMSIPAD
//
//  Created by DeemsysInc on 11/14/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "forgetpasswordViewController.h"
#import "BlockAlertView.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "JSON.h"
@interface forgetpasswordViewController ()

@end

@implementation forgetpasswordViewController
@synthesize emailerr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    prefKeyDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
                         toEmail, TO_EMAIL_PREF_KEY,
                         fromEmail, FROM_EMAIL_PREF_KEY,
                         relayHost, RELAY_HOST_PREF_KEY,
                         SSLSwitch, USE_SSL_BOOL_PREF_KEY,
                         useAuthSwitch, USE_AUTH_BOOL_PREF_KEY,
                         login, AUTH_USERNAME_PREF_KEY,
                         password, AUTH_PASSWORD_PREF_KEY,
                         subject, MESSAGE_SUBJECT_PREF_KEY,
                         messageBody, MESSAGE_BODY_PREF_KEY,
                         sig, MESSAGE_SIG_PREF_KEY,
                         sendImageSwitch, SEND_IMAGE_BOOL_PREF_KEY,
                         sendVCFSwitch, SEND_VCARD_BOOL_PREF_KEY,
                         nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *pref_keys = [NSArray arrayWithArray:[prefKeyDictionary allKeys]];
    for (id pref_key in pref_keys)
    {
        id ui_element = [prefKeyDictionary objectForKey:pref_key];
        if ([ui_element isKindOfClass:[UITextField class]])
        {
            ((UITextField *)ui_element).text = [defaults stringForKey:pref_key];
        }
        else if ([ui_element isKindOfClass:[UISwitch class]])
        {
            ((UISwitch *)ui_element).on = [defaults boolForKey:pref_key];
        }
    }
    
}
#pragma mark SKPSMTPMessage Delegate Methods
- (void)messageState:(SKPSMTPState)messageState;
{
   // NSLog(@"HighestState:%d", HighestState);
    if (messageState > HighestState)
        HighestState = messageState;
    
    ProgressBar.progress = (float)HighestState/(float)kSKPSMTPWaitingSendSuccess;
}

#pragma mark IBActions

- (IBAction)sendpassword:(id)sender
{
    if ([emailid.text length]!=0)
    {
        if ([self validateEmail:emailid.text]==1)
        {
            //emailerr.hidden=YES;
            [self getpassword:emailid.text];
        }
        else
        {
           // emailerr.hidden=NO;
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter valid Email-id.Only example@contoso.com allowed."];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
        
        
    }
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Email-id."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
        
    }
    
}
-(BOOL)validateEmail:(NSString*)candidate{
    NSString *emailFormat1 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    
    NSPredicate *emailTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailFormat1];
    return [emailTest1 evaluateWithObject:candidate];
    
}

-(void)getpassword:(NSString*)email

{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
    
	HUD.delegate = self;
	HUD.labelText = @"Loading";
    [HUD show:YES];
    
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
	switch (netStatus)
	{
		case NotReachable:
		{
			isConnect=NO;
			//NSLog(@"Access Not Available");
			break;
		}
			
		case ReachableViaWWAN:
		{
			isConnect=YES;
			//NSLog(@"Reachable WWAN");
			break;
		}
		case ReachableViaWiFi:
		{
			isConnect=YES;
           // NSLog(@"Reachable WiFi");
			break;
		}
	}
	
	
    
    if(isConnect)
    {
        
    }
    
    else
    {
        HUD.labelText = @"Check network connection";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:2];
        return;
    }
    NSString *resultResponse=[self HttpPostEntityFirst:@"emailid" ForValue1:emailid.text  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    // NSLog(@"response %@",resultResponse);
	NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
    NSDictionary *itemsApp = [luckyNumbers objectForKey:@"serviceresponse"];
    NSArray *items1App=[itemsApp objectForKey:@"Patient password"];
   // NSLog(@"array %@ count %d",items1App,[items1App count]);
    NSDictionary *arrayList1;
    if ([[itemsApp objectForKey:@"success"] isEqualToString:@"Yes"])
    {
        if ([items1App count]>0)
        {
            
        for (id anUpdate1 in items1App)
        {
            NSDictionary *arrayList1=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
            
            
            password1 =[arrayList1 objectForKey:@"userpassword"];
            HUD.labelText = @"Completed";
            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
            HUD.mode = MBProgressHUDModeCustomView;
                        ProgressBar.hidden=YES;
            [self sendmail:password1];
        }
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Email id not found."];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
            [HUD hide:YES afterDelay:2];
            ProgressBar.hidden=YES;

        }
        
    }
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Email id not found."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
        [HUD hide:YES afterDelay:2];
        ProgressBar.hidden=YES;
        
    }
    // NSLog(@"items1app %@",luckyNumbers);
}

-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    //Sending user forgot password
    HUD.labelText = @"Synchronizing Data";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericSelect.php?service=passwordSelect"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
   // NSLog(@" post %@ ",post);
    
 // NSLog(@"%@ ",data);
    
    return data;
    
}

-(void)sendmail:(NSString*)userpassword
{
    SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
    emailMessage.fromEmail = @"adherencemedicationproject@gmail.com";
    
    emailMessage.toEmail = emailid.text;  //receiver email address
    emailMessage.relayHost = @"smtp.gmail.com";
    emailMessage.requiresAuth = YES;
    emailMessage.login = @"adherencemedicationproject@gmail.com";
    emailMessage.pass = @"Medication@123";
    emailMessage.subject =@"Password Recovery";
    emailMessage.wantsSecure = YES;
    emailMessage.delegate = self; // you must include <SKPSMTPMessageDelegate> to your class
    NSString *messageBody = [NSString stringWithFormat:@"Hi ,\n\n Your Password is : %@\n\n From Adherence Project Team.\n\n Thank You.\n\n",userpassword];
    
    NSDictionary *plainMsg = [NSDictionary
                              dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                              messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
    Spinner.hidden = NO;
    [Spinner startAnimating];
    ProgressBar.hidden = NO;
    HighestState = 0;
    
    [emailMessage send];
    // sending email- will take little time to send so its better to use indicator with message showing sending...}
    
    
}


-(void)messageSent:(SKPSMTPMessage *)message{
   // NSLog(@"delegate - message sent");
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Done!" message:@"Password sent."];
    [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
    [alert show];
    [Spinner stopAnimating];
    ProgressBar.hidden=YES;
    emailid.text=@"";
    [HUD hide:YES ];

    [self performSegueWithIdentifier:@"smsforgot" sender:self];
}


// On Failure
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    // open an alert with just an OK button
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Error!" message:[error localizedDescription]];
    [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
    [alert show];
    [Spinner stopAnimating];
   // NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    submit.clipsToBounds = YES;
    submit.layer.cornerRadius = 5.0f;
    UIColor * color = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    [emailerr setTextColor:color];
    [emailerr setHidden:YES];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

	// Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    [emailid resignFirstResponder];
}
- (IBAction)hideKeyboard:(id)sender
{
    //NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [submit release];
    [emailerr release];
    [super dealloc];
}

@end
