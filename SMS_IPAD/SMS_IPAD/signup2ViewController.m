//
//  signup2ViewController.m
//  SMSIPAD
//
//  Created by DeemSysInc on 12/11/13.
//  Copyright (c) 2013 DeemSysInc. All rights reserved.
//

#import "signup2ViewController.h"
#import "signup3ViewController.h"
#import "BlockAlertView.h"

@interface signup2ViewController ()

@end

@implementation signup2ViewController
@synthesize recorddict;
@synthesize agepick;
@synthesize ageArray;
@synthesize agepicker;
@synthesize seggender;
@synthesize gender;
@synthesize educationseg;
@synthesize zipcodeerr;



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
    if (textField.tag==10) {
        
        NSUInteger newLength = [city.text length] + [string length] - range.length;
        return (newLength > 5) ? NO : YES;
    }
    else
        return YES;
}
- (void)viewDidLoad
{
    edu=@"";
    reset.clipsToBounds = YES;
    reset.layer.cornerRadius = 5.0f;
    next.clipsToBounds = YES;
    next.layer.cornerRadius = 5.0f;
    medicaldetails.clipsToBounds = YES;
    medicaldetails.layer.cornerRadius = 5.0f;
    cancel.clipsToBounds=YES;
    cancel.layer.cornerRadius=5.0f;
    [agepick setBackgroundColor:([UIColor whiteColor])];
    [super viewDidLoad];
    agepick.delegate = self;
    agepick.dataSource = self;
    
    agepick.hidden=YES;
    city.delegate=self;
    UIColor * color = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    [zipcodeerr setTextColor:color];
    medicaldetails.delegate=self;
    
    agepicker.text=@"Below 12";
    ageArray = [[NSArray alloc] initWithObjects:@"Below 12", @"12-20 years", @"21-30 years", @"31-40 years", @"41-50 years",@"51-60 years",@"61-70 years",@"71-80 years",@"81-90 years",@"91-100 years", nil];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"city"] length]>0)
    {
        city.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"city"];
    }
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"meddetail"] length]>0)
    {
        medicaldetails.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"meddetail"];
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"age"]length]>0) {
        agepicker.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"age"];
        [agepick selectRow:[ageArray indexOfObject:agepicker.text] inComponent:0 animated:NO];

    }
    
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"gender"]isEqualToString:@"0"])
        {
            gender.text=@"0";
            [seggender setSelectedSegmentIndex:0];
        }
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"gender"]isEqualToString:@"1"])
        {
            gender.text=@"1";
            [seggender setSelectedSegmentIndex:1];
        }
    else
    {
        gender.text=@"0";
    }
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"education"] length]>0)
    {
        edu=[[NSUserDefaults standardUserDefaults]objectForKey:@"education"];
        if ([edu isEqualToString:@"Did not complete High School"])
        {
            [educationseg setSelectedSegmentIndex:0];
        }
        else if ([edu isEqualToString:@"High School or GED"])
        {
            [educationseg setSelectedSegmentIndex:1];
        }
        else if ([edu isEqualToString:@"Some College"])
        {
            [educationseg setSelectedSegmentIndex:2];
        }
        else if ([edu isEqualToString:@"Undergraduate Degree"])
        {
            [educationseg setSelectedSegmentIndex:3];
        }
        else if([edu isEqualToString:@"Post-graduate Degree"])
        {
            [educationseg setSelectedSegmentIndex:4];
        }
       

    }
    

    
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewTapped)];
    [agepick addGestureRecognizer:tapGR];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    /*
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(5.0,2.0,45.0,45.0)];
    [button1 addTarget:self action:@selector(home:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:[UIImage imageNamed:@"backbutton.png"] forState:UIControlStateNormal];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithCustomView:button1];
    self.navigationItem.leftBarButtonItem = button;*/
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@" Back" style:UIBarButtonItemStyleBordered target:self action:@selector(home:)];
    
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    
   
    

	// Do any additional setup after loading the view.
}
-(void)home:(UIBarButtonItem *)sender
{
if([city.text length]>0)
   {
       [[NSUserDefaults standardUserDefaults]setObject:city.text forKey:@"city"];
       
   }
    if([medicaldetails.text length]>0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:medicaldetails.text forKey:@"meddetail"];
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:agepicker.text forKey:@"age"];
    [[NSUserDefaults standardUserDefaults]setObject:gender.text forKey:@"gender"];
    [[NSUserDefaults standardUserDefaults]setObject:edu forKey:@"education"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];
   
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    c=0;
}
-(void)dismissKeyboard
{
    [city resignFirstResponder];
    
    [medicaldetails resignFirstResponder];
}
- (void)pickerViewTapped
{
        agepick.hidden=YES;
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
    
      return [ageArray count];
    
   
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
    
        return [ageArray objectAtIndex:row];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(agepick.hidden==NO)
    {
        agepick.hidden=YES;
    }
    if (agepick) agepick.hidden = !agepick.hidden;
   }

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag==1)
        
        agepicker.text=[ageArray objectAtIndex:row];
    pickerView.hidden=YES;
    
   
    //Let's print in the console what the user had chosen;
   // NSLog(@"Chosen item: %@", [itemsArray objectAtIndex:row]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)alphabeticvalidation:(NSString *)country1
{
    NSString *countryFormat1 = @"(?:[A-Za-z]+)";
    
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
-(BOOL)zipcodevalidation:(NSString *)country1
{
    NSString *countryFormat1 = @"[0-9]{5}";
    
    // [(UITextField*)[self.view viewWithTag:101] resignFirstResponder];
    NSPredicate *countryTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", countryFormat1];
    return [countryTest1 evaluateWithObject:country1];
    
}

-(IBAction)changeage:(id)sender
{
    if(agepick.hidden==YES)
    {
    agepick.hidden=NO;
    }
}
-(IBAction)seggenderclicked:(id)sender
{
    if([seggender selectedSegmentIndex]==0)
    {
      gender.text=@"0";
    }
    else if ([seggender selectedSegmentIndex]==1)
    {
        gender.text=@"1";

    }
}
-(IBAction)segeduclicked:(id)sender
{
    if([educationseg selectedSegmentIndex]==0)
        {
           edu=@"Did not complete High School";
        }
    else if([educationseg selectedSegmentIndex]==1)
    {
        edu=@"High School or GED";
    }
    else if([educationseg selectedSegmentIndex]==2)
    {
        edu=@"Some College";
    }
    else if([educationseg selectedSegmentIndex]==3)
    {
        edu=@"Undergraduate Degree";
    }
    else if([educationseg selectedSegmentIndex]==4)
    {
        edu=@"Post-graduate Degree";
    }

}

- (IBAction)cancel:(id)sender
{
    city.text=@"";
    medicaldetails.text=@"";
    zipcodeerr.hidden=YES;
    agepicker.text=@"Below 12";
    gender.text=@"0";
    edu=@"";
    [self.agepick selectRow:0 inComponent:0 animated:YES];
    [seggender setSelectedSegmentIndex:0];
    [educationseg setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"city"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"meddetail"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"age"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"gender"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"education"];

}
-(IBAction)next:(id)sender
{

   
    if([city.text length]>0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:city.text forKey:@"city"];
        
    }
    if([medicaldetails.text length]>0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:medicaldetails.text forKey:@"meddetail"];
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:agepicker.text forKey:@"age"];
    [[NSUserDefaults standardUserDefaults]setObject:gender.text forKey:@"gender"];
    [[NSUserDefaults standardUserDefaults]setObject:edu forKey:@"education"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [recorddict setValue:gender.text forKey:@"Gender"];
    [recorddict setValue:agepicker.text forKey:@"Age"];
// NSLog(@"gender %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"gender"]);
    if ([medicaldetails.text  isEqual: @""]) {
        medicaldetails.text=@"";
            c=1;
        [recorddict setValue:medicaldetails.text forKey:@"Medicaldetails"];
    }
    else
    {
            c=1;
        [recorddict setValue:medicaldetails.text forKey:@"Medicaldetails"];
    }
    if ([edu isEqualToString:@""])
    {
     [recorddict setValue:edu forKey:@"Education"];
    }
    else
    {
        [recorddict setValue:edu forKey:@"Education"];
    }
    if ([city.text  isEqual: @""]) {
       city.text=@"";
            c=1;
        [recorddict setValue:city.text forKey:@"City"];

    }
    
    else
    {
        if ([self zipcodevalidation:[city text]]==1)
        {
            //zipcodeerr.hidden=YES;
                c=1;
            [recorddict setValue:city.text forKey:@"City"];

        }
        else
        {
            c=0;
            //zipcodeerr.hidden=NO;
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter valid Zipcode.Only 5 digits,0-9 allowed."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
        }
        
    }
    

     /*  if([city.text length]!=0)
    {
       if([self alphabeticvalidation:city.text]==1)
       {
             [recorddict setValue:city.text forKey:@"City"];
           c=1;
           if([education.text length]!=0)
           {
               if([self alphabeticvalidation:education.text]==1)
               {  c=1;
                   [recorddict setValue:education.text forKey:@"Education"];
                   if([medicaldetails.text length]!=0)
                   {
                       if ([self alphanumericvalidation:medicaldetails.text]==1)
                       {  c=1;
                           [recorddict setValue:medicaldetails.text forKey:@"Medicaldetails"];
                       }
                       else
                       {
                           
                           BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Medical details."];
                           [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                           [alert show];
                       }
                   }

               }
               else
               {
                   BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Education detail."];
                   [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                   [alert show];
               }
               
           }
           else
           {
               if([medicaldetails.text length]!=0)
               {
                   if ([self alphanumericvalidation:medicaldetails.text]==1)
                   {  c=1;
                       [recorddict setValue:medicaldetails.text forKey:@"Medicaldetails"];
                   }
                   else
                   {
                       
                       BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Medical details."];
                       [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                       [alert show];
                   }
               }
  
           }

       }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid city."];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
    }
    else if([education.text length]!=0)
    {
           if([self alphabeticvalidation:education.text]==1)
           {
             [recorddict setValue:education.text forKey:@"Education"];
               if([medicaldetails.text length]!=0)
               {
                   if ([self alphanumericvalidation:medicaldetails.text]==1)
                   {  c=1;
                       [recorddict setValue:medicaldetails.text forKey:@"Medicaldetails"];
                   }
                   else
                   {
                       
                       BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Medical details."];
                       [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                       [alert show];
                   }
               }

               
           }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Education detail."];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
        
    }
    else if([medicaldetails.text length]!=0)
    {
        if ([self alphanumericvalidation:medicaldetails.text]==1)
        {  c=1;
            [recorddict setValue:medicaldetails.text forKey:@"Medicaldetails"];
        }
        else
        {
            
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Medical details."];
            [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
            [alert show];
        }
    }
    if(([city.text length]!=0)&&([education.text length]!=0)&&([medicaldetails.text length]!=0))
    {
        if([self alphabeticvalidation:city.text]==1)
        {
            if([self alphabeticvalidation:education.text]==1)
            {
                if ([self alphanumericvalidation:medicaldetails.text]==1) {
                    
              
    [recorddict setValue:gender.text forKey:@"Gender"];
    [recorddict setValue:agepicker.text forKey:@"Age"];
    [recorddict setValue:city.text forKey:@"City"];
    [recorddict setValue:education.text forKey:@"Education"];
    [recorddict setValue:medicaldetails.text forKey:@"Medicaldetails"];
    
    c=1;
                }
            else
                {
                    BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Medical details."];
                        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                        [alert show];
                    }

            }
            else
            {
                BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid Education detail."];
                [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
                [alert show];
            }

            
        }
        else
        {
            BlockAlertView *alert = [BlockAlertView alertWithTitle:@"INFO!" message:@"Enter Valid city."];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
        }
    }
    else
    {
        BlockAlertView *alert=[[BlockAlertView alloc]initWithTitle:@"INFO!" message:@"Enter all the required fields"];
        [alert setDestructiveButtonWithTitle:@"Ok" block:nil];
        [alert show];
        
        
    }*/
    if(c==1)
        [self performSegueWithIdentifier:@"signup2to3" sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"signup2to3"])
    {
        
        
        signup3ViewController *destViewController = [segue destinationViewController];
        destViewController.recorddict=recorddict;
      //  NSLog(@"recorddict in signup2 %@",recorddict);
        // destViewController.delegate=self;
        
    }
    
    
    
}

-(IBAction)clear:(id)sender
{
   city.text=@"";
    medicaldetails.text=@"";
    zipcodeerr.hidden=YES;
    agepicker.text=@"Below 12";
    gender.text=@"0";
    edu=@"";
    [self.agepick selectRow:0 inComponent:0 animated:YES];
    [seggender setSelectedSegmentIndex:0];
    [educationseg setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"city"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"meddetail"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"age"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"gender"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"education"];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    c=0;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (IBAction)hideKeyboard:(id)sender
{
   // NSLog(@"hideKeyboard");
    [sender resignFirstResponder];
}

- (void)dealloc {
    [reset release];
    [next release];
    [zipcodeerr release];
    [cancel release];
    [super dealloc];
}
@end
