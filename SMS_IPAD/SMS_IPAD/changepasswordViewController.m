//
//  changepasswordViewController.m
//  SMSIPAD
//
//  Created by DeemsysInc on 11/14/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "changepasswordViewController.h"
#import "BlockAlertView.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "JSON.h"

@interface changepasswordViewController ()

@end

@implementation changepasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    update.clipsToBounds = YES;
    update.layer.cornerRadius = 5.0f;
    [super viewDidLoad];
    oldpaswrd.delegate=self;
    newpaswrd.delegate=self;
    confirmpawrd.delegate=self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changepassword:(id)sender
{
    
    NSString*oldpass=[[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    // NSLog(@" old password  %@",oldpass);
    if(([confirmpawrd.text length]!=0)&&([newpaswrd.text length]!=0)&&([oldpaswrd.text length]!=0))
    {
        NSString*confirmpass=confirmpawrd.text;
        if ([oldpaswrd.text isEqualToString:oldpass])
        {
            //  NSLog(@" old password  equal");
            
            if([newpaswrd.text isEqual:confirmpass])
            {
                [self updatepassword:oldpaswrd.text Newpassword:newpaswrd.text];
                
            }
            else
            {
                BlockAlertView*alert=[[BlockAlertView alloc]initWithTitle:@"" message:@"Password mismatch with Confirm Password."];
                [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                [alert show];
            }
        }
        else
        {
            BlockAlertView*alert=[[BlockAlertView alloc]initWithTitle:@"" message:@"Incorrect Old Password."];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
    }
    else
    {
        BlockAlertView*alert=[[BlockAlertView alloc]initWithTitle:@"" message:@"Enter all the required fields."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
    }
    
}
- (IBAction)hideKeyboard:(id)sender
{
  //  NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}
-(void)updatepassword:(NSString *)oldpass Newpassword:(NSString*)newpass
{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
    
	HUD.delegate = self;
	HUD.labelText = @"Updating";
    [HUD show:YES];
    
    NSString*logid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginid"];
    //  NSLog(@"logid %@",logid);
    
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
	switch (netStatus)
	{
		case NotReachable:
		{
			isConnect=NO;
		//	NSLog(@"Access Not Available");
			break;
		}
			
		case ReachableViaWWAN:
		{
			isConnect=YES;
		//	NSLog(@"Reachable WWAN");
			break;
		}
		case ReachableViaWiFi:
		{
			isConnect=YES;
         //   NSLog(@"Reachable WiFi");
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
        [HUD hide:YES afterDelay:0];
        return;
    }
    NSString *resultResponse2=[self HttpPostEntityFirstGroup:@"oldpassword" ForValue1:oldpaswrd.text  EntitySecond:@"newpassword" ForValue2:newpaswrd.text EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV" EntityFourth:@"loginid" ForValue4:logid ];
    NSError *error2;
    SBJSON *json2 = [[SBJSON new] autorelease];
    
    NSDictionary *luckyNumbers2 = [json2 objectWithString:resultResponse2 error:&error2];
    
    NSDictionary *itemsApp2 = [luckyNumbers2 objectForKey:@"serviceresponse"];
    ;
    if ( [[itemsApp2 objectForKey:@"success"] isEqualToString:@"Yes"])
    {
        HUD.labelText = @"Completed";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:2];
        [[NSUserDefaults standardUserDefaults]setObject:newpaswrd.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        oldpaswrd.text=@"";
        newpaswrd.text=@"";
        confirmpawrd.text=@"";
        
        BlockAlertView*alert=[[BlockAlertView alloc]initWithTitle:@"Successful" message:@"Password changed successfully."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
    }
    else
    {
        BlockAlertView*alert=[[BlockAlertView alloc]initWithTitle:@"" message:@"Failed to update password."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
    }
}
-(NSString *)HttpPostEntityFirstGroup:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2 EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3 EntityFourth:(NSString*)fourthEntity ForValue4:(NSString*)value4
{
    //updating password
    
    
    HUD.labelText = @"Synchronizing Data";
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@&%@=%@&%@=%@",firstEntity,value1,secondEntity,value2,fourthEntity,value4,thirdEntity,value3];
    
    
    // NSLog(@"%@",post);
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericUpdate.php?service=passwordUpdate"];
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
    
    
    // NSLog(@"%@ data",data);
    
    return data;
    
}

- (void)dealloc {
    [update release];
    [super dealloc];
}
@end

