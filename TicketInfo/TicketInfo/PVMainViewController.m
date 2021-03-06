//
//  ViewController.m
//  TicketInfo
//
//  Created by Andre Creighton on 4/18/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import "PVMainViewController.h"
#import "PVParkingDetailViewController.h"

@interface PVMainViewController () <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *viewInFrontOfTableView;
@property (strong, nonatomic) NSString *stringOfDate;
@property (strong, nonatomic) PVParkingViolationInfo *parkingInfo;
@property (strong, nonatomic) NSMutableArray *arrayContainingPVInfo;
@property (strong, nonatomic) PVDataStore  *dataStore;
@property (strong, nonatomic) PVParkingViolationProfile *profile;

@end

@implementation PVMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.dataStore = [PVDataStore sharedDataStore];
    self.titleLabel.text = @"Tix";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.viewInFrontOfTableView.backgroundColor = [UIColor whiteColor];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"inValidEntry"
                                               object:nil];
    
    
}


-(void)receiveNotification:(NSNotification *)notified
{
    
    
    if ([[notified name] isEqualToString:@"inValidEntry"])
    {
        
        
        
        UIAlertController *invalidLicensepPlateAlert = [UIAlertController alertControllerWithTitle:@":(" message:@"Invalid License Plate." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.searchBar.text = @"";
            
            [self.searchBar becomeFirstResponder];
            
        }];
        
        [invalidLicensepPlateAlert addAction:okAction];
        
        
        [self presentViewController:invalidLicensepPlateAlert animated:YES completion:nil];
        
        
    }
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataStore.parkingInfo.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.profile = self.dataStore.parkingInfo[indexPath.row];
    cell.textLabel.text = self.profile.plateNumber;
    cell.textLabel.textColor = [UIColor darkTextColor];
    cell.detailTextLabel.textColor = self.titleLabel.backgroundColor;
    cell.detailTextLabel.text = self.profile.issueDate;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    


    return 80;
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    
    
    self.arrayContainingPVInfo = [NSMutableArray new];
    self.parkingInfo = [[PVParkingViolationInfo alloc] init];
    

    
    [self.view endEditing: YES];
  
    NSString *licensePlate = [searchBar.text uppercaseString];

    [self.dataStore searchForParkingPVInfoUsingLicensePlate:licensePlate withCompletion:^(NSArray *array) {
        
       [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    
           
           if(array.count > 0)
           {
               
               
               [UIView animateWithDuration:.5 animations:^{
                   
                   self.viewInFrontOfTableView.alpha = 0;
    
               }];
               
               
               
           }
           
           
           
           
           if(array.count == 0)
           {
               
            self.viewInFrontOfTableView.alpha = 1;
            
               [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
                   [self notificationMethod];
               }];
               
           }
           
            [self.tableView reloadData];
       }];
       
        
    }];
    
    
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    
    if(self.searchBar.text == 0)
    {
        
    [UIView animateWithDuration:.5 animations:^{
                
        self.viewInFrontOfTableView.alpha = 1;
    }];
        
    }
 
    return YES;
}

-(void)notificationMethod
{
    
    
    UIAlertController *noRecordOfViolation = [UIAlertController alertControllerWithTitle:@":)" message:@"No record available." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.searchBar.text = @"";
        
        [self.searchBar becomeFirstResponder];
    
    }];
    
    [noRecordOfViolation addAction:okAction];

    
    [self presentViewController:noRecordOfViolation animated:YES completion:nil];
    
}

- (IBAction)whenTapGestureRecognized:(id)sender {
    

    [self.view endEditing:YES];

    
    if(self.tableView != NULL && self.searchBar.text.length == 0)
    {
        [UIView animateWithDuration:.1 animations:^{
           
            self.viewInFrontOfTableView.alpha = 1;
            
        }];
      
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"Selected: %li", indexPath.row);
        
    });
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"detailVC"])
    {
    
    PVParkingDetailViewController *destVC = segue.destinationViewController;
    
        NSIndexPath *selectedPath = self.tableView.indexPathForSelectedRow;
        
        destVC.profile = self.dataStore.parkingInfo[selectedPath.row];
        
        
    }
    
    
}


@end
