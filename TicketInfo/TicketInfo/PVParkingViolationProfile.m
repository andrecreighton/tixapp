//
//  PVParkingViolationProfile.m
//  TicketInfo
//
//  Created by Andre Creighton on 4/21/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import "PVParkingViolationProfile.h"

@implementation PVParkingViolationProfile






+(PVParkingViolationProfile *)collectFromDictionary:(NSDictionary *)dictionary
{
    
    PVParkingViolationProfile *profile = [[PVParkingViolationProfile alloc] init];
    profile.amountDue = [dictionary[@"amount_due"] integerValue];
    profile.issueDate = dictionary[@"issue_date"];
    profile.state     = dictionary[@"state"];
    profile.plateNumber = dictionary[@"plate"];
    profile.violationDescription = dictionary[@"violation"];
    

    return profile;
}



@end
