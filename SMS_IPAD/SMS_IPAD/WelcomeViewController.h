//
//  WelcomeViewController.h
//  SMSIPAD
//
//  Created by DeemSysInc on 12/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface WelcomeViewController : UIViewController<MBProgressHUDDelegate>
{
    IBOutlet UIButton *contactprovider;
    IBOutlet UIButton *dignout;
    NSMutableDictionary *recorddict;
    NSString*temp,*temp1,*temp2,*temp3,*temp4;
    MBProgressHUD *HUD;
    IBOutlet UILabel*welcome;
    BOOL isConnect;
    IBOutlet UIButton *eval;
    IBOutlet UISwitch *switch1;
    IBOutlet UILabel *resLabel1;
    IBOutlet UILabel*weekremaining;
    NSString*msgtextfile;
    NSString*msgdatefile,*msgflagfile,*msgfromfile;
    NSMutableArray *_AppDArr;
    NSMutableArray *_AppNArr;
    int weekcount,continuous,count1;
    NSMutableArray *week1,*week2,*week3,*week4,*week5,*week6;
    NSMutableArray *seqweek1,*seqweek2,*seqweek3,*seqweek4,*seqweek5,*seqweek6;
    NSMutableArray *filtereddate,*filteredweek,*filteredlogid;
    NSString *firstname1;
    NSString *username1;
     NSMutableArray *flagvalue;
    NSString *mobile1;
    NSString *email1;
    NSString *gender1;
    NSString *city1;
    NSString *education1;
    NSString *medical1;
    NSString *time11;
    NSString *time21;
    NSString *time31;
    NSString *provider1;
    NSString *group1;
    NSString *age1,*msgstream,*idnumber;
    NSTimer *timer;
    int count2;
    IBOutlet UIButton *review;
    NSMutableArray *msgfrom,*msgto,*msgdate,*msgstatus,*msgbody;
    int totalmessage;
    NSNumber *total2;
    IBOutlet UIButton *survey;
    IBOutlet UILabel *dailymessagelabel;
    IBOutlet UIButton *syncing;
    
    
}
- (IBAction)refresh:(id)sender;
@property (nonatomic, retain) UILabel *resLabel1;
@property (nonatomic, retain) UIButton*eval;
@property(nonatomic,retain)NSMutableDictionary*recorddict;
@property (retain, nonatomic) IBOutlet UIButton *dignout;
@property (retain, nonatomic) IBOutlet UIButton *contactprovider;

@property (nonatomic, strong) NSTimer *timer;
@end
