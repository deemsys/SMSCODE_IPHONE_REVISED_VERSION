//
//  messageview.m
//  Breast Cancer
//
//  Created by DeemSysInc on 20/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "messageview.h"
#import <QuartzCore/QuartzCore.h>

@interface messageview ()

@end

@implementation messageview
@synthesize fromdate1;
@synthesize readmessage;
@synthesize datetime1;
@synthesize mesagedetail1;
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
    [super viewDidLoad];
    self.fromdate1.text=readmessage.fromnumber;
    self.mesagedetail1.text=readmessage.message;
    self.datetime1.text=readmessage.date;
	// Do any additional setup after loading the view.
    mesagedetail1.clipsToBounds = YES;
    mesagedetail1.layer.cornerRadius = 5.0f;
  //  mesagedetail.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[[UIImageView alloc] initWithFrame:mesagedetail1.frame] autorelease];
    imageView.image = [UIImage imageNamed:@"BG.png"];
    [self.view addSubview:mesagedetail1];
    [self.view bringSubviewToFront:mesagedetail1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [mesagedetail1 release];
    [super dealloc];
}
@end
