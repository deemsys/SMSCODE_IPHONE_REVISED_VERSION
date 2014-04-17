//
//  weeklymail.m
//  Breast Cancer
//
//  Created by DeemSysInc on 30/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "weeklymail.h"
#import "weekmessage2.h"
#import "BlockAlertView.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "Reachability.h"
#import "MBProgressHUD.h"


@interface weeklymail ()

@end

@implementation weeklymail
@synthesize recorddict;
int a;

-(BOOL)numbers:(NSString *)country1
{
    NSString *countryFormat1 = @"[1-2]{1}";
    
    //  [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}
-(void)updatetable
{
   // NSLog(@"update started");
    NSString *useridnumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    NSString *resultResponse2=[self HttpPostEntityFirstsequence:@"loginid" ForValue1:useridnumber EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    
    NSError *error2;
    SBJSON *json2 = [[SBJSON new] autorelease];
    // NSLog(@"response %@",resultResponse);
	NSDictionary *luckyNumbers2 = [json2 objectWithString:resultResponse2 error:&error2];
    
    if (luckyNumbers2 == nil)
    {
        ////NSLog(@"Failed");
        
    }
    else
    {
        
        NSDictionary* menu = [luckyNumbers2 objectForKey:@"serviceresponse"];
        //////NSLog(@"Menu id: %@", [menu objectForKey:@"success"]);
        
        if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
        {
            
           // HUD.labelText = @"Completed";
           // HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
           // HUD.mode = MBProgressHUDModeCustomView;
            //[HUD hide:YES afterDelay:0];
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Failed to update weekly survey result."];
            
            [HUD hide:YES];
            
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
            
        }
    }
    
}
-(NSString *)HttpPostEntityFirstsequence:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    //getting weekly evaluation sequence occurence
    //HUD.labelText = @"Synchronizing Data";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericUpdate.php?service=sequenceUpdate"];
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
    
  //  NSLog(@"result for update %@ ",data);
    
    return data;
    
}
- (IBAction)hideKeyboard:(id)sender
{
    //  NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}
// Includes Mail Template and data insertion
-(IBAction)send:(id)sender
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
     HUD.labelText = @"Sending Data";
    [HUD show:YES];
    [self updatetable];
    //recorddict=[[NSMutableDictionary alloc]init];
    if(([mailanswer.text length]!=0))
    {
        a=0;
        if([self numbers:[mailanswer text]]==1)
        {
            a=1;
            

         
            

                     //smtp email composing
            
            if (([mailanswer.text isEqual:@"1"])&&([cont isEqualToString:@"1"]))
            {
                //mail compose
                
                // NSLog(@"Start Sending");
                SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
                emailMessage.fromEmail =@"adherencemedicationproject@gmail.com";
                
            temp=[[NSUserDefaults standardUserDefaults]objectForKey:@"Providersecondaryemail"];
                if ([temp length]>0) {
                    emailMessage.toEmail= [NSString stringWithFormat:@"%@,%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Provideremail"],[[NSUserDefaults standardUserDefaults]objectForKey:@"Providersecondaryemail"]];
                }
                else{
                    emailMessage.toEmail= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Provideremail"]];
                }
                emailMessage.relayHost = @"smtp.gmail.com";
                emailMessage.requiresAuth = YES;
                emailMessage.login = @"adherencemedicationproject@gmail.com";
                emailMessage.pass = @"Medication@123";
                emailMessage.subject =@"Adherence Project: Missed Meds 3 weeks in a row";
                emailMessage.wantsSecure = YES;
                emailMessage.delegate = self;
               
              
                messageBody= [NSString stringWithFormat:@"\nFor three weeks in a row, Participant %@ has missed medication more than one day in a week. \n\nShe would like her provider to contact her. \n\nThank you.",[[NSUserDefaults standardUserDefaults]objectForKey:@"Participantusername"]];
                NSDictionary *plainMsg = [NSDictionary
                                          dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                                          messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
                emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
              [emailMessage send];
            }
            else if(([mailanswer.text isEqual:@"1"])&&([count isEqualToString:@"1"]))
            {
                //mail compose
                
                // NSLog(@"Start Sending");
                SKPSMTPMessage *emailMessage = [[SKPSMTPMessage alloc] init];
                emailMessage.fromEmail =@"adherencemedicationproject@gmail.com";
                
              temp=[[NSUserDefaults standardUserDefaults]objectForKey:@"Providersecondaryemail"];
                if ([temp length]>0) {
                    emailMessage.toEmail= [NSString stringWithFormat:@"%@,%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Provideremail"],[[NSUserDefaults standardUserDefaults]objectForKey:@"Providersecondaryemail"]];
                }
                else{
                    emailMessage.toEmail= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Provideremail"]];
                }
                emailMessage.relayHost = @"smtp.gmail.com";
                
                emailMessage.requiresAuth = YES;
                emailMessage.login = @"adherencemedicationproject@gmail.com";
                emailMessage.pass = @"Medication@123";//sender email password
                emailMessage.subject =@"Adherence Project: Missed Meds 4 weeks";
                //[NSString stringWithFormat:@"Hi User %@",[recorddict objectForKey:@"UserName"]];
                emailMessage.wantsSecure = YES;
                emailMessage.delegate = self;
                
                messageBody= [NSString stringWithFormat:@"\nOn at least four weeks, Participant %@ has missed medication more than one day in a week. \n\nShe would like her provider to contact her. \n\nThank you.",[[NSUserDefaults standardUserDefaults]objectForKey:@"Participantusername"]];
                
                
                NSDictionary *plainMsg = [NSDictionary
                                          dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                                          messageBody,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
                emailMessage.parts = [NSArray arrayWithObjects:plainMsg,nil];
              [emailMessage send];
              

            }
            
            
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Answer you submitted is invalid."];
            
            //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
    }
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Field should not be empty."];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
    }
    if ((a==1)&&([stringans isEqual:@"No"] ))
    {
       [HUD hide:YES];
       // NSLog(@"recorddict in answer1 %@",recorddict);
       [self performSegueWithIdentifier:@"sms25" sender:self];
    }
       
    
}

- (IBAction)yesact:(id)sender
{
    mailanswer.text=@"1";
    [yesb setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    
    [nob setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    stringans=@"Yes";
    next.hidden=NO;
};

- (IBAction)noact:(id)sender
{
    mailanswer.text=@"1";
    stringans=@"No";
    [yesb setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    
    [nob setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
     next.hidden=NO;
}

-(IBAction)clear:(id)sender
{
    mailanswer.text=@"";
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark SKPSMTPMessage Delegate Methods
- (void)messageState:(SKPSMTPState)messageState;
{
    
    
    //insert into database
    
    
}


-(void)messageSent:(SKPSMTPMessage *)message
{
 
    if (a==1)
    {
         [HUD hide:YES afterDelay:2];
       // NSLog(@"recorddict in answer1 %@",recorddict);
        [self performSegueWithIdentifier:@"sms25" sender:self];
        
    }
}
// On Failure
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    // open an alert with just an OK button
    
    // NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
   
}

- (void)viewDidLoad
{
    next.clipsToBounds = YES;
    next.layer.cornerRadius = 5.0f;
    NSString*sequenceocc=[[NSUserDefaults standardUserDefaults]objectForKey:@"Sequenceoccured"];
    NSString*sequenceoccmore=[[NSUserDefaults standardUserDefaults]objectForKey:@"Sequenceoccuredmorethan3"];
  cont= [recorddict objectForKey:@"seq"];
    count=[recorddict objectForKey: @"seqmorethan3"];
   NSLog(@"cont--seq value%@",cont);
   NSLog(@"count >4 value%@",count);
    NSLog(@"def --seq value%@",sequenceocc);
    NSLog(@"def >4value%@",sequenceoccmore);
    
    [super viewDidLoad];
    next.hidden=YES;
    sendingnum=0;
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
	// Do any additional setup after loading the view.
}

-(void)back
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"sms25"])
    {
        weekmessage2 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
      //  NSLog(@"recorddict in week first %@",recorddict);
        // destViewController.delegate=self;
        
    }
}

- (void)dealloc {
    
    [yesb release];
    [nob release];
    [next release];
    [super dealloc];
}
@end
