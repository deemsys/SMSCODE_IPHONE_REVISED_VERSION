//
//  dailymsglistViewController.h
//  Breast Cancer
//
//  Created by DeemsysInc on 12/6/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dailymsglistViewController : UITableViewController
{
    NSMutableArray *from;
    NSMutableArray *date;
    NSMutableArray *to;
    NSMutableArray *flagvalue;
    NSMutableArray *body;
    NSMutableDictionary *recorddict;
    NSMutableArray *msglist;
    IBOutlet UITableView *tableView;
    NSString*msgtextfile;
    NSString*msgdatefile,*msgflagfile,*msgfromfile;
    IBOutlet UILabel *somelabel;
    
    int count,totalcount;
    NSNumber *numtotal,*numcount;
    int prev;
    
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic,assign)   NSMutableArray *from;
@property (nonatomic,assign)NSMutableArray *date;
@property (assign)NSMutableDictionary *recorddict;
@property (nonatomic,assign)    NSMutableArray *to;
@property (nonatomic,assign)    NSMutableArray *body;
@property (nonatomic,assign)    NSMutableArray *status;
@end



