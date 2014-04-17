//
//  editprofile.h
//  Breast Cancer
//
//  Created by DeemSysInc on 21/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextfieldScrollViewController.h"
#import "BlockAlertView.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "JSON.h"
#import "ALPickerView.h"
#import "CYCustomMultiSelectPickerView.h"
@interface editprofile :UITextfieldScrollViewController<MBProgressHUDDelegate,CYCustomMultiSelectPickerViewDelegate>
{
    
    NSArray *entries;
    NSArray *entriesSelected;
	NSMutableDictionary *selectionStates;
    UILabel *showLbl;
    CYCustomMultiSelectPickerView *multiPickerView;
    NSMutableDictionary*recorddict;
    IBOutlet UITextField*fname;
    IBOutlet UILabel*username;
    IBOutlet UILabel*age;
    IBOutlet UITextField*city;
    IBOutlet UISegmentedControl*segedu;
    IBOutlet UITextField*email;
    IBOutlet UITextField*medical;
    IBOutlet UITextField*mobile;
    IBOutlet UILabel*provider;
    IBOutlet UILabel*time1;
    IBOutlet UILabel*time2;
    IBOutlet UILabel*time3;
    IBOutlet UIPickerView*timepick1;
    IBOutlet UIPickerView * timepick2;
    IBOutlet UIPickerView * timepick3;
    IBOutlet UIPickerView*grouppick;
    IBOutlet UILabel*grouppicker;
    IBOutlet UIPickerView*agepick;
    IBOutlet UILabel*agepicker;
    NSMutableArray*groupfinal;
    NSArray *groupdesc;
    NSString*selectgroupidold,*selectedgroupdescription;
    NSMutableArray*selectedgroupid;
    NSMutableArray*groupidlist;
    BOOL isConnect;
    MBProgressHUD *HUD;
    NSString*education;
    IBOutlet UISegmentedControl*gender;
    NSString *gend;
    IBOutlet UISegmentedControl*time1seg;
    IBOutlet UISegmentedControl*time2seg;
    IBOutlet UISegmentedControl*time3seg;
    NSString *t1,*t2,*t3;
    int a;
    NSArray *arrayWithIDs;
    NSArray *arrayWithIDvalues;
    NSString *postVarArrayString;
    NSString *postVarArrayStringid;
    IBOutlet UIButton *submit;
    
}
- (IBAction)submit:(id)sender;
-(IBAction)changetimeset1:(id)sender;
-(IBAction)changetimeset2:(id)sender;
-(IBAction)changetimeset3:(id)sender;
@property (nonatomic, strong) IBOutlet UIPickerView *agepick;
@property (nonatomic, strong) NSArray *ageArray;
- (IBAction)changeage:(id)sender;
@property (nonatomic, strong) IBOutlet UILabel*agepicker;
@property (nonatomic, strong) NSMutableArray *timearray;
@property (nonatomic,retain) IBOutlet UIPickerView *timepick1;
@property (nonatomic,retain) IBOutlet UIPickerView *timepick2;
@property (nonatomic,retain) IBOutlet UIPickerView *timepick3;
@property (nonatomic, strong) NSMutableArray *grouparray;
@property (nonatomic, strong) IBOutlet UIPickerView *grouppick;
@property (nonatomic, strong) IBOutlet UILabel*grouppicker;

@property (nonatomic, strong)IBOutlet UILabel*time1;

@property (nonatomic, strong)IBOutlet UILabel*time2;

@property (nonatomic, strong)IBOutlet UILabel*time3;
@property(nonatomic,retain)IBOutlet UISegmentedControl*segedu;
@property(nonatomic,retain)IBOutlet UISegmentedControl*gender;
@property (retain, nonatomic) IBOutlet UILabel *errorlabel;

- (IBAction)changeTimeInLabel1:(id)sender;
- (IBAction)changeTimeInLabel2:(id)sender;
- (IBAction)changeTimeInLabel3:(id)sender;
-(IBAction)changegroup:(id)sender;
-(IBAction)segeduselected:(id)sender;
-(IBAction)seggenderselected:(id)sender;
@property(assign) NSMutableDictionary*recorddict;
@end
