//
//  stiings.h
//  Breast Cancer
//
//  Created by DeemSysInc on 06/12/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface stiings : UIViewController
{
    
    IBOutlet UILabel *settingslabel;
    IBOutlet UISwitch *switch1;
    MBProgressHUD *HUD;
    IBOutlet UIButton *providerinfo;
    IBOutlet UIButton *changepass;
    
    
}


- (IBAction)settingstoggle:(id)sender;

@property (nonatomic, retain) UISwitch *switch1;
@property (nonatomic, retain) UILabel *resLabel1;
@end
