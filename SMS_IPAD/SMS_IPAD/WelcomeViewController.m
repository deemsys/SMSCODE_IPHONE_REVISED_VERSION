//
//  WelcomeViewController.m
//  SMSIPAD
//
//  Created by DeemSysInc on 12/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "JSON.h"
#import "BlockAlertView.h"
#import "dailymsglistViewController.h"
#import "fileMngr.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
@synthesize recorddict;
@synthesize dignout;
@synthesize resLabel1;
@synthesize eval;
@synthesize timer;
@synthesize contactprovider;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)back
{
    
}

-(void)weekupdate
{
    NSString *useridnumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    NSString *resultResponse1=[self HttpPostEntityFirstweekly:@"loginid" ForValue1:useridnumber EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSError *error1;
    SBJSON *json1 = [[SBJSON new] autorelease];
    // NSLog(@"response %@",resultResponse);
	NSDictionary *luckyNumbers1 = [json1 objectWithString:resultResponse1 error:&error1];
    NSDictionary *itemsApp1 = [luckyNumbers1 objectForKey:@"serviceresponse"];
    NSArray *items1App1=[itemsApp1 objectForKey:@"Weekly_logs List"];
    week1=[[NSMutableArray alloc]init];
    week2=[[NSMutableArray alloc]init];
    week3=[[NSMutableArray alloc]init];
    week4=[[NSMutableArray alloc]init];
    week5=[[NSMutableArray alloc]init];
    week6=[[NSMutableArray alloc]init];
    NSDictionary *arrayList2;
    // NSLog(@"items1app %@",luckyNumbers);
    for (id anUpdate1 in items1App1)
    {
        NSDictionary *arrayList2=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
        [week1 addObject:[arrayList2 objectForKey:@"log_id"]];
        [week2 addObject:[arrayList2 objectForKey:@"week"]];
        [week3 addObject:[arrayList2 objectForKey:@"date_time"]];
        [week4 addObject:[arrayList2 objectForKey:@"continuous"]];
        [week5 addObject:[arrayList2 objectForKey:@"count"]];
        [week6 addObject:[arrayList2 objectForKey:@"status"]];
        
        
    }
    weekcount=0;
    for (int i=0; i<[week6 count ]; i++)
    {
        if([[week6 objectAtIndex:i] isEqual:@"0"])
        {
            weekcount++;
        }
    }
    if(weekcount==0)
    {
        eval.hidden=YES;
        weekremaining.text=[NSString stringWithFormat:@"You have completed all your weekly surveys."];
    }
    else
    {
        eval.hidden=NO;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Weekly surveys available : %d ",weekcount]];
        NSRange selectedRange = NSMakeRange(26,3); // 4 characters, starting at index 22
        
        [string beginEditing];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]
                       range:selectedRange];
        
        [string endEditing];
        [weekremaining setAttributedText:string];
    }
    filtereddate=[[NSMutableArray alloc]init];
    filteredlogid=[[NSMutableArray alloc]init];
    filteredweek=[[NSMutableArray alloc]init];
    
    
    NSDate *date=[NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentDate = [dateFormatter stringFromDate:date];
   // NSLog(@"current date %@",currentDate);
    int count=0;
    for(int i=0;i<[week3 count];i++)
    {
        
        
        if ([currentDate compare:[week3 objectAtIndex:i]] == NSOrderedDescending)
        {
            [filtereddate addObject:[week3 objectAtIndex:i]];
            [filteredlogid addObject:[week1 objectAtIndex:i]];
            [filteredweek addObject:[week2 objectAtIndex:i]];
            // NSLog(@"now is later than date2");
            count++;
            
            
        }
        else if ([currentDate compare:[week3 objectAtIndex:i]] == NSOrderedAscending)
        {
            // NSLog(@"date1 is earlier than date2");
            
        }
        else {
            //NSLog(@"dates are the same");
            count++;
            [filtereddate addObject:[week3 objectAtIndex:i]];
            [filteredlogid addObject:[week1 objectAtIndex:i]];
            [filteredweek addObject:[week2 objectAtIndex:i]];
            
            
        }
        
    }
   // NSLog(@"no of pending weeks %d",count);
    if(count==0)
    {
        eval.hidden=YES;
        weekremaining.text=[NSString stringWithFormat:@"You have completed all your weekly surveys."];
    }
    else
    {
        eval.hidden=NO;
//        weekremaining.text=[NSString stringWithFormat:@"You have overdue survey : %d",count];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Weekly surveys available : %d ",weekcount]];
        NSRange selectedRange = NSMakeRange(26,3); // 4 characters, starting at index 22
        
        [string beginEditing];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]
                       range:selectedRange];
        
        [string endEditing];
        [weekremaining setAttributedText:string];
    }
   // NSLog(@"filtered date %@",filtereddate);
   // NSLog(@"filtered logid %@",filteredlogid);
   // NSLog(@"filtered week%@",filteredweek);
    if([filteredlogid count]>0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:[filtereddate objectAtIndex:0] forKey:@"Weekdate"];
        [[NSUserDefaults standardUserDefaults]setObject:[filteredweek objectAtIndex:0] forKey:@"Weeknum"];
        [[NSUserDefaults standardUserDefaults]setObject:[filteredlogid objectAtIndex:0] forKey:@"Weeklogid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
        
    }
    
}

-(void)sunc
{
    
    
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    
    
	HUD.delegate = self;
	HUD.labelText = @"Loading";
    [HUD show:YES];
    [self performSelector:@selector(sunc1) withObject:nil afterDelay:0.2 ];
}
-(IBAction)sunc1
{
    
    //NSLog(@"Sunc called automatically");
    
    // [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSString *useridnumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    
    
    
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
    
    //  NSLog(@"patid %@",useridnumber);
    
    
    NSString *resultResponse=[self HttpPostEntityFirst:@"patid" ForValue1:useridnumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSError *error;
    SBJSON *json = [[SBJSON new] autorelease];
    // NSLog(@"response %@",resultResponse);
	NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
    NSDictionary *itemsApp = [luckyNumbers objectForKey:@"serviceresponse"];
    NSArray *items1App=[itemsApp objectForKey:@"Provider Info"];
    
    NSDictionary *arrayList1;
    // NSLog(@"items1app %@",luckyNumbers);
    for (id anUpdate1 in items1App)
    {
        NSDictionary *arrayList1=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
        
        
        temp=[arrayList1 objectForKey:@"adminusername"];
        temp1 =[arrayList1 objectForKey:@"adminfirstname"];
        temp2 =[arrayList1 objectForKey:@"adminmobile"];
        temp3 =[arrayList1 objectForKey:@"adminemail"];
        temp4=[arrayList1 objectForKey:@"adminsecondaryemail"];
        
        
    }
    //Fetching Weekly Evaluation details
    
    NSString *resultResponse1=[self HttpPostEntityFirstweekly:@"loginid" ForValue1:useridnumber EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSError *error1;
    SBJSON *json1 = [[SBJSON new] autorelease];
    // NSLog(@"response %@",resultResponse);
	NSDictionary *luckyNumbers1 = [json1 objectWithString:resultResponse1 error:&error1];
    NSDictionary *itemsApp1 = [luckyNumbers1 objectForKey:@"serviceresponse"];
    NSArray *items1App1=[itemsApp1 objectForKey:@"Weekly_logs List"];
    week1=[[NSMutableArray alloc]init];
    week2=[[NSMutableArray alloc]init];
    week3=[[NSMutableArray alloc]init];
    week4=[[NSMutableArray alloc]init];
    week5=[[NSMutableArray alloc]init];
    week6=[[NSMutableArray alloc]init];
    NSDictionary *arrayList2;
    // NSLog(@"items1app %@",luckyNumbers);
    for (id anUpdate1 in items1App1)
    {
        NSDictionary *arrayList2=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
        [week1 addObject:[arrayList2 objectForKey:@"log_id"]];
        [week2 addObject:[arrayList2 objectForKey:@"week"]];
        [week3 addObject:[arrayList2 objectForKey:@"date_time"]];
        [week4 addObject:[arrayList2 objectForKey:@"continuous"]];
        [week5 addObject:[arrayList2 objectForKey:@"count"]];
        [week6 addObject:[arrayList2 objectForKey:@"status"]];
        
        
    }
    weekcount=0;
    for (int i=0; i<[week6 count ]; i++)
    {
        if([[week6 objectAtIndex:i] isEqual:@"0"])
        {
            weekcount++;
        }
    }
    if(weekcount==0)
    {
        eval.hidden=YES;
        weekremaining.text=[NSString stringWithFormat:@"You have completed all your weekly surveys."];
    }
    else
    {
        eval.hidden=NO;
//        weekremaining.text=[NSString stringWithFormat:@"You have overdue survey : %d",weekcount];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Weekly surveys available : %d ",weekcount]];
        NSRange selectedRange = NSMakeRange(26,3); // 4 characters, starting at index 22
        
        [string beginEditing];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]
                       range:selectedRange];
        
        [string endEditing];
        [weekremaining setAttributedText:string];
    }
    filtereddate=[[NSMutableArray alloc]init];
    filteredlogid=[[NSMutableArray alloc]init];
    filteredweek=[[NSMutableArray alloc]init];
    
    
    NSDate *date=[NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentDate = [dateFormatter stringFromDate:date];
  //  NSLog(@"current date %@",currentDate);
    int count=0;
    for(int i=0;i<[week3 count];i++)
    {
        
        
        if ([currentDate compare:[week3 objectAtIndex:i]] == NSOrderedDescending)
        {
            [filtereddate addObject:[week3 objectAtIndex:i]];
            [filteredlogid addObject:[week1 objectAtIndex:i]];
            [filteredweek addObject:[week2 objectAtIndex:i]];
            // NSLog(@"now is later than date2");
            count++;
            
            
        }
        else if ([currentDate compare:[week3 objectAtIndex:i]] == NSOrderedAscending)
        {
            // NSLog(@"date1 is earlier than date2");
            
        }
        else {
            //NSLog(@"dates are the same");
            count++;
            [filtereddate addObject:[week3 objectAtIndex:i]];
            [filteredlogid addObject:[week1 objectAtIndex:i]];
            [filteredweek addObject:[week2 objectAtIndex:i]];
            
            
        }
        
    }
  //  NSLog(@"no of pending weeks %d",count);
    if(count==0)
    {
        eval.hidden=YES;
        weekremaining.text=[NSString stringWithFormat:@"You have completed all your weekly surveys."];
    }
    else
    {
        eval.hidden=NO;
//        weekremaining.text=[NSString stringWithFormat:@"You have overdue survey : %d",count];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Weekly surveys available : %d ",weekcount]];
        NSRange selectedRange = NSMakeRange(26,3); // 4 characters, starting at index 22
        
        [string beginEditing];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]
                       range:selectedRange];
        
        [string endEditing];
        [weekremaining setAttributedText:string];
    }
   // NSLog(@"filtered date %@",filtereddate);
   // NSLog(@"filtered logid %@",filteredlogid);
   // NSLog(@"filtered week%@",filteredweek);
    if([filteredlogid count]>0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:[filtereddate objectAtIndex:0] forKey:@"Weekdate"];
        [[NSUserDefaults standardUserDefaults]setObject:[filteredweek objectAtIndex:0] forKey:@"Weeknum"];
        [[NSUserDefaults standardUserDefaults]setObject:[filteredlogid objectAtIndex:0] forKey:@"Weeklogid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
    {
        
    }
    NSString *resultResponse2=[self HttpPostEntityFirstparticipant:@"loginid" ForValue1:useridnumber  EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    NSError *error2;
    
    SBJSON *json2 = [[SBJSON new] autorelease];
    // NSLog(@"response %@",resultResponse);
	NSDictionary *luckyNumbers2 = [json2 objectWithString:resultResponse2 error:&error2];
    NSDictionary *itemsApp2 = [luckyNumbers2 objectForKey:@"serviceresponse"];
    NSArray *items1App2=[itemsApp2 objectForKey:@"Patient info"];
    
    NSDictionary *arrayList3;
    if ([[itemsApp2 objectForKey:@"success"] isEqualToString:@"Yes"])
    {
        for (id anUpdate1 in items1App2)
        {
            NSDictionary *arrayList3=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
            
            firstname1=[arrayList3 objectForKey:@"firstname"];
            username1 =[arrayList3 objectForKey:@"username"];
            mobile1 =[arrayList3 objectForKey:@"mobilenum"];
            email1 =[arrayList3 objectForKey:@"email"];
            gender1 =[arrayList3 objectForKey:@"gender"];
            city1 =[arrayList3 objectForKey:@"city"];
            education1=[arrayList3 objectForKey:@"education"];
            medical1 =[arrayList3 objectForKey:@"medical"];
            time11 =[arrayList3 objectForKey:@"time1"];
            time21 =[arrayList3 objectForKey:@"time2"];
            time31 =[arrayList3 objectForKey:@"time3"];
            provider1 =[arrayList3 objectForKey:@"providername"];
            group1 =[arrayList3 objectForKey:@"group"];
            age1 =[arrayList3 objectForKey:@"age"];
            msgstream=[arrayList3 objectForKey:@"messagestream"];
            idnumber=[arrayList3 objectForKey:@"idnumber"];
       
            
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:username1 forKey:@"Participantusername"];
        [[NSUserDefaults standardUserDefaults]setObject:email1 forKey:@"Participantemail"];
        [[NSUserDefaults standardUserDefaults]setObject:gender1 forKey:@"gender"];
         [[NSUserDefaults standardUserDefaults]setObject:idnumber forKey:@"idnumber"];
        NSLog(@"idnumber %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"idnumber"]);
             
       
         
    }
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Userid not found."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
        
    }
      [[NSUserDefaults standardUserDefaults]setObject:msgstream forKey:@"messagestream"];
    [[NSUserDefaults standardUserDefaults]setObject:temp forKey:@"Providerusername"];
    [[NSUserDefaults standardUserDefaults]setObject:temp1 forKey:@"Providerfirstname"];
    [[NSUserDefaults standardUserDefaults]setObject:temp2 forKey:@"Providermobile"];
    [[NSUserDefaults standardUserDefaults]setObject:temp3 forKey:@"Provideremail"];
     [[NSUserDefaults standardUserDefaults]setObject:temp4 forKey:@"Providersecondaryemail"];
   

   
    
    HUD.labelText = @"Completed";
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:0];
    
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    
    
    
}

-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    
    //getting provider details
    HUD.labelText = @"Synchronizing Data";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericSelect.php?service=providerSelect"];
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
    //  NSLog(@" post %@ ",post);
    
    // NSLog(@"%@ ",data);
    
    return data;
    
}
-(NSString *)HttpPostEntityFirstweekly:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    //getting weekly evaluation unfilled dates
    
    HUD.labelText = @"Synchronizing Data";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericSelect.php?service=weeklyevaluationSelect"];
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
    //NSLog(@" post %@ ",post);
    
    //NSLog(@"%@ ",data);
    
    return data;
    
}
-(NSString *)HttpPostEntityFirstsequence:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    //getting weekly evaluation sequence occurence
    HUD.labelText = @"Synchronizing Data";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericSelect.php?service=sequenceSelect"];
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
    //  NSLog(@" post %@ ",post);
    
    // NSLog(@"result %@ ",data);
    
    return data;
    
}
-(NSString *)HttpPostEntityFirstparticipant:(NSString*)firstEntity ForValue1:(NSString*)value1  EntityThird:(NSString*)thirdEntity ForValue3:(NSString*)value3
{
    //Getting Participants detail
    
    HUD.labelText = @"Synchronizing Data";
    
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&%@=%@",firstEntity,value1,thirdEntity,value3];
  NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericSelect.php?service=participantSelect"];

    
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
    //   NSLog(@" post %@ ",post);
    
// NSLog(@"%@ ",data);
    
    return data;
    
}



- (void)viewDidLoad
{
    syncing.clipsToBounds = YES;
    syncing.layer.cornerRadius = 5.0f;
    review.clipsToBounds = YES;
    review.layer.cornerRadius = 5.0f;
    survey.clipsToBounds = YES;
    survey.layer.cornerRadius = 5.0f;
    dignout.clipsToBounds = YES;
    dignout.layer.cornerRadius = 5.0f;
    contactprovider.clipsToBounds = YES;
    contactprovider.layer.cornerRadius = 5.0f;


    [super viewDidLoad];
    [self sunc];
   [self weekupdate];
  [self sequencycheck];
    
    welcome.text=[NSString stringWithFormat:@"Welcome %@ !",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
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



-(void)sequencycheck
{
    NSString *useridnumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginid"];
    NSString *resultResponse2=[self HttpPostEntityFirstsequence:@"loginid" ForValue1:useridnumber EntityThird:@"authkey" ForValue3:@"rzTFevN099Km39PV"];
    
    NSError *error2;
    SBJSON *json2 = [[SBJSON new] autorelease];
    // NSLog(@"response %@",resultResponse);
	NSDictionary *luckyNumbers2 = [json2 objectWithString:resultResponse2 error:&error2];
    NSDictionary *itemsApp2 = [luckyNumbers2 objectForKey:@"serviceresponse"];
    NSArray *items1App2=[itemsApp2 objectForKey:@"Weekly_logs sequence List"];
    seqweek1=[[NSMutableArray alloc]init];
    seqweek2=[[NSMutableArray alloc]init];
    seqweek3=[[NSMutableArray alloc]init];
    seqweek4=[[NSMutableArray alloc]init];
    seqweek5=[[NSMutableArray alloc]init];
    seqweek6=[[NSMutableArray alloc]init];
    NSDictionary *arrayList22;
    // NSLog(@"items1app %@",luckyNumbers);
    for (id anUpdate1 in items1App2)
    {
        NSDictionary *arrayList22=[(NSDictionary*)anUpdate1 objectForKey:@"serviceresponse"];
        [seqweek1 addObject:[arrayList22 objectForKey:@"log_id"]];
        [seqweek2 addObject:[arrayList22 objectForKey:@"week"]];
        [seqweek3 addObject:[arrayList22 objectForKey:@"date_time"]];
        [seqweek4 addObject:[arrayList22 objectForKey:@"continuous"]];
        [seqweek5 addObject:[arrayList22 objectForKey:@"count"]];
        [seqweek6 addObject:[arrayList22 objectForKey:@"status"]];
        
        
    }
    continuous=0;
    int seq;
    NSString *occ;
//    NSLog(@"seqid %@",seqweek1);
//    NSLog(@"seqweek %@",seqweek2);
//    NSLog(@"seqcont %@",seqweek4);
//    NSLog(@"seqcount %@",seqweek5);
//    NSLog(@"seqstatus %@",seqweek6);
    int j;
    for(int i=0;i<[seqweek4 count];i++)
    {
        j=i+1;
        
        if([[seqweek4 objectAtIndex:i] isEqualToString:@"1"])
        {
            continuous++;
            if (continuous==2)
            {
                if (j<[seqweek4 count]) {
                    seq=0;
                    continuous=0;
                    continue;
                }
                else if (j==[seqweek4 count])
                {
                seq=1;
                break;
                }
            }
        }
        else
        {
            seq=0;
            continuous=0;
        }
        
    }
    
    if (seq==1) {
        occ=@"1";
//       NSLog(@"occ %@ ",occ);
        [[NSUserDefaults standardUserDefaults]setObject:occ forKey:@"Sequenceoccured"];
    }
    else
    {
        occ=@"0";
//      NSLog(@"occ %@",occ);
        [[NSUserDefaults standardUserDefaults]setObject:occ forKey:@"Sequenceoccured"];
    }
    // NSLog(@"couvt %@",seqweek5);
    count1=0;
    for (int j=0; j<[seqweek5 count]; j++)
    {
        if([[seqweek5 objectAtIndex:j] isEqual:@"1"])
        {
            count1++;
            
            
        }
        
    }
    if (count1>=3)
    {
        occ=@"1";
//      NSLog(@"occ more than 3 %@",occ);
        [[NSUserDefaults standardUserDefaults]setObject:occ forKey:@"Sequenceoccuredmorethan3"];
    }
    else
    {
        occ=@"0";
//        NSLog(@"occ not more than 3 %@",occ);
        [[NSUserDefaults standardUserDefaults]setObject:occ forKey:@"Sequenceoccuredmorethan3"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"daily"])
    {
        dailymsglistViewController *destViewController = [segue destinationViewController];
        
    
        
    }
    
    
    
    
}





- (void)dealloc {
    [review release];
    [survey release];
    [dailymessagelabel release];
    [syncing release];
    [dignout release];
  
    [contactprovider release];
  
    [super dealloc];
}
@end
