//
//  participantprofile.h
//  Breast Cancer
//
//  Created by DeemSysInc on 21/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "JSON.h"
#import "MBProgressHUD.h"

@interface participantprofile : UIViewController<UIPickerViewAccessibilityDelegate,UIPickerViewDataSource,UIScrollViewDelegate,MBProgressHUDDelegate>

{
    MBProgressHUD *HUD;
    BOOL isConnect;
    NSString *firstname1;
    NSString *username1;
    NSString *mobile1;
    NSString *email1;
    NSString *gender1;
    NSString *city1;
    NSString *education1;
    NSString *medical1;
    NSString *time11;
    NSString *time21;
    NSString *time31;
    NSString *time11fm;
    NSString *time21fm;
    NSString *time31fm;
    NSString *provider1;
    IBOutlet UILabel *grouplistnames;
    NSString *group1;
      NSMutableArray *groupid,*groupdes,*participantgroupname,*participantgroupid,*partid;
   
    NSString *age1;
    NSMutableDictionary*recorddict;
    NSMutableArray*groupname,*createdby;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel * firstname;
    IBOutlet UILabel * username;
    IBOutlet UILabel * mobilenumber;
    IBOutlet UILabel * gender;
    IBOutlet UILabel * city;
    IBOutlet UILabel * education;
    IBOutlet UILabel * medical;
    IBOutlet UILabel * time1;
    IBOutlet UILabel * time2;
    IBOutlet UILabel * time3;
    IBOutlet UILabel * provider;
    IBOutlet UIPickerView *group;
    IBOutlet UILabel * age;
    IBOutlet UILabel*emailid; NSMutableArray *grouplist;
    
    IBOutlet UIButton *edit;
}
-(IBAction)edit:(id)sender;
@property(nonatomic,retain)NSMutableDictionary*recorddict;

@end







