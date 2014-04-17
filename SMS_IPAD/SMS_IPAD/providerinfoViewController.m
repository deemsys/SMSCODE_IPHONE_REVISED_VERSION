//
//  providerinfoViewController.m
//  SMSIPAD
//
//  Created by DeemsysInc on 11/14/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "providerinfoViewController.h"
#import "BlockAlertView.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "messageview.h"

@interface providerinfoViewController ()

@end

@implementation providerinfoViewController
//Calling Provider
-(IBAction)callprovider:(id)sender
{
  //  NSLog(@"Phone calling...");
    
    UIDevice *device = [UIDevice currentDevice];
    
  //  NSString *cellNameStr = [NSString stringWithFormat:@"%@",self.tableCellNames[indexPath.row]];
    
    if ([[device model] isEqualToString:@"iPhone"] ) {
        
        NSString *phoneNumber = [@"tel://" stringByAppendingString:providerphonebook.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    } else {
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Feature not supported."];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        // [alert setDestructiveButtonWithTitle:@"ok" block:nil];
        [alert setCancelButtonWithTitle:@"Ok" block:nil];
        [alert show];
        
        
    }
}
// Mailing Provider
-(IBAction)emailprovider:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setTitle:@"Email"];
        [controller setSubject:@""];
        [controller setMessageBody:@"Sent from Adherence Project App Mail" isHTML:YES];
        [controller setToRecipients:[NSArray arrayWithObjects:provideremail.text,providersecondary.text,nil]];
        [self presentViewController:controller animated:YES completion:NULL];
    }
    else{
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Your device doesn't support mailing feature."];
        [alert setCancelButtonWithTitle:@"Ok" block:nil];
        [alert show];

    }
    
}
// Composer sheet conditions
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    
    switch (result)
	{
		case MFMailComposeResultCancelled:
			//NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued");
			break;
		case MFMailComposeResultSaved:
			//NSLog(@"Mail saved: you saved the email message in the Drafts folder");
			break;
		case MFMailComposeResultSent:
			//NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send the next time the user connects to email");
			break;
		case MFMailComposeResultFailed:
			//NSLog(@"Mail failed: the email message was nog saved or queued, possibly due to an error");
			break;
		default:
			//NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES ];
}
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
    call.clipsToBounds = YES;
    call.layer.cornerRadius = 5.0f;
    email.clipsToBounds = YES;
    email.layer.cornerRadius = 5.0f;
    
    [super viewDidLoad];
if([[[NSUserDefaults standardUserDefaults]objectForKey:@"Providerusername"] length]>0)
{

    NSString *mobile1=[[NSUserDefaults standardUserDefaults]objectForKey:@"Providermobile"];
    NSRange range;
    range.length = 3;
    range.location = 3;
    providersecondary.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Providersecondaryemail"];
    providername.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Providerusername"];
    provideremail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Provideremail"];
    providerfirstname.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"Providerfirstname"];
    providerphonebook.text = [NSString stringWithFormat:@"(%@)%@-%@", [mobile1 substringToIndex:3], [mobile1 substringWithRange:range], [mobile1 substringFromIndex:6]];

    }
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Provider Details not found."];
        [alert setCancelButtonWithTitle:@"Ok" block:nil];
        [alert show];
   
    }


    
	// Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [call release];
    [email release];
    [super dealloc];
}
@end
