//
//  smsmainviewcontrollerViewController.h
//  SMSIPAD
//
//  Created by DeemSysInc on 08/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextfieldScrollViewController.h"
#import "MBProgressHUD.h"

@interface smsmainviewcontrollerViewController :UITextfieldScrollViewController<UITextFieldDelegate,MBProgressHUDDelegate>{
    IBOutlet UITextField*phonenumber;
    IBOutlet UITextField*password;
    NSMutableDictionary*recorddict;
    int a,c;
    MBProgressHUD *HUD;
    BOOL isConnect;
    IBOutlet UIButton *signin;
    IBOutlet UIButton *signup;
    IBOutlet UIButton *forgot;
    IBOutlet UILabel *notregisterd;
    
    IBOutlet UIButton *rememberpass;
    
    
    
    
    
}
@property(nonatomic,retain)NSMutableDictionary*recorddict;
@property (retain, nonatomic) IBOutlet UITextField *phonenum;
@property (retain, nonatomic) IBOutlet UITextField *pass;
@property (retain, nonatomic) IBOutlet UIButton *rememberpass;

-(IBAction)signin:(id)sender;
- (IBAction)signup:(id)sender;


@end
