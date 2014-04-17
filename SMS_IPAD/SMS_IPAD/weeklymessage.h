//
//  weeklymessage.h
//  Breast Cancer
//
//  Created by DeemSysInc on 20/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weeklymessage : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UILabel *question1;
    IBOutlet UITextField * answer1;
    NSMutableDictionary *recorddict;
    NSString*seq;
    NSString*seqmorethan3;
    IBOutlet UISegmentedControl *seg;
    
    IBOutlet UIButton *next;
}
-(IBAction)send:(id)sender;
-(IBAction)clear:(id)sender;
- (IBAction)ahtrating:(id)sender;

@property(nonatomic,retain)NSMutableDictionary * recorddict;
@end
