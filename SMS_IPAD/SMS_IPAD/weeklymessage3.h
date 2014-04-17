//
//  weeklymessage3.h
//  Breast Cancer
//
//  Created by DeemSysInc on 23/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface weeklymessage3 : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate,UITextViewDelegate>
{
    IBOutlet UILabel * pleaseexplain;
    int te;
    IBOutlet UITextView * answer3;
    IBOutlet UILabel *tipsimprove;
    NSString *audioname;
    IBOutlet UILabel * recording;
    NSMutableDictionary * recorddict;
    NSMutableDictionary * temp;
    IBOutlet UIButton *nextbut;
   // IBOutlet UIButton *saveButton;
    int recordselected;
    IBOutlet UIToolbar *toolbar;
    NSTimer *timer; 
    int stopped;
    IBOutlet UIButton *play;
    
    IBOutlet UIButton *stop;
    IBOutlet UIButton *save;
    IBOutlet UIButton *record;
}
- (IBAction)pause:(id)sender;
- (IBAction)next:(id)sender;
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic , retain) NSMutableDictionary * recorddict;
@property (strong, nonatomic) IBOutlet UIButton * play;
@property (strong, nonatomic) IBOutlet UIButton * record;
@property (strong, nonatomic) IBOutlet UIButton * stop;
@property(strong,nonatomic)IBOutlet UIButton *save;
@end
