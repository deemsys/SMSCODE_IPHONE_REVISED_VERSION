//
//  sideeffectsViewController.m
//  Breast Cancer
//
//  Created by DeemsysInc on 1/30/14.
//  Copyright (c) 2014 DeemSysInc. All rights reserved.
//

#import "sideeffectsViewController.h"
#import "BlockUI.h"
#import "BlockAlertView.h"
#import "weeklymessage4.h"
#import "weeklymessage3.h"

@interface sideeffectsViewController ()

@end

@implementation sideeffectsViewController
@synthesize recorddict;
@synthesize next;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    next.clipsToBounds = YES;
    next.layer.cornerRadius = 5.0f;
    [super viewDidLoad];
     next.hidden=YES;
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [next release];
    [_yesbutton release];
    [_nobutton release];
    [super dealloc];
}
- (IBAction)nextclicked:(id)sender {
    [recorddict setObject:answer forKey:@"sideeffectsinformed"];
    [recorddict setObject:@"notselected" forKey:@"recordselected"];
      [recorddict setValue:@"" forKey:@"textmessage"];
   
    if ([answer isEqualToString:@"Yes"])
        
    {
        [recorddict setObject:@"" forKey:@"audioname"];
        [recorddict setObject:@"" forKey:@"audiourl"];
        [self performSegueWithIdentifier:@"sms51" sender:self];

    }
    if ([answer isEqualToString:@"No"])
    {
        [self performSegueWithIdentifier:@"sms52" sender:self];

    }
    }
- (IBAction)yesclicked:(id)sender
{
     next.hidden=NO;
     [_yesbutton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
     [_nobutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Great Job!"];
    
    //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
    [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
    [alert show];
    answer=@"Yes";
}

- (IBAction)noclicked:(id)sender {
     next.hidden=NO;
    [_yesbutton setImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [_nobutton setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    answer=@"No";
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"sms51"])
    {
     
        weeklymessage4 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        //  NSLog(@"recorddict from second page %@",recorddict);
        // destViewController.delegate=self;
        
    }
    
    else if ([segue.identifier isEqualToString:@"sms52"])
    {
        weeklymessage3 *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
        //  NSLog(@"recorddict from second page %@",recorddict);
        // destViewController.delegate=self;
        
    }
    
    
}

@end
