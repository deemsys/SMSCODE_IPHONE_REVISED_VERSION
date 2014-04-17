//
//  sideeffectsViewController.h
//  Breast Cancer
//
//  Created by DeemsysInc on 1/30/14.
//  Copyright (c) 2014 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sideeffectsViewController : UIViewController
{
    NSString *answer;
    IBOutlet UIButton *next;
}
@property (retain, nonatomic) IBOutlet UIButton *next;
- (IBAction)nextclicked:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *yesbutton;
@property (retain, nonatomic) IBOutlet UIButton *nobutton;
@property(assign)NSMutableDictionary *recorddict;
- (IBAction)yesclicked:(id)sender;
- (IBAction)noclicked:(id)sender;


@end
