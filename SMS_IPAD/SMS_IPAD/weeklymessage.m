//
//  weeklymessage.m
//  Breast Cancer
//
//  Created by DeemSysInc on 20/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "weeklymessage.h"
#import "BlockUI.h"
#import "BlockAlertView.h"
#import "weekmessage2.h"
#import "weeklymessage4.h"
#import "weeklymail.h"

@interface weeklymessage ()

@end

@implementation weeklymessage
@synthesize recorddict;
int a;
// Regular Expressions
-(BOOL)numbers:(NSString *)country1
{
    NSString *countryFormat1 = @"[0-7]{1}";
    
    //  [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)send:(id)sender
{
    recorddict=[[NSMutableDictionary alloc]init];
    if(([answer1.text length]!=0))
    {
        a=0;
        if([self numbers:[answer1 text]]==1)
        {
            a=1;
            // NSLog(@"a value %i",a);
            [recorddict setValue:answer1.text forKey:@"answer1"];
            [recorddict setValue:seq forKey:@"seq"];
            [recorddict setValue:seqmorethan3 forKey:@"seqmorethan3"];
            //NSLog(@"answer5%@",answer1.text);
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Invalid answer!Enter a valid number within (0-7)"];
            
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
    
    
    if (([seq isEqual:@"1"])||([seqmorethan3 isEqual:@"1"]))
    {
        if(([answer1.text isEqual:@"0"])||([answer1.text isEqual:@"1"])||([answer1.text isEqual:@"2"])||([answer1.text isEqual:@"3"])||([answer1.text isEqual:@"4"])||([answer1.text isEqual:@"5"]))
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"cleared"];
           
            [self performSegueWithIdentifier:@"sms21" sender:self];
            
        }
    }
    if ((a==1)&&!(([seq isEqual:@"1"])||([seqmorethan3 isEqual:@"1"])))
        
    {
        if(([answer1.text isEqual:@"0"])||([answer1.text isEqual:@"1"])||([answer1.text isEqual:@"2"])||([answer1.text isEqual:@"3"])||([answer1.text isEqual:@"4"])||([answer1.text isEqual:@"5"]))
            
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"cleared"];
            
            [self performSegueWithIdentifier:@"sms1" sender:self];
        }
    }
    if ((a==1)&&(([answer1.text isEqual:@"6"])||([answer1.text isEqual:@"7"])))
    {
         [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"cleared"];
        NSArray *words = [NSArray arrayWithObjects:@"Well done!",@"Keep up the good work!",@" Way to go!",@"Nice job!",@"Keep it up!" ,@"Fantastic!" ,@"Great job staying on track!" ,@" Wonderful!" ,@"Sweet!",@"You're taking care of yourself!",@"Awesome!",@"Keep the streak alive!", nil ];
        NSString*weeknum=[[NSUserDefaults standardUserDefaults]objectForKey:@"Weeknum"];
        NSString* reinforce=[words objectAtIndex:[weeknum intValue]-1];
       // NSLog(@" in condotion week number %d,index no %d,random %@",[weeknum intValue],[weeknum intValue]-1,reinforce);
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:reinforce];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
        [recorddict setValue:@"" forKey:@"answer2"];
        [recorddict setValue:@"" forKey:@"audioname"];
        [recorddict setObject:@"notselected" forKey:@"recordselected"];
        [recorddict setValue:@"" forKey:@"textmessage"];
        [self performSegueWithIdentifier:@"sms50" sender:self];
        
        
        
        
    }
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}

// Reset Actions
-(IBAction)clear:(id)sender
{
    answer1.text=@"";
}

- (IBAction)ahtrating:(id)sender
{
    if (seg.selectedSegmentIndex==0)
    {
        answer1.text=@"0";
    }
    if (seg.selectedSegmentIndex==1)
    {
        answer1.text=@"1";
    }
    if (seg.selectedSegmentIndex==2)
    {
        answer1.text=@"2";
    }
    if (seg.selectedSegmentIndex==3)
    {
        answer1.text=@"3";
    }
    if (seg.selectedSegmentIndex==4)
    {
        answer1.text=@"4";
    }
    if (seg.selectedSegmentIndex==5)
    {
        answer1.text=@"5";
    }
    if (seg.selectedSegmentIndex==6)
    {
        answer1.text=@"6";
    }
    if (seg.selectedSegmentIndex==7)
    {
        answer1.text=@"7";
    }
    
    
}
// Keyboard Dismissal
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [answer1 resignFirstResponder];
}
-(void)back
{
    
}
-(void)dismissKeyboard {
    [question1 resignFirstResponder];
    [answer1 resignFirstResponder];
}
- (IBAction)hideKeyboard:(id)sender
{
    // NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    next.clipsToBounds = YES;
    next.layer.cornerRadius = 5.0f;
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
    answer1.delegate=self;
       seq=   [[NSUserDefaults standardUserDefaults]objectForKey:@"Sequenceoccured"];
    seqmorethan3=   [[NSUserDefaults standardUserDefaults]objectForKey:@"Sequenceoccuredmorethan3"];
    // NSLog(@"sequence occured %@,count %@",seq,seqmorethan3);
	// Do any additional setup after loading the view.
}

//Data passing to another view controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"sms1"])
    {
        
        
        weekmessage2 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        //   NSLog(@"recorddict in week first %@",recorddict);
        // destViewController.delegate=self;
        
    }
    else if ([segue.identifier isEqualToString:@"sms21"])
    {
        
        
        weeklymail *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        // NSLog(@"recorddict in weekly first %@",recorddict);
        // destViewController.delegate=self;
        
    }
    else if ([segue.identifier isEqualToString:@"sms50"])
    {
        weeklymessage4 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    a=0;
    //  self.view.frame=CGRectMake(0,0,50,50);
}
- (void)dealloc {
    // [seg release];
    // [question1 release];
    // [next release];
    [super dealloc];
}
@end
