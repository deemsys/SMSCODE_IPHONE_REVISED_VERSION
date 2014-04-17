//
//  signup2ViewController.h
//  SMSIPAD
//
//  Created by DeemSysInc on 12/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextfieldScrollViewController.h"

@interface signup2ViewController :UITextfieldScrollViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSMutableDictionary *recorddict;
    IBOutlet UIPickerView*agepick;
    IBOutlet UILabel*agepicker;
    IBOutlet UISegmentedControl*seggender;
    IBOutlet UILabel*gender;
    IBOutlet UITextView*medicaldetails;
    IBOutlet UITextField *city;
    IBOutlet UISegmentedControl*educationseg;
    NSString *edu;
    
    int c;

    IBOutlet UIButton *reset;
    
    IBOutlet UIButton *cancel;
    IBOutlet UIButton *next;
}
@property (nonatomic, strong) IBOutlet UIPickerView *agepick;
@property(assign)NSMutableDictionary *recorddict;
@property(nonatomic,retain)UISegmentedControl*seggender;
@property (nonatomic, strong) NSArray *ageArray;
@property (nonatomic, strong) IBOutlet UILabel * gender;
-(IBAction)seggenderclicked:(id)sender;
- (IBAction)changeage:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
@property (nonatomic, strong) IBOutlet UILabel*agepicker;
@property(nonatomic,retain)IBOutlet UISegmentedControl*educationseg;
@property (retain, nonatomic) IBOutlet UILabel *zipcodeerr;
-(IBAction)segeduclicked:(id)sender;
- (IBAction)cancel:(id)sender;

@end
