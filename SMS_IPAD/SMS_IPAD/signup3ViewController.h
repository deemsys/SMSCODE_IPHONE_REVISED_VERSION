//
//  signup3ViewController.h
//  SMSIPAD
//
//  Created by DeemSysInc on 12/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "signup3ViewController.h"
#import "BlockAlertView.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "signup2ViewController.h"
#import "signupViewController.h"
#import "ALPickerView.h"
#import "CYCustomMultiSelectPickerView.h"

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

@interface signup3ViewController : UIViewController<SKPSMTPMessageDelegate,MBProgressHUDDelegate,CYCustomMultiSelectPickerViewDelegate>
{
    NSArray *entries;
    NSArray *entriesSelected;
	NSMutableDictionary *selectionStates;
    UILabel *showLbl;
    
    CYCustomMultiSelectPickerView *multiPickerView;
    NSMutableDictionary*recorddict;
    IBOutlet UIPickerView*timepick1;
    IBOutlet UILabel*timepicker1;
    IBOutlet UILabel*timepicker2;
    IBOutlet UILabel*timepicker3;
    IBOutlet UIPickerView * timepick2;
    IBOutlet UIPickerView * timepick3;
    IBOutlet UIPickerView*providerpick;
    IBOutlet UILabel*providerpicker;
    IBOutlet UIPickerView*grouppick;
    IBOutlet UILabel*grouppicker;
    int c,a;
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
    MBProgressHUD *HUD;
    BOOL isConnect;
    NSMutableArray*groupfinal;
    NSMutableArray*selectedgroupid;
    NSArray*groupidlist;
    IBOutlet UISegmentedControl*time1;
    IBOutlet UISegmentedControl*time2;
    IBOutlet UISegmentedControl*time3;
    NSString *t1,*t2,*t3;
    
    IBOutlet UIButton *reset;
    
    IBOutlet UIButton *reset_new;
    IBOutlet UIButton *submit;
    
}
@property(nonatomic,retain)NSMutableDictionary *recorddict;
@property (nonatomic, strong) NSMutableArray *timearray;
@property (nonatomic,retain) IBOutlet UIPickerView *timepick1;
@property (nonatomic,retain) IBOutlet UIPickerView *timepick2;
@property (nonatomic,retain) IBOutlet UIPickerView *timepick3;
@property(nonatomic,retain)IBOutlet UILabel *timepicker1;
@property(nonatomic,retain)IBOutlet UILabel *timepicker2;
@property(nonatomic,retain)IBOutlet UILabel *timepicker3;
@property (nonatomic, strong) NSMutableArray *providerarray;
@property (nonatomic, strong) NSMutableArray *grouparray;

@property (nonatomic, strong) IBOutlet UIPickerView *providerpick;
@property (nonatomic, strong) IBOutlet UIPickerView *grouppick;
@property (nonatomic, strong) IBOutlet UILabel*providerpicker;
@property (nonatomic, strong) IBOutlet UILabel*grouppicker;

-(IBAction)changetimeset1:(id)sender;
-(IBAction)changetimeset2:(id)sender;
-(IBAction)changetimeset3:(id)sender;

- (IBAction)changeTimeInLabel1:(id)sender;
- (IBAction)changeTimeInLabel2:(id)sender;
- (IBAction)changeTimeInLabel3:(id)sender;
-(IBAction)changeprovider:(id)sender;
-(IBAction)changegroup:(id)sender;
-(IBAction)submit:(id)sender;
- (IBAction)reset_new_action:(id)sender;

@end

