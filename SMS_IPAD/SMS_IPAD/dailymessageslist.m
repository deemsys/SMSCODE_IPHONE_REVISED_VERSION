//
//  dailymessageslist.m
//  Breast Cancer
//
//  Created by DeemSysInc on 20/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "dailymessageslist.h"
#import "SimpleTableCell.h"
#import "messageview.h"

@interface dailymessageslist ()

@end

@implementation dailymessageslist
{
     NSMutableArray *tableData;
}

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
     tableData = [[NSMutableArray alloc] initWithObjects:@"Message1", @"Message2", @"Message3", @"Message4", @"Message5", @"Message6", @"Message7", @"Message8", @"Message9", @"Message10", @"Message11", @"Message12", @"Message13", @"Message14", @"Message15", @"HMessage16", nil];
	// Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];

        return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    [tableData removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload
    [tableView reloadData];
}


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
     [self performSegueWithIdentifier:@"message" sender:self];
}


@end
