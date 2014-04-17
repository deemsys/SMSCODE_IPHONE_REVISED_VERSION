//
//  forgetpasswordViewController.h
//  SMSIPAD
//
//  Created by DeemsysInc on 11/14/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "JSON.h"
#import "MBProgressHUD.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

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


@interface forgetpasswordViewController :UIViewController <SKPSMTPMessageDelegate,MBProgressHUDDelegate>

{
    MBProgressHUD *HUD;
    BOOL isConnect;
    NSString*password1;
    SKPSMTPState HighestState;
    IBOutlet UITextField *fromEmail;
    IBOutlet UITextField *toEmail;
    IBOutlet UITextField *relayHost;
    IBOutlet UISwitch *SSLSwitch;
    
    IBOutlet UILabel *emailerr;
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
    IBOutlet UIButton *submit;
    
    
}
@property (retain, nonatomic) IBOutlet UILabel *emailerr;

- (IBAction)sendpassword:(id)sender;

@end
