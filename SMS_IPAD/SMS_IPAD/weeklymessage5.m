//
//  weeklymessage5.m
//  Breast Cancer
//
//  Created by DeemSysInc on 23/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "weeklymessage5.h"

@interface weeklymessage5 ()

@end

@implementation weeklymessage5
@synthesize recorddict;
@synthesize temp;
@synthesize contactprovider;
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
    end.clipsToBounds = YES;
    end.layer.cornerRadius = 5.0f;
    contactprovider.clipsToBounds = YES;
    contactprovider.layer.cornerRadius = 5.0f;
    UIButton *home = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *homeImage = [UIImage imageNamed:@" "]  ;
    [home setBackgroundImage:homeImage forState:UIControlStateNormal];
    [home addTarget:self action:@selector(back)
   forControlEvents:UIControlEventTouchUpInside];
    home.frame = CGRectMake(0, 0, 50, 30);
    UIBarButtonItem *cancelButton = [[[UIBarButtonItem alloc]
                                      initWithCustomView:home] autorelease];
    self.navigationItem.leftBarButtonItem = cancelButton;
   // NSLog(@"recorddict in welcome 5 %@",recorddict);
    [super viewDidLoad];
    end.hidden=false;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// Network Status Check
- (void)dealloc {
    
    [contactprovider release];
    [super dealloc];
}
@end
