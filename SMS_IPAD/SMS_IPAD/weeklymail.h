//
//  weeklymail.h
//  Breast Cancer
//
//  Created by DeemSysInc on 30/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "BlockAlertView.h"
#import "JSON.h"


@interface weeklymail : UIViewController<SKPSMTPMessageDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    IBOutlet UITextView * mailmessage;
    IBOutlet UITextField * mailanswer;
       IBOutlet UIButton * send;
    IBOutlet UIButton * clear;
    NSMutableDictionary * recordict;
    NSString * cont;
    NSString * count;
    int sendingnum;
    NSString *stringans;
    IBOutlet UIButton *yesb;
    IBOutlet UIButton *nob;
    NSString *temp;
    NSString *tempid;
    NSString *messageBody;
    IBOutlet UIButton *next;
  
}
-(IBAction)send:(id)sender;

- (IBAction)yesact:(id)sender;
- (IBAction)noact:(id)sender;



@property (nonatomic,retain)NSMutableDictionary * recorddict;
@end
