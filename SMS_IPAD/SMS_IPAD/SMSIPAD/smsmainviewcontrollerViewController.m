//
//  smsmainviewcontrollerViewController.m
//  SMSIPAD
//
//  Created by DeemSysInc on 08/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "smsmainviewcontrollerViewController.h"
#import "WelcomeViewController.h"
#import "signupViewController.h"
#import "forgetpasswordViewController.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import "Reachability.h"


@interface smsmainviewcontrollerViewController ()

@end

@implementation smsmainviewcontrollerViewController
@synthesize recorddict;
@synthesize phonenum;
@synthesize pass;
@synthesize rememberpass;
- (void)viewDidLoad
{
    //Corner Radius Round Rectangled
    signin.clipsToBounds = YES;
    signin.layer.cornerRadius = 5.0f;
    signup.clipsToBounds = YES;
    signup.layer.cornerRadius = 5.0f;
    forgot.clipsToBounds = YES;
    forgot.layer.cornerRadius = 5.0f;
    
    
    [super viewDidLoad];
    password.delegate=self;
    phonenumber.delegate=self;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"buttonset"]isEqualToString:@"TRUE"])
    {
        phonenumber.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"] ;
        password.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
        rememberpass.selected=TRUE;
         [rememberpass setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
    else  if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"buttonset"]isEqualToString:@"FALSE"]){
    phonenumber.text=@"";
        password.text=@"";
        rememberpass.selected=FALSE;
         [rememberpass setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    recorddict=[[NSMutableDictionary alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
   
  
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)back
{
    
}
- (IBAction)checkchange:(UIButton*)sender {
    sender.selected = !sender.selected;
    if(sender.selected){
        [sender setImage:[UIImage imageNamed:@"checkBoxMarked.png"] forState:UIControlStateNormal];
    }
    else{
        [sender setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    }
    
}

-(void)dismissKeyboard {
    [password resignFirstResponder];
    [phonenumber resignFirstResponder];
}
-(BOOL)alphanumericvalidation:(NSString *)country1
{
    NSString *countryFormat1 = @"(?:[A-Za-z0-9_-]+)";
    
    // [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}
-(BOOL)validateMobile:(NSString*)mobilenumber{
    NSString *mobileFormat1 =  @"[0-9]{10}?";
    
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *mobileTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat1];
    return [mobileTest1 evaluateWithObject:mobilenumber];
    
}
-(IBAction)signin:(id)sender
{
    
    if( ([phonenumber.text length]==0)&&([password.text length]==0))
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Enter login credentials."];
    
    // [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
    [alert show];
        
    }
    else
    {
    if([phonenumber.text length]!=0)
       {
       if([password.text length]!=0)
    {
        if([self alphanumericvalidation:phonenumber.text]==1)
        {
            
                [recorddict setValue:phonenumber.text forKey:@"Username"];
                [recorddict setValue:password.text forKey:@"Password"];
            if (rememberpass.selected) {
                [[NSUserDefaults standardUserDefaults]setObject:phonenumber.text forKey:@"username"];
                 [[NSUserDefaults standardUserDefaults]setObject:password.text forKey:@"password"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"TRUE"                                                          forKey:@"buttonset"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            }
            if (!rememberpass.selected) {
                [[NSUserDefaults standardUserDefaults]setObject:@""forKey:@"username"];
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
                 [[NSUserDefaults standardUserDefaults]setObject:@"FALSE"                                                          forKey:@"buttonset"];
                  [[NSUserDefaults standardUserDefaults]synchronize];
            }
                a=1;
                
                HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                [self.navigationController.view addSubview:HUD];
                
                
                HUD.delegate = self;
                HUD.labelText = @"Authenticating";
                
                [HUD show:YES];
                [self performSelector:@selector(SignInCheck) withObject:nil afterDelay:0.2];
                
                
            
        
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Enter valid Username."];
            
            //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
    }
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Enter Password."];
        
        // [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"OK" block:nil];
        [alert show];
        
    }
       }

       
       else
       {
           BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Enter username."];
           
           // [alert setCancelButtonWithTitle:@"Cancel" block:nil];
           [alert setDestructiveButtonWithTitle:@"OK" block:nil];
           [alert show];
       }
}
}

- (IBAction)signup:(id)sender
{
    //notregisterd.text=@"Please Wait...";
    
}


-(void)SignInCheck
{
    
   
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
			//NSLog(@"Reachable WiFi");
			break;
		}
	}
	
	
    
    if(isConnect)
    {
        
    }
    //  imgName=@"Connected.png";
    else
    {
        HUD.labelText = @"Check network connection";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:2];
        return;
    }
    
    
    
    
    
    
    
    
    NSString *resultResponse=[self HttpPostEntityFirst1:@"username" ForValue1:phonenumber.text EntitySecond:@"pswd" ForValue2:password.text EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    
    
    
    
	NSError *error;
    
    SBJSON *json = [[SBJSON new] autorelease];
	NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
    
    if (luckyNumbers == nil)
    {
        ////NSLog(@"Failed");
        
    }
    else
    {
        
        NSDictionary* menu = [luckyNumbers objectForKey:@"serviceresponse"];
        //////NSLog(@"Menu id: %@", [menu objectForKey:@"success"]);
        
        if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
        {
            
            HUD.labelText = @"Completed";
            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD hide:YES afterDelay:0];
            
            NSString *LoginId=[menu objectForKey:@"userid"];
            NSString *LoginId1=[menu objectForKey:@"message"];
            NSString *messagevalue=[menu objectForKey:@"messagestream"];
            
            
             [[NSUserDefaults standardUserDefaults] setObject:messagevalue    forKey:@"messagestream"];
            [[NSUserDefaults standardUserDefaults] setObject:LoginId    forKey:@"loginid"];
            [[NSUserDefaults standardUserDefaults] setObject:password.text    forKey:@"password"];
            
            [[NSUserDefaults standardUserDefaults] setObject:phonenumber.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"loginid %@",LoginId);
            //name.text=Nil;
            //password.text=nil;
            
            
            c =1;
            if(c==1 && a==1)
            {
                

          [self performSegueWithIdentifier:@"Welcome" sender:self];
            }
            /*
             Welcome *WelcomeViewController = [[Welcome alloc] initWithNibName:@"Welcome" bundle:nil];
             WelcomeViewController.first=1;
             [self.navigationController pushViewController:WelcomeViewController animated:YES];
             [WelcomeViewController release];//
             
             //NSLog(@"success");*/
            
        }
        else
        {
            password.text=@"";
            phonenumber.text=@"";
            phonenum.text=@"";
            pass.text=@"";
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Invalid username and password."];
            
            [HUD hide:YES];
            
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
            
        }
        
        
    }
    
}



-(NSString *)HttpPostEntityFirst1:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2 EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    
    //Checking username and password
    
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@&%@=%@",firstEntity,value1,secondEntity,value2,thirdEntity,value3];
    
    ////NSLog(@"POST:%@",post);
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/loginresponse.php?service=login"];
    
    
    //////NSLog(post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //when we user https, we need to allow any HTTPS cerificates, so add the one line code,to tell teh NSURLRequest to accept any https certificate, i'm not sure //about the security aspects
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
//   NSLog(@"data %@",data);

    return data;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier isEqual:@"Welcome"])
    {
        
        if(c==1 && a==1)
        {
            c=0;
            a=0;
            return  YES;
        }
        else
            return NO;
        
    }
    
    else
        return YES;
}*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Welcome"])
    {
        WelcomeViewController*destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
      //  NSLog(@"recorddict in login %@",recorddict);
        
    }
}
- (IBAction)hideKeyboard:(id)sender
{
    // NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    c=0,a=0;
    //  self.view.frame=CGRectMake(0,0,50,50);
}

// Memory de-allocation
- (void)dealloc {
    [signin release];
    [signup release];
    [forgot release];
    [notregisterd release];
    [phonenum release];
    [pass release];
    [rememberpass release];
    
    [super dealloc];
}
@end
