//
//  weekmessage2.h
//  Breast Cancer
//
//  Created by DeemSysInc on 25/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weekmessage2 : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UILabel *question2;
    IBOutlet UITextField * answer2;
    IBOutlet UILabel *inforce;
    NSMutableDictionary * recorddict;
    NSString * reinforce;
    NSMutableDictionary * temp;
    IBOutlet UILabel * hiddenfield;
    IBOutlet UIButton * send;
    IBOutlet UIButton * clear;
    IBOutlet UIButton * next;
    IBOutlet UIButton *iforget;
    IBOutlet UIButton *sideeffects;
    IBOutlet UIButton *ranout;
    IBOutlet UIButton *others;
    IBOutlet UILabel *forgotlabel;
    IBOutlet UILabel *sideeffectlabel;
    IBOutlet UILabel *ranoutlabel;
    IBOutlet UILabel *otherslabel;
    IBOutlet UILabel *costtoomuch;
    IBOutlet UILabel *takingtoomany;
    IBOutlet UILabel *friendsdiscouraged;
    IBOutlet UILabel *dontliketotake;
    IBOutlet UIButton *costtoomuchbutton;
    IBOutlet UIButton *toomanymedbutton;
    IBOutlet UIButton *friendsdiscouragedbutton;
    IBOutlet UIButton *dontliketakingmedbutton;
    IBOutlet UIButton *delay;
    
}
@property (retain, nonatomic) IBOutlet UIButton *delay;

-(IBAction)send:(id)sender;
-(IBAction)clear:(id)sender;
-(IBAction)next:(id)sender;
- (IBAction)forgotsel:(id)sender;
- (IBAction)costtoomuch:(id)sender;
- (IBAction)friendsdiscouraged:(id)sender;
- (IBAction)takingtoomanymedications:(id)sender;
- (IBAction)dontliketakingmed:(id)sender;
- (IBAction)sideeffectselected:(id)sender;
- (IBAction)ranoutselected:(id)sender;
- (IBAction)delayselected:(id)sender;

- (IBAction)othersselected:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *next;





@property(nonatomic , retain) NSMutableDictionary * recorddict;
@end
