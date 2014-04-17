//
//  changepasswordViewController.h
//  SMSIPAD
//
//  Created by DeemsysInc on 11/14/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextfieldScrollViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "JSON.h"


@interface changepasswordViewController : UITextfieldScrollViewController<MBProgressHUDDelegate>



{
    MBProgressHUD *HUD;
    BOOL isConnect;
    IBOutlet UITextField*oldpaswrd;
    IBOutlet UITextField*newpaswrd;
    IBOutlet UITextField*confirmpawrd;
    
    IBOutlet UIButton *update;
    
}
- (IBAction)changepassword:(id)sender;

@end
