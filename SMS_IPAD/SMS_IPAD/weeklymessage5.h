//
//  weeklymessage5.h
//  Breast Cancer
//
//  Created by DeemSysInc on 23/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "BlockAlertView.h"
#import "JSON.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
@interface weeklymessage5 : UIViewController<MBProgressHUDDelegate>
{
    NSMutableDictionary * recorddict;
    NSMutableDictionary * temp;
    MBProgressHUD *HUD;
    BOOL isConnect;
    IBOutlet UIButton *end;
    
}
@property (nonatomic, retain) NSMutableDictionary * recorddict;
@property (retain, nonatomic) IBOutlet UIButton *contactprovider;
@property (nonatomic, retain) NSMutableDictionary * temp;
@end
