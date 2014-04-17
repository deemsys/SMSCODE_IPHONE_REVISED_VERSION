//
//  stiings.m
//  Breast Cancer
//
//  Created by DeemSysInc on 06/12/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "stiings.h"
#import "BlockAlertView.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "JSON.h"


@interface stiings ()

@end

@implementation stiings
@synthesize switch1;


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
    providerinfo.clipsToBounds = YES;
    providerinfo.layer.cornerRadius = 5.0f;
    changepass.clipsToBounds = YES;
    changepass.layer.cornerRadius = 5.0f;
    [super viewDidLoad];
    NSString *mes=[[NSUserDefaults standardUserDefaults]objectForKey:@"messagestream"];
    if ([mes isEqual:@"0"]) {
        [switch1 setOn:NO];
        settingslabel.text=@"Off";
    }
    else
    {
        [switch1 setOn:YES];
        settingslabel.text=@"On";
    }

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [settingslabel release];
    [switch1 release];
    [providerinfo release];
    [changepass release];
    [super dealloc];
}
// Json posting data for message stream
-(NSString *)HttpPostEntityFirstmessagestream:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2 EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    //manually start stop message stream
    
    HUD.labelText = @"Synchronizing Data";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@&%@=%@",firstEntity,value1,secondEntity,value2,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericUpdate.php?service=messageStreamUpdate"];
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
//Actions Conditions

- (IBAction)settingstoggle:(id)sender
{
    NSString*select;
	if (switch1.on)
    {
        select=@"1";
        settingslabel.text = @"On";
    }
	else
    {
        
        select=@"0";
        settingslabel.text = @"Off";
    }
    [[NSUserDefaults standardUserDefaults]setObject:select forKey:@"messagestream"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSString *resultResponse=[self HttpPostEntityFirstmessagestream:@"patientid" ForValue1:[[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"] EntitySecond:@"messagestream" ForValue2:select EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    
    
    
    
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
            
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Message stream updated successfully."];
            
            [HUD hide:YES];
            
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
            
            
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Message stream updated failed."];
            
            [HUD hide:YES];
            
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
            
        }
        
        
    }
    

}
@end
