//
//  editprofile.m
//  Breast Cancer
//
//  Created by DeemSysInc on 21/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "editprofile.h"
#import "BlockAlertView.h"
#import "Reachability.h"
#import "MBProgressHUD.h"
#import "JSON.h"
#import "MBProgressHUD.h"
@interface editprofile ()

@end

@implementation editprofile
@synthesize recorddict;
@synthesize timepick1;
@synthesize timepick2;
@synthesize timepick3;
@synthesize timearray;
@synthesize grouppick;
@synthesize grouppicker;
@synthesize grouparray;
@synthesize time1;
@synthesize time2;
@synthesize time3;
@synthesize ageArray;
@synthesize agepick;
@synthesize agepicker;
@synthesize segedu;
@synthesize gender;
@synthesize errorlabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==5) {
        
        NSUInteger newLength = [mobile.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }
    else if (textField.tag==6) {
        
        NSUInteger newLength = [city.text length] + [string length] - range.length;
        return (newLength > 5) ? NO : YES;
    }
    else
        return YES;
}

- (void)pickerViewTappedage
{
    agepick.hidden=YES;
}
-(IBAction)changetimeset1:(id)sender
{
    if([time1seg selectedSegmentIndex]==0)
    {
        t1=@"AM";
    }
    else
    {
        t1=@"PM";
    }
}
-(IBAction)changetimeset2:(id)sender
{
    if([time2seg selectedSegmentIndex]==0)
    {
        t2=@"AM";
    }
    else
    {
        t2=@"PM";
    }
}
-(IBAction)changetimeset3:(id)sender
{
    if([time3seg selectedSegmentIndex ]==0)
    {
        t3=@"AM";
    }
    else
    {
        t3=@"PM";
    }
}

-(IBAction)segeduselected:(id)sender
{
    if([segedu selectedSegmentIndex]==0)
    {
        education=@"Did not complete High School";
    }
    if([segedu selectedSegmentIndex]==1)
    {
          education=@"High School or GED";
    }
    if([segedu selectedSegmentIndex]==2)
    {
        education=@"Some College";
    }
    if([segedu selectedSegmentIndex]==3)
    {
          education=@"Undergraduate Degree";
    }
    if([segedu selectedSegmentIndex]==4)
    {
        education=@"Post-graduate Degree";
    }
}
-(IBAction)seggenderselected:(id)sender
{
    if ([gender selectedSegmentIndex]==0) {
        gend=@"0";
    }
    if ([gender selectedSegmentIndex]==1) {
        gend=@"1";
    }
}
- (void)viewDidLoad
{
    submit.clipsToBounds = YES;
    submit.layer.cornerRadius = 5.0f;
    [timepick1 setBackgroundColor:([UIColor whiteColor])];
    [timepick2 setBackgroundColor:([UIColor whiteColor])];
    [timepick3 setBackgroundColor:([UIColor whiteColor])];
    [grouppick setBackgroundColor:([UIColor whiteColor])];
    [agepick setBackgroundColor:([UIColor whiteColor])];
    [super viewDidLoad];
    timepick1.hidden=YES;
    timepick2.hidden=YES;
    timepick3.hidden=YES;
    grouppick.hidden=YES;
    agepick.delegate = self;
    agepick.dataSource = self;
    ageArray = [[NSArray alloc] initWithObjects:@"Below 12", @"12-20 years", @"21-30 years", @"31-40 years", @"41-50 years",@"51-60 years",@"61-70 years",@"71-80 years",@"81-90 years",@"91-100 years", nil];
    
    timearray=[[NSMutableArray alloc] initWithObjects:@"Select time",@"01", @"02", @"03", @"04", @"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
     UIColor * color = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    [errorlabel setTextColor:color];
    agepick.hidden=YES;
    a=0;
    
    fname.text=[recorddict objectForKey:@"firstname"];
	agepicker.text=[recorddict objectForKey:@"age"];
    city.text=[recorddict objectForKey:@"city"];
     education=[recorddict objectForKey:@"education"];
    gend=[recorddict objectForKey:@"gender"];
    if ([education isEqualToString:@"Did not complete High School"])
    {
           [segedu setSelectedSegmentIndex:0];
    }
    else if ([education isEqualToString:@"High School or GED"])
    {
        [segedu setSelectedSegmentIndex:1];
    }
    else if ([education isEqualToString:@"Some College"])
    {
      [segedu setSelectedSegmentIndex:2];
    }
   else if ([education isEqualToString:@"Undergraduate Degree"])
   {
       [segedu setSelectedSegmentIndex:3];
    }
   else if([education isEqualToString:@"Post-graduate Degree"])
   {
        [segedu setSelectedSegmentIndex:4];
   }
    

    if ([gend isEqualToString:@"Male"])
    {
        [gender setSelectedSegmentIndex:0];
    }
   else if ([gend isEqualToString:@"Female"])
    {
        [gender setSelectedSegmentIndex:1];
    }
   
    email.text=[recorddict objectForKey:@"email"];
    medical.text=[recorddict objectForKey:@"medical"];
    mobile.text=[recorddict objectForKey:@"mobile"];
    provider.text=[recorddict objectForKey:@"provider"];
    time1.text=[recorddict objectForKey:@"time11"];
    time2.text=[recorddict objectForKey:@"time21"];
    time3.text=[recorddict objectForKey:@"time31"];
   @try
    {
   if([time1.text isEqualToString:@"01"])
    {
        
    [timepick1 selectRow:0 inComponent:0 animated:NO];
    }
    if([time1.text isEqualToString:@"02"])
    {
        [self.timepick1 selectRow:1 inComponent:0 animated:NO];
    }
    if([time1.text isEqualToString:@"03"])
    {
        
[self.timepick1 selectRow:2 inComponent:0 animated:NO];
    }
   
    if([time1.text isEqualToString:@"04"])
    {
          [self.timepick1 selectRow:3 inComponent:0 animated:NO];
    }
   
    if([time1.text isEqualToString:@"05"])
    {
          [self.timepick1 selectRow:4 inComponent:0 animated:NO];
    }
    
   if([time1.text isEqualToString:@"06"])
    {
          [self.timepick1 selectRow:5 inComponent:0 animated:NO];
    }
   
    if([time1.text isEqualToString:@"07"])
    {
          [self.timepick1 selectRow:6 inComponent:0 animated:NO];
    }
 
    if([time1.text isEqualToString:@"08"])
    {
   [self.timepick1 selectRow:7 inComponent:0 animated:NO];
    }
   
    if([time1.text isEqualToString:@"09"])
    {
        [self.timepick1 selectRow:8 inComponent:0 animated:NO];
    }
    if([time1.text isEqualToString:@"10"])
    {
        [self.timepick1 selectRow:9 inComponent:0 animated:NO];
    }
   
    if([time1.text isEqualToString:@"11"])
    {
        [self.timepick1 selectRow:10 inComponent:0 animated:NO];
    }
    if([time1.text isEqualToString:@"12"])
    {
        [self.timepick1 selectRow:11 inComponent:0 animated:NO];
    }
    
    }
      @catch (NSError *error) {
        NSLog(@"%@", error);
    }
    @try
    {
        if([time2.text isEqualToString:@"01"])
        {
            
            [timepick2 selectRow:0 inComponent:0 animated:NO];
        }
        if([time2.text isEqualToString:@"02"])
        {
            [self.timepick2 selectRow:1 inComponent:0 animated:NO];
        }
        if([time2.text isEqualToString:@"03"])
        {
            
            [self.timepick2 selectRow:2 inComponent:0 animated:NO];
        }
        
        if([time2.text isEqualToString:@"04"])
        {
            [self.timepick2 selectRow:3 inComponent:0 animated:NO];
        }
        
        if([time2.text isEqualToString:@"05"])
        {
            [self.timepick2 selectRow:4 inComponent:0 animated:NO];
        }
        
        if([time2.text isEqualToString:@"06"])
        {
            [self.timepick2 selectRow:5 inComponent:0 animated:NO];
        }
        
        if([time2.text isEqualToString:@"07"])
        {
            [self.timepick2 selectRow:6 inComponent:0 animated:NO];
        }
        
        if([time2.text isEqualToString:@"08"])
        {
            [self.timepick2 selectRow:7 inComponent:0 animated:NO];
        }
        
        if([time2.text isEqualToString:@"09"])
        {
            [self.timepick2 selectRow:8 inComponent:0 animated:NO];
        }
        if([time2.text isEqualToString:@"10"])
        {
            [self.timepick2 selectRow:9 inComponent:0 animated:NO];
        }
        
        if([time2.text isEqualToString:@"11"])
        {
            [self.timepick2 selectRow:10 inComponent:0 animated:NO];
        }
        if([time2.text isEqualToString:@"12"])
        {
            [self.timepick2 selectRow:11 inComponent:0 animated:NO];
        }
        
    }
    @catch (NSError *error) {
        NSLog(@"%@", error);
    }
    
    @try
    {
        if([time3.text isEqualToString:@"01"])
        {
            
            [timepick3 selectRow:0 inComponent:0 animated:NO];
        }
        if([time3.text isEqualToString:@"02"])
        {
            [self.timepick3 selectRow:1 inComponent:0 animated:NO];
        }
        if([time3.text isEqualToString:@"03"])
        {
            
            [self.timepick3 selectRow:2 inComponent:0 animated:NO];
        }
        
        if([time3.text isEqualToString:@"04"])
        {
            [self.timepick3 selectRow:3 inComponent:0 animated:NO];
        }
        
        if([time3.text isEqualToString:@"05"])
        {
            [self.timepick3 selectRow:4 inComponent:0 animated:NO];
        }
        
        if([time3.text isEqualToString:@"06"])
        {
            [self.timepick3 selectRow:5 inComponent:0 animated:NO];
        }
        
        if([time3.text isEqualToString:@"07"])
        {
            [self.timepick3 selectRow:6 inComponent:0 animated:NO];
        }
        
        if([time3.text isEqualToString:@"08"])
        {
            [self.timepick3 selectRow:7 inComponent:0 animated:NO];
        }
        
        if([time3.text isEqualToString:@"09"])
        {
            [self.timepick3 selectRow:8 inComponent:0 animated:NO];
        }
        if([time3.text isEqualToString:@"10"])
        {
            [self.timepick3 selectRow:9 inComponent:0 animated:NO];
        }
        
        if([time3.text isEqualToString:@"11"])
        {
            [self.timepick3 selectRow:10 inComponent:0 animated:NO];
        }
        if([time3.text isEqualToString:@"12"])
        {
            [self.timepick3 selectRow:11 inComponent:0 animated:NO];
        }
        
    }
    @catch (NSError *error) {
        NSLog(@"%@", error);
    }
    @try
    {
        if([agepicker.text isEqualToString:@"Below 12"])
        {
            [self.agepick selectRow:0 inComponent:0 animated:NO];
        }
        if([agepicker.text isEqualToString:@"12-20 years"])
        {
            [self.agepick selectRow:1 inComponent:0 animated:NO];
        }
        if([agepicker.text isEqualToString:@"21-30 years"])
        {
            [self.agepick selectRow:2 inComponent:0 animated:NO];
        }
        if([agepicker.text isEqualToString:@"31-40 years"])
        {
            [self.agepick selectRow:3 inComponent:0 animated:NO];
        }
        if([agepicker.text isEqualToString:@"41-50 years"])
        {
            [self.agepick selectRow:4 inComponent:0 animated:NO];
        }
        
        if([agepicker.text isEqualToString:@"51-60 years"])
        {
            [self.agepick selectRow:5 inComponent:0 animated:NO];
        }
        
        if([agepicker.text isEqualToString:@"61-70 years"])
        {
            [self.agepick selectRow:6 inComponent:0 animated:NO];
        }
        
        if([agepicker.text isEqualToString:@"71-80 years"])
        {
            [self.agepick selectRow:7 inComponent:0 animated:NO];
        }
        if([agepicker.text isEqualToString:@"81-90 years"])
        {
            [self.agepick selectRow:8 inComponent:0 animated:NO];
        }
        
        if([agepicker.text isEqualToString:@"91-100 years"])
        {
            [self.agepick selectRow:9 inComponent:0 animated:NO];
        }
        
        
    }
    @catch (NSException *exception) {
        
    }
    
    if([[recorddict objectForKey:@"time11fm"] isEqual:@"AM"] )
    {
        t1=@"AM";
        [time1seg setSelectedSegmentIndex:0];
    }
    else
    {
        t1=@"PM";
         [time1seg setSelectedSegmentIndex:1];
    }
    if([[recorddict objectForKey:@"time21fm"] isEqual:@"AM"] )
    {
        t2=@"AM";
        [time2seg setSelectedSegmentIndex:0];
    }
    else
    {
        t2=@"PM";
        [time2seg setSelectedSegmentIndex:1];
    }
    if([[recorddict objectForKey:@"time31fm"] isEqual:@"AM"] )
    {
          t3=@"AM";
        
        [time3seg setSelectedSegmentIndex:0];
    }
    else
    {
        t3=@"PM";
        [time3seg setSelectedSegmentIndex:1];
    }
    username.text=[recorddict objectForKey:@"username"];
   // gender.text=[recorddict objectForKey:@"gender"];
        grouppicker.text=[recorddict objectForKey:@"groupname"];
    grouparray=[recorddict objectForKey:@"Grouplist"];
    entries=[[NSArray alloc]init];
    entriesSelected=[[NSArray alloc]init];
    selectionStates = [[NSMutableDictionary alloc] init];
    
    
    [self collectgroup:provider.text];
    
    
    UITapGestureRecognizer *tapGRage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTappedage)];
    [agepick addGestureRecognizer:tapGRage];
    UITapGestureRecognizer *tapGR4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped4)];
    [grouppick addGestureRecognizer:tapGR4];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped)];
    [timepick1 addGestureRecognizer:tapGR];
    UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped1)];
    [timepick2 addGestureRecognizer:tapGR1];
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped2)];
    [timepick3 addGestureRecognizer:tapGR2];
    
    // Do any additional setup after loading the view.
}

-(void)collectgroup:(NSString*)providername
{
    
    entries = grouparray;
    
    entriesSelected = [[NSArray alloc] init];
    
    
	selectionStates = [[NSMutableDictionary alloc] init];
    
  	for (NSString *key in entries){
        BOOL isSelected = NO;
        for (NSString *keyed in entriesSelected) {
            if ([key isEqualToString:keyed]) {
                isSelected = YES;
            }
        }
        [selectionStates setObject:[NSNumber numberWithBool:isSelected] forKey:key];
    }
    
    // NSLog(@"vales in f*n call %@",groupfinal);
    
}

- (void)pickerViewTapped
{
    timepick1.hidden=YES;
}
- (void)pickerViewTapped1
{
    timepick2.hidden=YES;
}
- (void)pickerViewTapped2

{
    timepick3.hidden=YES;
}

- (void)pickerViewTapped4

{
    grouppick.hidden=YES;
}
#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag==1)
        
        return [timearray count];
    
    else if(pickerView.tag==2)
        
        return [timearray count];
    
    else if (pickerView.tag==3)
        
        return [timearray count];
    else if(pickerView.tag==4)
        
        return [ageArray count];
    
    
    else if (pickerView.tag==5)
        
        return [grouparray count];
    else
        return 1;
}


#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag==1)
        
        return [timearray objectAtIndex:row];
    
    else if(pickerView.tag==2)
        
        return [timearray  objectAtIndex:row];
    
    else if(pickerView.tag==3)
        
        return [timearray  objectAtIndex:row];
    
    
    else if(pickerView.tag==5)
        return [grouparray objectAtIndex:row];
    else if (pickerView.tag==4)
        return [ageArray objectAtIndex:row];
    
    else
        return [timearray  objectAtIndex:row];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(timepick1.hidden==NO)
    {
        timepick1.hidden=YES;
    }
    if (timepick2.hidden==NO) {
        timepick2.hidden=YES;
    }
    if (timepick3.hidden==NO) {
        timepick3.hidden=YES;
    }
    if (grouppick.hidden==NO) {
        grouppick.hidden=YES;
    }
    if(agepick.hidden==NO)
    {
        agepick.hidden=YES;
    }
    
}

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag==1)
        
        time1.text=[timearray objectAtIndex:row];
    
    else if(pickerView.tag==2)
        
        time2.text=[timearray  objectAtIndex:row];
    else if(pickerView.tag==5)
    {
        grouppicker.text= [grouparray objectAtIndex:row];
        // selectedgroupid=[groupfinal objectAtIndex:row];
    }
    else if(pickerView.tag==3)
        time3.text= [timearray objectAtIndex:row];
    else if(pickerView.tag==4)
        agepicker.text=[ageArray objectAtIndex:row];
    else
        time3.text= [timearray objectAtIndex:row];
    pickerView.hidden=YES;
    
    //Let's print in the console what the user had chosen;
    // NSLog(@"Chosen item: %@", [itemsArray objectAtIndex:row]);
}
-(IBAction)changeTimeInLabel1:(id)sender
{
    if (timepick1.hidden==YES)
    {
        timepick1.hidden=NO;
        
    }
}
-(IBAction)changeTimeInLabel2:(id)sender
{
    if (timepick2.hidden==YES)
    {
        timepick2.hidden=NO;
        
    }
}
-(IBAction)changeTimeInLabel3:(id)sender
{
    if (timepick3.hidden==YES)
    {
        timepick3.hidden=NO;
        
    }
}

-(IBAction)changegroup:(id)sender
{
    if(grouppick.hidden==YES)
    {
        grouppick.hidden=NO;
    }
    [grouppick reloadAllComponents];
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[CYCustomMultiSelectPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    
    multiPickerView = [[CYCustomMultiSelectPickerView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 260-20, 320, 260+44)];
    
    //  multiPickerView.backgroundColor = [UIColor redColor];
    multiPickerView.entriesArray = entries;
    multiPickerView.entriesSelectedArray = entriesSelected;
    multiPickerView.multiPickerDelegate = self;
    
    [self.view addSubview:multiPickerView];
    
    [multiPickerView pickerShow];
    
}
// returns picker view selected string
#pragma mark - Delegate
-(void)returnChoosedPickerString:(NSMutableArray *)selectedEntriesArr
{
   // NSLog(@"selectedArray=%@",selectedEntriesArr);
    groupidlist=[recorddict objectForKey:@"groupid"];
    NSString *dataStr = [selectedEntriesArr componentsJoinedByString:@","];
    selectedgroupid=[[NSMutableArray alloc]init];
    showLbl.text = dataStr;
    grouppicker.text=dataStr;
    entriesSelected = [[NSArray arrayWithArray:selectedEntriesArr] retain];
    if(([selectedEntriesArr count]<=4)&&([selectedEntriesArr count]!=0))
    {
        grouppicker.text=dataStr;
        for (int i=0; i<[selectedEntriesArr count]; i++)
        {
            int indexValue = [grouparray indexOfObject:[selectedEntriesArr objectAtIndex:i]];
            //NSLog(@"%d %@ %lu",indexValue,[selectedEntriesArr objectAtIndex:i],(unsigned long)
            //[grouparray indexOfObject:[selectedEntriesArr objectAtIndex:i]]);
            [selectedgroupid addObject:[groupidlist objectAtIndex:indexValue]];
        }
        
        // NSLog(@"index %d",indexValue);
        // NSLog(@"selectedgroupid %@",selectedgroupid);
        [recorddict setObject:selectedEntriesArr forKey:@"selectedgroups"];
        [recorddict setObject:selectedgroupid forKey:@"selectedgroupsid"];
    }
    else if([selectedEntriesArr count]>4)
    {
        grouppicker.text=[recorddict objectForKey:@"groupname"];
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"" message:@"Please select maximum 4 groups."];
        
        //  [alert setCancelButtonWithTitle:@"Cancel" block:nil];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
    }
    else if([selectedEntriesArr count]==0)
    {
        grouppicker.text=[recorddict objectForKey:@"groupname"];
    }
    
    
    
}
-(IBAction)changeage:(id)sender
{
    if(agepick.hidden==YES)
    {
        agepick.hidden=NO;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)validateEmail:(NSString*)candidate{
    NSString *emailFormat1 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}";
    
    
    NSPredicate *emailTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailFormat1];
    return [emailTest1 evaluateWithObject:candidate];
    
}
-(BOOL)alphabeticsymbolvalidation:(NSString *)country1
{
    NSString *countryFormat1 = @"(?:[A-Za-z0-9._@-]+)";
    
    // [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}
-(BOOL)alphanumericvalidation:(NSString *)country1
{
    NSString *countryFormat1 = @"(?:[A-Za-z0-9]+)";
    
    // [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}

-(BOOL)validateMobile:(NSString*)mobilenumber{
    NSString *mobileFormat1 =  @"[0-9]{10}";
    //  NSString *mobileFormat1=@"((?([0-9]{3}))?[-. ]?([0-9]{3})[-. ]?([0-9]{4}))";
    [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *mobileTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat1];
    return [mobileTest1 evaluateWithObject:mobilenumber];
    
}
-(BOOL)zipcodevalidation:(NSString *)country1
{
    NSString *countryFormat1 = @"[0-9]{5}";
    
    // [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}
// Submission action using http posting json data & json parsing
- (IBAction)submit:(id)sender
{
    if(([fname.text length]!=0)&&([mobile.text length]!=0)&&([username.text length]!=0)&&([email.text length]!=0)&&(![grouppicker.text isEqualToString:@""]))
    {
        NSString *fsname = [fname.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *mnum = [mobile.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([self alphanumericvalidation:fsname]==1)
        {
            //errorlabel.hidden=YES;
           if ([self alphabeticsymbolvalidation:username.text]==1)
            {
                //errorlabel.hidden=YES;
                if ([self validateMobile:mnum]==1)
                {
                    //errorlabel.hidden=YES;
                    if ([self validateEmail:email.text]==1)
                    {
                        //errorlabel.hidden=YES;
                        [recorddict setValue:fname.text forKey:@"FirstName"];
                        [recorddict setValue:username.text forKey:@"UserName"];
                        [recorddict setValue:agepicker.text forKey:@"age"];
                        if ([medical.text  isEqual: @""])
                        {
                            a=1;
                            medical.text=@"";
                            [recorddict setValue:medical.text forKey:@"Medicaldetails"];
                        }
                        else
                        {
                            a=1;
                            [recorddict setValue:medical.text forKey:@"Medicaldetails"];
                        }
                        if ([city.text  isEqual: @""]) {
                            city.text=@"";
                            a=1;
                            [recorddict setValue:city.text forKey:@"City"];
                            
                        }
                        else
                        {
                            a=0;
                            if ([self zipcodevalidation:[city text]]==1)
                            {
                                a=1;
                                //errorlabel.hidden=YES;
                                [recorddict setValue:city.text forKey:@"City"];
                                
                            }
                            else
                            {
                                a=0;
                               // errorlabel.hidden=NO;
                               //errorlabel.text=@"Only 5 digits,0-9 allowed";
                                BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter valid Zipcode.Only 5 digits,0-9 allowed."];
                                [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                                [alert show];
                            }

                            
                        }

                        [recorddict setValue:city.text forKey:@"city"];
                        [recorddict setValue:education forKey:@"education"];
                        [recorddict setValue:medical.text forKey:@"medical"];
                        // [recorddict setObject:selectedgroupid forKey:@"Groupid"];
                        [recorddict setValue:time1.text forKey:@"Preferred Time1"];
                        [recorddict setValue:t1 forKey:@"Preferred Time1 format"];
                        [recorddict setValue:time2.text forKey:@"Preferred Time2"];
                        [recorddict setValue:t2 forKey:@"Preferred Time2 format"];
                        [recorddict setValue:time3.text forKey:@"Preferred Time3"];
                        [recorddict setValue:t3 forKey:@"Preferred Time3 format"];
                        [recorddict setValue:provider.text forKey:@"Provider"];
                        //[recorddict setValue:grouppicker.text forKey:@"group"];
                       // NSLog(@"complete patient list %@",recorddict);
                        if (a==1)
                        {
                            
                        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
                        [self.navigationController.view addSubview:HUD];
                        HUD.delegate = self;
                        HUD.labelText = @"Updating";
                        [HUD show:YES];
                        [self performSelector:@selector(signUpMethod)withObject:nil afterDelay:0.2 ];
                        }
                        
                        
                        
                    }
                    else
                    {
                       // errorlabel.hidden=NO;
                        //errorlabel.text=@"example@contoso.com";
                        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter valid E-mail id.Only example@contoso.com allowed."];
                        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                        [alert show];
                    }
                }
                else
                {
                    //errorlabel.hidden=NO;
                    //errorlabel.text=@"Only 10 digits,0-9 allowed";
                    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter valid Mobile Number.Only 10 digits,0-9 allowed."];
                    [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                    [alert show];
                }
                
                
            }
            else
            {
                //errorlabel.hidden=NO;
                //errorlabel.text=@"Only a-z,0-9,- @ . _ allowed";
                BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter valid User Name.Only a-z,0-9,-@._allowed."];
                [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                [alert show];
            }
        }
        else
        {
            //errorlabel.hidden=NO;
            //errorlabel.text=@"Only a-z,0-9 allowed";
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter valid First Name.Only a-z,0-9 allowed."];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
    }
    
    else
    {
        
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter all the required fields."];
        [alert setDestructiveButtonWithTitle:@"OK" block:nil];
        [alert show];
        
    }
    
}
-(void)signUpMethod
{
    //  NSLog(@"Signup");
    
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
	switch (netStatus)
	{
		case NotReachable:
		{
			isConnect=NO;
			//NSLog(@"Access Not Available");
			break;
		}
			
		case ReachableViaWWAN:
		{
			isConnect=YES;
			//NSLog(@"Reachable WWAN");
			break;
		}
		case ReachableViaWiFi:
		{
			isConnect=YES;
			//NSLog(@"Reachable WiFi");
			break;
		}
	}
	
	
    
    if(isConnect)
    {
        
    }
    //  imgName=@"Connected.png";
    else
    {
        HUD.labelText = @"Check network connection";
        HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]] autorelease];
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD hide:YES afterDelay:1];
        return;
    }
    
    
    NSString*loginid=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginid"];
   // NSLog(@"userid %@",loginid);
    NSString *resultResponse=[self HttpPostEntityFirst:@"loginid" ForValue1:loginid EntitySecond:@"authkey" ForValue2:@"rzTFevN099Km39PV"];
    
     //NSLog(@"********%@",resultResponse);
    //   NSLog(@"REGISTRATION");
    
    NSError *error;
    
    SBJSON *json = [[SBJSON new] autorelease];
    NSDictionary *luckyNumbers = [json objectWithString:resultResponse error:&error];
    NSDictionary* menu = [luckyNumbers objectForKey:@"serviceresponse"];
    //NSLog(@"%@ lucky numbers",luckyNumbers);
    if (luckyNumbers == nil)
    {
        
        //NSLog(@"luckyNumbers == nil");
        
    }
    else
    {
        
        
        
        
        if ([[menu objectForKey:@"success"] isEqualToString:@"Yes"])
        {
            
            
            
            // NSLog(@"Start Sending");
            HUD.labelText = @"Completed";
            HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD hide:YES afterDelay:0];
            
            //NSLog(@"success");
            /*
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"successfully updated!"];
            
            
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
            */
                        [self performSegueWithIdentifier:@"edittodashboard" sender:self];
            
            
            
        }
        else if ([[menu objectForKey:@"success"] isEqualToString:@"No"]&&[[menu objectForKey:@"message"] isEqualToString:@"Already Exist"])
        {
            if ([[menu objectForKey:@"emaill"]  isEqualToString:@"emailexist"])
            {
                // NSLog(@"Start Sending in email exist");
                BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Emailid already exists."];
                
                
                [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                [alert show];
            }
            else if ([[menu objectForKey:@"emaill"]  isEqualToString:@"mobilenumexist"])
            {
                BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Mobile Number already exists."];
                
                
                [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                [alert show];
            }

            
        }
        else
        {
            // NSLog(@"else Start Sending");
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Updation failed."];
            
            
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
        
        
        
        
        
        [HUD hide:YES];
    }
    
}

-(NSString *)HttpPostEntityFirst:(NSString*)firstEntity ForValue1:(NSString*)value1 EntitySecond:(NSString*)secondEntity ForValue2:(NSString*)value2
{
    //updating patient info into database
    
    
    
    //NSLog(@"HTTP");
    NSString*firstname=fname.text;
    NSString *username1=username.text;
    NSString*mobnum=mobile.text;
   NSString *emailid=email.text;
    NSString *oldemail=[recorddict objectForKey:@"email"];
    NSString*age1=agepicker.text;
    NSString*city1=city.text;
    NSString*edu=education;
    NSString *meddet=medical.text;
        NSString *oldmobilenum=[recorddict objectForKey:@"mobile"];
    NSString*pt1=[recorddict objectForKey:@"Preferred Time1"];
    NSString*pt2=[recorddict objectForKey:@"Preferred Time2"];
    NSString*pt3=[recorddict objectForKey:@"Preferred Time3"];
    NSString *tf1=[recorddict objectForKey:@"Preferred Time1 format"];
    NSString *tf2=[recorddict objectForKey:@"Preferred Time2 format"];
    NSString *tf3=[recorddict objectForKey:@"Preferred Time3 format"];
    NSString*prov=provider.text;
    
    if ([education isEqualToString:@""]) {
        edu=@"";
        
    }
    else
    {
        edu=education;
    }
       if (([pt1 isEqualToString:@""])|| ([pt1 isEqualToString:@"Select time"]))
    {
        
        pt1=@"null";
        tf1=@"AM";
    }
    else
    {
        pt1=[recorddict objectForKey:@"Preferred Time1"];
        tf1=[recorddict objectForKey:@"Preferred Time1 format"];


    }
    
    if (([pt2 isEqualToString:@""])||([pt2 isEqualToString:@"Select time"])) {
        
        pt2=@"null";
    tf2=@"AM";
    }
    else
    {
        pt2=[recorddict objectForKey:@"Preferred Time2"];
        tf2=[recorddict objectForKey:@"Preferred Time2 format"];
        
    }
    if (([pt3 isEqualToString:@""])||([pt3 isEqualToString:@"Select time"])) {
        //time3.text=@"";
        pt3=@"null";
        tf3=@"AM";
    }
    else
    {
        pt3=[recorddict objectForKey:@"Preferred Time3"];
        tf3=[recorddict objectForKey:@"Preferred Time3 format"];

    }
    if(![grouppicker.text isEqual:[recorddict objectForKey:@"groupname"]])
    {
       // NSLog(@"changed the group");
        arrayWithIDs=[recorddict objectForKey:@"selectedgroups"];
        arrayWithIDvalues=[recorddict objectForKey:@"selectedgroupsid"];
        postVarArrayString = @"";
        postVarArrayStringid = @"";
        int j=[arrayWithIDs count];
        //NSString *separator= @"&";;
        for (int i=0; i<[arrayWithIDs count]; i++) {
            postVarArrayString = [NSString stringWithFormat:@"%@%@", postVarArrayString, [arrayWithIDs objectAtIndex:i] ];
            postVarArrayStringid = [NSString stringWithFormat:@"%@%d", postVarArrayStringid, [[arrayWithIDvalues objectAtIndex:i] integerValue]];
            if(i==j-1)
            {
                postVarArrayString = [NSString stringWithFormat:@"%@", postVarArrayString];
                postVarArrayStringid =  [NSString stringWithFormat:@"%@", postVarArrayStringid];
            }
            else
            {
                postVarArrayString = [NSString stringWithFormat:@"%@-", postVarArrayString];
                postVarArrayStringid =  [NSString stringWithFormat:@"%@-", postVarArrayStringid];
            }
            
            
        }
       // NSLog(@"%@ group",postVarArrayString);
       // NSLog(@"%@ groupid",postVarArrayStringid);
        
    }
    else
    {
       // NSLog(@"doesnot selected groups");
        arrayWithIDs=[recorddict objectForKey:@"participantgroupname"];
        arrayWithIDvalues=[recorddict objectForKey:@"participantgroupid"];
       // NSLog(@"arraynames %@",arrayWithIDs);
       // NSLog(@"arrayidvalues %@",arrayWithIDvalues);
        
        postVarArrayString = @"";
        postVarArrayStringid = @"";
        int j=[arrayWithIDs count];
        //NSString *separator= @"&";;
        for (int i=0; i<[arrayWithIDs count]; i++)
        {
            postVarArrayString = [NSString stringWithFormat:@"%@%@", postVarArrayString, [arrayWithIDs objectAtIndex:i] ];
            postVarArrayStringid = [NSString stringWithFormat:@"%@%d", postVarArrayStringid, [[arrayWithIDvalues objectAtIndex:i] integerValue]];
            if(i==j-1)
            {
                postVarArrayString = [NSString stringWithFormat:@"%@", postVarArrayString];
                postVarArrayStringid =  [NSString stringWithFormat:@"%@", postVarArrayStringid];
            }
            else
            {
                postVarArrayString = [NSString stringWithFormat:@"%@-", postVarArrayString];
                postVarArrayStringid =  [NSString stringWithFormat:@"%@-", postVarArrayStringid];
            }
            
            
        }
       // NSLog(@"%@ group",postVarArrayString);
       // NSLog(@"%@ groupid",postVarArrayStringid);
    }
    
    // NSLog(@"%@ selected groupid",selectedgroupid);
   // NSLog(@"%@ group",postVarArrayString);
   // NSLog(@"%@ groupid",postVarArrayStringid);
    NSString *post =[[NSString alloc] initWithFormat:@"%@=%@&fname=%@&mobile_num=%@&old_mobile_num=%@&gender=%@&city=%@&education=%@&medical_details=%@&time1=%@&time1format=%@&time2=%@&time2format=%@&time3=%@&time3format=%@&Provider_name=%@&group_name=%@&age=%@&username1=%@&groupid=%@&groupname=%@&email=%@&oldemailid=%@&%@=%@",firstEntity,value1,firstname,mobnum,oldmobilenum,gend,city1,edu,meddet,pt1,tf1,pt2,tf2,pt3,tf3,prov,postVarArrayString,age1,username1,postVarArrayStringid, grouppicker.text,emailid,oldemail,secondEntity,value2];
    
 // NSLog(@"post %@",post);
    
    NSURL *url=[NSURL URLWithString:@"http://www.medsmonit.com/bcreasearch/Service/genericUpdate.php?service=patientupdate"];
    
    
    
// NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    // NSLog(@"postlenth%@",postLength);
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //when we user https, we need to allow any HTTPS cerificates, so add the one line code,to tell teh NSURLRequest to accept any https certificate, i'm not sure //about the security aspects
    
    
    //    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
  // NSLog(@"response %@",data);
    
    
    
    
    
    
    return data;
    
}

- (void)dealloc {
    [submit release];
    [errorlabel release];
    [super dealloc];
}
@end
