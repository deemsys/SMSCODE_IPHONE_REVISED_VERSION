//
//  weeklymessage3.m
//  Breast Cancer
//
//  Created by DeemSysInc on 23/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "weeklymessage3.h"
#import "weeklymessage4.h"
#import "weekmessage2.h"
#import "BlockAlertView.h"


@interface weeklymessage3 ()
{
    
    
}


@end

@implementation weeklymessage3
@synthesize recorddict;
@synthesize stop,record,play,save;



NSString * aaa;
int a;


-(void)stoprecord
{
    if (stopped==1)
    {
        
    }
    else
    {
        
        if ([timer isValid]) {
            stopped=1;
            [timer invalidate];
        }
    }
    [record setImage:[UIImage imageNamed:@"Record.png"] forState:UIControlStateNormal];
    
    [play setEnabled:YES];
    [save setEnabled:YES];
    [stop setEnabled:NO];
    [record setEnabled:YES];
    [self.audioPlayer stop];
    [self.audioRecorder stop];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
    //  NSLog(@"url %@",[recorddict objectForKey:@"audiourl"]);
    recording.hidden=FALSE;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                    message: @"Your recording time limit exceeds 2 minutes!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

}



-(IBAction)stop:(id)sender
{
    [record setImage:[UIImage imageNamed:@"Record.png"] forState:UIControlStateNormal];

    [play setEnabled:YES];
    [save setEnabled:YES];
    [stop setEnabled:NO];
    [record setEnabled:YES];
    [self.audioPlayer stop];
    [self.audioRecorder stop];
    if (stopped==1) {
        
    }
    else
    {
        if ([timer isValid]) {
            stopped=1;
         [timer invalidate];
    }
    }
   
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
    //  NSLog(@"url %@",[recorddict objectForKey:@"audiourl"]);
    recording.hidden=FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(IBAction)save:(id)sender
{
    a=1;
   
    recording.hidden=NO;
    [recorddict addEntriesFromDictionary:temp];
    recorddict=[[NSMutableDictionary alloc]init];
    
    recorddict=[[NSMutableDictionary alloc]init];
    [recorddict addEntriesFromDictionary:temp];
    if (recordselected==0)
    {
        if ([answer3.text length]>0)
        {
          [recorddict setValue:answer3.text forKey:@"textmessage"];
            [recorddict setValue:@"selected" forKey:@"recordselected"];
            
        }
        else
        {
            [recorddict setValue:@"" forKey:@"textmessage"];
        }
        
        //To ensure whether audio goingto send or not
    
    [recorddict setObject:@"" forKey:@"audioname"];
    [recorddict setObject:@"" forKey:@"audiourl"];
    }
    if (recordselected==1)
    {
        [recorddict setValue:@"selected" forKey:@"recordselected"];
        if ([answer3.text length]>0)
        {
            [recorddict setValue:answer3.text forKey:@"textmessage"];
        }
        else
        {
            [recorddict setValue:@"" forKey:@"textmessage"];
        }
     
       
       
    }
    
   
    if (a==1)
    {
        //  NSLog(@"recorddict in answer2 %@",recorddict);
        [self performSegueWithIdentifier:@"sms15" sender:self];
    }
    
    
    
}



- (IBAction)next:(id)sender
{
    recorddict=[[NSMutableDictionary alloc]init];
    [recorddict addEntriesFromDictionary:temp];
    
    //  NSLog(@"recorddict in answer2 %@",recorddict);
    [self performSegueWithIdentifier:@"sms15" sender:self];
    
    
}

-(IBAction)record:(id)sender
{
   
    recordselected=1;
    // Set the audio file
    stopped=0;
  AVAudioSession *session = [AVAudioSession sharedInstance];
[session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
//self.audioRecorder.delegate = self;
    //self.audioRecorder.meteringEnabled = YES;

    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSDate *date=[NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * currentDate = [dateFormatter stringFromDate:date];
    //  NSLog(@"current date %@",currentDate);
    
    NSString *name=[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    
    int i=0+arc4random()%1000;
    
    audioname=[NSString stringWithFormat:@"%@_%@_%d_audiofile",currentDate,name,i];
    [recorddict setObject:audioname forKey:@"audioname"];
    
    NSURL *audioFileURL = [NSURL fileURLWithPath:[docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a",audioname]]];
    [recorddict setObject:audioFileURL forKey:@"audiourl"];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    [prefs setURL:audioFileURL forKey:@"Test1"];
    [prefs synchronize];
    
    self.audioRecorder = [[AVAudioRecorder alloc]
                          initWithURL:audioFileURL
                          settings:recordSetting
                          error:nil];
    
    //recording.text=@"Recording..";
    if (self.audioPlayer.playing) {
        [self.audioPlayer stop];
    }
    
    if (!self.audioRecorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [self.audioRecorder prepareToRecord];
        
        // Start recording
        [self.audioRecorder record];
         //global var
        
        timer = [NSTimer scheduledTimerWithTimeInterval:120
                                                 target:self
                                               selector:@selector(stoprecord)
                                               userInfo:nil
                                                repeats:NO];
//         [self performSelector:@selector(stoprecord) withObject:nil afterDelay:120];
        //[record setTitle:@"Record" forState:UIControlStateNormal];
        
    } else {
        
        // Pause recording
        [self.audioRecorder pause];
        //[record setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    
    [stop setEnabled:YES];
    [record setEnabled:NO];
    [play setEnabled:NO];
    
    
}
-(IBAction)play:(id)sender
{
 
   // recording.text=@"Playing..";
    
    [record setImage:[UIImage imageNamed:@"Record.png"] forState:UIControlStateNormal];
    
    if (!self.audioRecorder.recording){
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [audioSession setActive:YES error:nil];
        
        
        //Load recording path from preferences
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        
        
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[prefs URLForKey:@"Test1"] error:nil];
        [self.audioPlayer setDelegate:self];
        [self.audioPlayer play];
    }
    [stop setEnabled:YES];
    [record setEnabled:YES];
   
    
    
    
}




-(void)dismissKeyboard {
    [answer3 resignFirstResponder];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [answer3 resignFirstResponder];
}
- (IBAction)hideKeyboard:(id)sender
{
    // NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)back
{
    
}




- (void)viewDidLoad
{
    stopped=0;//To invalidate timer
    //[self.audioRecorder prepareToRecord];
    // Disable Stop/Play button when application launches
    answer3.clipsToBounds = YES;
    answer3.layer.cornerRadius = 5.0f;
    nextbut.clipsToBounds = YES;
    nextbut.layer.cornerRadius = 5.0f;
    play.clipsToBounds = YES;
    play.layer.cornerRadius = 5.0f;
    stop.clipsToBounds = YES;
    stop.layer.cornerRadius = 5.0f;
    record.clipsToBounds = YES;
    record.layer.cornerRadius = 5.0f;
    save.clipsToBounds = YES;
    save.layer.cornerRadius = 5.0f;
    answer3.text=@"";
    recordselected=0;
    
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [super viewDidLoad];
    
    
    
    // Disable Stop/Play button when application launches
    [stop setEnabled:NO];
    [play setEnabled:NO];
     // [save setEnabled:NO];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    self.audioRecorder.delegate = self;
    self.audioRecorder.meteringEnabled = YES;
    [recorddict setObject:@"notselected" forKey:@"recordselected"];
      [recorddict setValue:@"" forKey:@"textmessage"];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    
    // Do any additional setup after loading the view.
    
    
    temp=[[NSMutableDictionary alloc]init];
    temp=recorddict;
    
    aaa = [recorddict objectForKey:@"answer2"];
    
    if ([aaa isEqual:@"I forgot"])
    {
        
        tipsimprove.text=@"A pill box, establishing a routine of taking your medication at the same time, or placing your medication in a location where you can’t miss it are some ways to remember to take your medication.";
        tipsimprove.hidden=FALSE;
        nextbut.hidden=FALSE;
        recording.hidden=TRUE;
        pleaseexplain.hidden=TRUE;
        answer3.hidden=TRUE;
        play.hidden=TRUE;
        record.hidden=TRUE;
        stop.hidden=TRUE;
        save.hidden=TRUE;
       
        [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
        
    }
    else if([aaa isEqual:@"I had side effects"])
    {
        if ([[recorddict objectForKey:@"sideeffectsinformed"]isEqualToString:@"No"])
        {
            tipsimprove.hidden=TRUE;
            nextbut.hidden=TRUE;
            recording.hidden=TRUE;
            recording.hidden=FALSE;
            pleaseexplain.hidden=FALSE;
            answer3.hidden=FALSE;
            play.hidden=FALSE;
            record.hidden=FALSE;
            stop.hidden=FALSE;
            save.hidden=FALSE;
            
        }
        
    }
    else if([aaa isEqual:@"Health insurance doesn't cover it"])
    {
        tipsimprove.text=@"Talk to your doctor or nurse about this. They may be able to help you.";
        
        tipsimprove.hidden=FALSE;
        nextbut.hidden=FALSE;
        recording.hidden=TRUE;
        pleaseexplain.hidden=TRUE;
        answer3.hidden=TRUE;
        play.hidden=TRUE;
        record.hidden=TRUE;
        stop.hidden=TRUE;
        save.hidden=TRUE;
       
        [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
    }
    else if([aaa isEqual:@"Medication/co-payments cost too much"])
    {
        tipsimprove.text=@"Please talk to your health care team about this. They may be able to help you.";
        
        tipsimprove.hidden=FALSE;
        nextbut.hidden=FALSE;
        recording.hidden=TRUE;
        pleaseexplain.hidden=TRUE;
        answer3.hidden=TRUE;
        play.hidden=TRUE;
        record.hidden=TRUE;
        stop.hidden=TRUE;
        save.hidden=TRUE;
       
        [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
    }
    
    else if([aaa isEqual:@"Family/friends discouraged me from taking medication"])
    {
        tipsimprove.text=@"That’s understandable, however, taking this medicine is an investment in your health. Please talk to your doctor or nurse about your concerns.";
        
        tipsimprove.hidden=FALSE;
        nextbut.hidden=FALSE;
        recording.hidden=TRUE;
        pleaseexplain.hidden=TRUE;
        answer3.hidden=TRUE;
        play.hidden=TRUE;
        record.hidden=TRUE;
        stop.hidden=TRUE;
        save.hidden=TRUE;
               [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
    }
    
    else if([aaa isEqual:@"I am taking too many medications"])
    {
        tipsimprove.text=@"Please talk to your doctor or nurse about this.";
       
        tipsimprove.hidden=FALSE;
        nextbut.hidden=FALSE;
        recording.hidden=TRUE;
        pleaseexplain.hidden=TRUE;
        answer3.hidden=TRUE;
        play.hidden=TRUE;
        record.hidden=TRUE;
        stop.hidden=TRUE;
        save.hidden=TRUE;
        [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
    }
    else if([aaa isEqual:@"I don't like taking medications"])
    {
        tipsimprove.text=@"That’s understandable. Many people feel this way, however, taking this medicine is an investment in your health. Please talk to your doctor or nurse about this.";
        
        tipsimprove.hidden=FALSE;
        nextbut.hidden=FALSE;
        recording.hidden=TRUE;
        pleaseexplain.hidden=TRUE;
        answer3.hidden=TRUE;
        play.hidden=TRUE;
        record.hidden=TRUE;
        stop.hidden=TRUE;
        save.hidden=TRUE;
        [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
    }
    else if([aaa isEqual:@"Delay in filling/starting prescription"])
    {
        tipsimprove.text=@"Please talk to your doctor or nurse about this.";
        
        tipsimprove.hidden=FALSE;
        nextbut.hidden=FALSE;
        recording.hidden=TRUE;
        pleaseexplain.hidden=TRUE;
        answer3.hidden=TRUE;
        play.hidden=TRUE;
        record.hidden=TRUE;
        stop.hidden=TRUE;
        save.hidden=TRUE;
        [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
    }
    
    else if([aaa isEqualToString:@"Other"])
    {
        tipsimprove.hidden=TRUE;
        nextbut.hidden=TRUE;
        recording.hidden=FALSE;
        pleaseexplain.hidden=FALSE;
        answer3.hidden=FALSE;
        play.hidden=FALSE;
        record.hidden=FALSE;
        stop.hidden=FALSE;
        save.hidden=FALSE;
        
    }
    
    
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"sms15"])
    {
        weeklymessage4 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        //   NSLog(@"recorddict from third page %@",recorddict);
        // destViewController.delegate=self;
        
    }
    
    
    
    
}


#pragma mark - AVAudioRecorderDelegate

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    [record setTitle:@"Record" forState:UIControlStateNormal];
    [stop setEnabled:NO];
    [play setEnabled:YES];
    [record setEnabled:YES];
    
    
}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                    message: @"Finished playing!"
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}





- (void)dealloc {
    // [nextbut release];
    // [toolbar release];
    // [tipsimprove release];
    //[play release];
    //[stop release];
    //[record release];
       [super dealloc];
}
@end
