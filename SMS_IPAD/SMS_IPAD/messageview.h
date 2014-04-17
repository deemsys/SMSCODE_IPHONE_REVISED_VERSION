//
//  messageview.h
//  Breast Cancer
//
//  Created by DeemSysInc on 20/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "msgcontent.h"

@interface messageview : UIViewController
{
    
    IBOutlet UITextView *mesagedetail1;
  IBOutlet UILabel*fromdate1;
    IBOutlet UILabel *datetime1;
}
@property (retain, nonatomic) IBOutlet UILabel*fromdate1;
@property (retain, nonatomic) IBOutlet UILabel *datetime1;
@property(retain,nonatomic) IBOutlet UITextView *mesagedetail1;
@property(nonatomic,strong)msgcontent*readmessage;

@end
