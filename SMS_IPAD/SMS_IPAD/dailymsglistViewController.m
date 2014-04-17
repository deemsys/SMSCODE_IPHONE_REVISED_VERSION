//
//  dailymsglistViewController.m
//  Breast Cancer
//
//  Created by DeemsysInc on 12/6/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.


#import "dailymsglistViewController.h"
#import "messageview.h"
#import "msgcontent.h"
#import "fileMngr.h"
@interface dailymsglistViewController ()

@end

@implementation dailymsglistViewController
@synthesize recorddict;
@synthesize from;
@synthesize to;
@synthesize date;
@synthesize status;
@synthesize body;
@synthesize tableView;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    msglist=[[NSMutableArray alloc]init];
    flagvalue=[[NSMutableArray alloc]init];
    body=[[NSMutableArray alloc]init];
    date=[[NSMutableArray alloc]init];
    from=[[NSMutableArray alloc]init];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDirectory = [path objectAtIndex:0];
    
	msgdatefile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"msgdateFile.hsa"]];
    msgtextfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"msgtextFile.hsa"]];
    msgflagfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"msgflagFile.hsa"]];
    msgfromfile=[[NSString alloc] initWithString:[docDirectory stringByAppendingPathComponent:@"msgfromFile.hsa"]];
    
    
    
    
	if ([[NSFileManager defaultManager] fileExistsAtPath:msgdatefile])
	{
		date=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:msgdatefile]];
        // NSLog(@"date file in daily %@",date);
		
	}
	else
	{
		date=[[NSMutableArray alloc]init];
	}
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:msgtextfile])
	{
		body=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath:msgtextfile]];
		
	}
	else
	{
		body=[[NSMutableArray alloc]init];
	}
    if ([[NSFileManager defaultManager] fileExistsAtPath: msgflagfile])
	{
		flagvalue=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath: msgflagfile]];
       // NSLog(@"flag values in daily %@",from);
       	
	}
    else
	{
        flagvalue=[[NSMutableArray alloc]init];
	}
    if ([[NSFileManager defaultManager] fileExistsAtPath: msgfromfile])
	{
		from=[[NSMutableArray alloc]initWithArray:[fileMngr fetchDatafrompath: msgfromfile]];
        
       	
	}
    else
	{
        from=[[NSMutableArray alloc]init];
	}
    for (int i=0;i<[body count]; i++)
    {
        msgcontent *content=[msgcontent new];
        content.fromnumber=[from objectAtIndex:i];
        content.tonumber=[to objectAtIndex:i];
        content.message=[body objectAtIndex:i];
        content.date=[date objectAtIndex:i];
        content.flag=[flagvalue objectAtIndex:i];
        if([[flagvalue objectAtIndex:i] isEqual:@"1"])
        content.imagename=@"messageunread.png";
        else
            content.imagename=@"unread_message.png";
        [msglist addObject:content];
        
    }
    
    
    
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.parentViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    // NSLog(@"msglist in dailymsglist %@",msglist);
    // NSLog(@" from %@",from);
    // Add padding to the top of the table view
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    if ([from count]==0)
    {
        somelabel.hidden=NO;
    }
    else
    {
        somelabel.hidden=YES;
    }
    
}

// Table Cell Index Properties
- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [msglist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    msgcontent *msg1=[msglist objectAtIndex:indexPath.row];
    UILabel *fromcell=(UILabel *)[cell viewWithTag:101];
    fromcell.text=msg1.fromnumber;
    //fromcell.text=@"11";
    // NSLog(@"from cell %@",msg1.fromnumber);
    UILabel *tocell=(UILabel *)[cell viewWithTag:102];
    tocell.text=msg1.date;
    
    UILabel *msgcell=(UILabel *)[cell viewWithTag:103];
    msgcell.text=msg1.message;
    
    UIImageView *msgImageView = (UIImageView *)[cell viewWithTag:100];
    msgImageView.image = [UIImage imageNamed:msg1.imagename];

    
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    return cell;
    
}
/* Table cell deletion task
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    [msglist removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload
    [tableView reloadData];
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    msgcontent *msg1=[msglist objectAtIndex:indexPath.row];
    NSString *msg=msg1.message;
    NSString *fromnumber=msg1.fromnumber;
    NSString *date1=msg1.date;
    
    [msglist removeObjectAtIndex:indexPath.row];
    msgcontent *msg2=[msgcontent new];
    msg2.message=msg;
    msg2.fromnumber=fromnumber;
    msg2.date=date1;
    msg2.flag=@"1";
    msg2.imagename=@"messageunread.png";
    [msglist insertObject:msg2 atIndex:indexPath.row];
    [flagvalue replaceObjectAtIndex:indexPath.row withObject:@"1"];
    
    [fileMngr saveDatapath:msgflagfile contentarray:flagvalue];
    [tableView reloadData];
    [self viewDidLoad];
    
    //[self performSegueWithIdentifier:@"message" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"message"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        messageview *destViewController = segue.destinationViewController;
        destViewController.readmessage = [msglist objectAtIndex:indexPath.row];
       // NSLog(@"index %d",indexPath.row);
    }
}



- (void)dealloc
{
    [tableView release];
    [somelabel release];
    [super dealloc];
    
}
@end


