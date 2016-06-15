//
//  PVParkingDetailViewController.m
//  TicketInfo
//
//  Created by Andre Creighton on 4/26/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import "PVParkingDetailViewController.h"

@interface PVParkingDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *licensePlateLabel;
@property (strong, nonatomic) IBOutlet UILabel *issueDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountDueLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;





@end

@implementation PVParkingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.licensePlateLabel.text = self.profile.plateNumber;
    self.issueDateLabel.text = self.profile.issueDate;
   self.amountDueLabel.text = [NSString stringWithFormat:@"%li",(long)self.profile.amountDue];
    self.stateLabel.text = self.profile.state;
    self.descriptionTextView.text = self.profile.violationDescription;
    
    
}


- (IBAction)doneButton:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
