//
//  weeklymessage4.h
//  Breast Cancer
//
//  Created by DeemSysInc on 23/11/13.
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
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

#define FROM_EMAIL_PREF_KEY @"kFromEmailPreferenceKey"
#define TO_EMAIL_PREF_KEY @"kToEmailPreferenceKey"
#define RELAY_HOST_PREF_KEY @"kRelayHostPreferenceKey"
#define USE_SSL_BOOL_PREF_KEY @"kUseSSLBoolPreferenceKey"
#define USE_AUTH_BOOL_PREF_KEY @"kUseAuthBoolPreferenceKey"
#define AUTH_USERNAME_PREF_KEY @"kAuthUsernamePreferenceKey"
#define AUTH_PASSWORD_PREF_KEY @"kAuthPasswordPreferenceKey"
#define MESSAGE_SUBJECT_PREF_KEY @"kMessageSubjectPreferenceKey"
#define MESSAGE_BODY_PREF_KEY @"kMessageBodyPreferenceKey"
#define MESSAGE_SIG_PREF_KEY @"kMessageSigPreferenceKey"
#define SEND_IMAGE_BOOL_PREF_KEY @"kSendImageBoolPreferenceKey"
#define SEND_VCARD_BOOL_PREF_KEY @"kSendVcardBoolPreferenceKey"

@interface weeklymessage4 : UIViewController<SKPSMTPMessageDelegate,MBProgressHUDDelegate,UITextFieldDelegate>
{
     NSString *messageBody1;
    IBOutlet UILabel *question4;
    IBOutlet UITextField * answer4;
    NSMutableDictionary * recorddict;
    NSMutableDictionary * temp;
    int move;
    SKPSMTPState HighestState;
    IBOutlet UITextField *fromEmail;
    IBOutlet UITextField *toEmail;
    IBOutlet UITextField *relayHost;
    IBOutlet UISwitch *SSLSwitch;
    
    IBOutlet UISwitch *useAuthSwitch;
    IBOutlet UITextField *login;
    IBOutlet UITextField *password,*username;
    
    IBOutlet UITextField *subject;
    IBOutlet UITextField *messageBody;
    IBOutlet UITextField *sig;
    IBOutlet UISwitch *sendImageSwitch;
    IBOutlet UISwitch *sendVCFSwitch;
    
    IBOutlet UIActivityIndicatorView *Spinner;
    IBOutlet UIProgressView *ProgressBar;
    
    NSDictionary *prefKeyDictionary;
    
    IBOutlet UITextField*emailid;
    NSString *tempid;

    MBProgressHUD *HUD;
    BOOL isConnect;
    IBOutlet UIButton *yesbutton;
    IBOutlet UIButton *nobutton;
    
    IBOutlet UIButton *next;
    
}
-(IBAction)send:(id)sender;
-(IBAction)clear:(id)sender;
- (IBAction)yesselected:(id)sender;
- (IBAction)noselected:(id)sender;

@property(nonatomic)int move;
@property (nonatomic,retain) NSMutableDictionary * recorddict;
@end
