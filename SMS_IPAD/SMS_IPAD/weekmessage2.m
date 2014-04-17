//
//  weekmessage2.m
//  Breast Cancer
//
//  Created by DeemSysInc on 25/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "weekmessage2.h"

#import "BlockAlertView.h"
#import "weeklymessage.h"
#import "weeklymessage3.h"
#import "weeklymessage4.h"
#import "sideeffectsViewController.h"

@interface weekmessage2 ()

@end

@implementation weekmessage2
@synthesize recorddict;
@synthesize next;
@synthesize delay;
NSString *aaa;
int a;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)numbers:(NSString *)country1
{
    NSString *countryFormat1 = @"[1-9]{1}";
    
    //  [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}

-(IBAction)send:(id)sender
{
    a=0;
    recorddict=[[NSMutableDictionary alloc]init];
    [recorddict addEntriesFromDictionary:temp];
    
    if(([answer2.text length]!=0))
    {
        a=0;
        // NSLog(@"a value %i",a);
        if([self numbers:[answer2 text]]==1)
        {
            a=1;
            // NSLog(@"a value %i",a);
            if ([answer2.text isEqual:@"1"])
            {
                answer2.text=@"I forgot";
            }
            else if ([answer2.text isEqual:@"2"])
            {
                answer2.text=@"I had side effects";
            }
            else if ([answer2.text isEqual:@"3"])
            {
                answer2.text=@"Health insurance doesn't cover it";
            }
            else if ([answer2.text isEqual:@"4"])
            {
                answer2.text=@"Medication/co-payments cost too much";
            }
            else if ([answer2.text isEqual:@"5"])
            {
                answer2.text=@"Family/friends discouraged me from taking medication";
            }
            else if ([answer2.text isEqual:@"6"])
            {
                answer2.text=@"I am taking too many medications";
            }
            else if ([answer2.text isEqual:@"7"])
            {
                answer2.text=@"I don't like taking medications";
            }
            else if ([answer2.text isEqual:@"8"])
            {
                answer2.text=@"Delay in filling/starting prescription";
            }
            else if ([answer2.text isEqual:@"9"])
            {
                answer2.text=@"Other";
            }
            [recorddict setValue:answer2.text forKey:@"answer2"];
            //NSLog(@"answer5%@",answer1.text);
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Answer you submitted is invalid."];
            
            //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
    }
    else
    {
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Field should not be empty."];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
    }
    if ((a==1)&&([answer2.text isEqual:@"I had side effects"]))
    {
       // NSLog(@"recorddict in answer2 %@",recorddict);
        [self performSegueWithIdentifier:@"sms40" sender:self];
    }
    if ((a==1)&&(![answer2.text isEqual:@"I had side effects"]))
    {
        
       // NSLog(@"recorddict in answer2 goto to next page %@",recorddict);
        [self performSegueWithIdentifier:@"sms20" sender:self];
        
    }
    
    
    
}
-(IBAction)clear:(id)sender
{
    answer2.text=@"";
    
}
-(IBAction)next:(id)sender
{
    
    
}
- (IBAction)forgotsel:(id)sender
{
    
    [iforget setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    answer2.text=@"1";
    send.hidden=NO;
}

- (IBAction)costtoomuch:(id)sender
{
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    send.hidden=NO;
    answer2.text=@"4";
}



- (IBAction)friendsdiscouraged:(id)sender {
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    send.hidden=NO;
    answer2.text=@"5";
    
}

- (IBAction)takingtoomanymedications:(id)sender
{
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    send.hidden=NO;
    answer2.text=@"6";
}

- (IBAction)dontliketakingmed:(id)sender {
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    send.hidden=NO;
    answer2.text=@"7";
}

- (IBAction)sideeffectselected:(id)sender
{
    
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    send.hidden=NO;
    answer2.text=@"2";
}

- (IBAction)ranoutselected:(id)sender
{
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    answer2.text=@"3";
    
    send.hidden=NO;
}

- (IBAction)delayselected:(id)sender
{
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    answer2.text=@"8";
    
    send.hidden=NO;

}

- (IBAction)othersselected:(id)sender
{
    [iforget setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [sideeffects setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ranout setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [others setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    [costtoomuchbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ toomanymedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [ friendsdiscouragedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [dontliketakingmedbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [delay setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    answer2.text=@"9";
    
    send.hidden=NO;
}





- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [answer2 resignFirstResponder];
    
}
-(void)dismissKeyboard {
    [answer2 resignFirstResponder];
    [question2 resignFirstResponder];
    
}
- (IBAction)hideKeyboard:(id)sender
{
    // NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}
-(void)back
{
    
}
- (void)viewDidLoad
{
    send.hidden=YES;
    send.clipsToBounds = YES;
    send.layer.cornerRadius = 5.0f;
    next.clipsToBounds = YES;
    next.layer.cornerRadius = 5.0f;
    a=0;
    temp=[[NSMutableDictionary alloc]init];
    temp=recorddict;
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
   
    answer2.delegate=self;
	// Do any additional setup after loading the view.
    NSArray *words = [NSArray arrayWithObjects:@"Well done!",@"Keep up the good work!",@" Way to go!",@"Nice job!",@"Keep it up!" ,@"Fantastic!" ,@"reat job staying on track!" ,@" Wonderful!" ,@"Sweet!",@"You're taking care of yourself!",@"Awesome!",@"Keep the streak alive!", nil ];
    NSString*weeknum=[[NSUserDefaults standardUserDefaults]objectForKey:@"Weeknum"];
    reinforce=[words objectAtIndex:[weeknum intValue]-1];
   // NSLog(@"in weekly2 week number %d,index no %d,random %@",[weeknum intValue],[weeknum intValue]-1,reinforce);
    inforce.text=reinforce;
    // NSLog(@"reinforcement %@",inforce.text);
    aaa=[recorddict objectForKey:@"answer1"];
    // NSLog(@"aaa value %@",aaa);
    hiddenfield.text=aaa;
    //  NSLog(@"hidden field %@",hiddenfield.text);
    if (([aaa isEqual:@"0"])||([aaa isEqual:@"1"])||([aaa isEqual:@"2"])||([aaa isEqual:@"3"])||([aaa isEqual:@"4"])||([aaa isEqual:@"5"]))
    {
        question2.hidden=FALSE;
        answer2.hidden=FALSE;
        send.hidden=FALSE;
        clear.hidden=TRUE;
        next.hidden=TRUE;
        inforce.hidden=TRUE;
        iforget.hidden=FALSE;
        sideeffects.hidden=FALSE;
        ranout.hidden=FALSE;
        others.hidden=FALSE;
        forgotlabel.hidden=FALSE;
        sideeffectlabel.hidden=FALSE;
        ranoutlabel.hidden=FALSE;
        otherslabel.hidden=FALSE;
        costtoomuch.hidden=FALSE;
        friendsdiscouraged.hidden=FALSE;
        takingtoomany.hidden=FALSE;
        dontliketotake.hidden=FALSE;
        costtoomuchbutton.hidden=FALSE;
        toomanymedbutton.hidden=FALSE;
        friendsdiscouragedbutton.hidden=FALSE;
        dontliketakingmedbutton.hidden=FALSE;
        //  NSLog(@"hi");
        
        
    }
    else     {
        question2.hidden=TRUE;
        answer2.hidden=TRUE;
        send.hidden=TRUE;
        clear.hidden=TRUE;
        next.hidden=TRUE;
        inforce.hidden=TRUE;
        iforget.hidden=TRUE;
        sideeffects.hidden=TRUE;
        ranout.hidden=TRUE;
        others.hidden=TRUE;
        forgotlabel.hidden=TRUE;
        sideeffectlabel.hidden=TRUE;
        ranoutlabel.hidden=TRUE;
        otherslabel.hidden=TRUE;
        costtoomuch.hidden=TRUE;
        friendsdiscouraged.hidden=TRUE;
        takingtoomany.hidden=TRUE;
        dontliketotake.hidden=TRUE;
        costtoomuchbutton.hidden=TRUE;
        toomanymedbutton.hidden=TRUE;
        friendsdiscouragedbutton.hidden=TRUE;
        dontliketakingmedbutton.hidden=TRUE;
        
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"sms20"])
    {
        weeklymessage3 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        //  NSLog(@"recorddict from second page %@",recorddict);
        // destViewController.delegate=self;
        
    }
    else if ([segue.identifier isEqualToString:@"sms4"])
    {
        weeklymessage4 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        //  NSLog(@"recorddict from second page %@",recorddict);
        // destViewController.delegate=self;
        
    }
    
    else if ([segue.identifier isEqualToString:@"sms40"])
    {
        sideeffectsViewController *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        //  NSLog(@"recorddict from second page %@",recorddict);
        // destViewController.delegate=self;
        
    }
    
    
}


- (void)dealloc {
    [inforce release];
    [sideeffects release];
    [ranout release];
    [others release];
    [forgotlabel release];
    [sideeffectlabel release];
    [ranoutlabel release];
    [otherslabel release];
    [iforget release];
    [question2 release];
    [costtoomuch release];
    [friendsdiscouraged release];
    [takingtoomany release];
    [dontliketotake release];
    [costtoomuchbutton release];
    [friendsdiscouraged release];
    [friendsdiscouraged release];
    [friendsdiscouragedbutton release];
    [toomanymedbutton release];
    [dontliketakingmedbutton release];
    [next release];
  
    [super dealloc];
}
@end
