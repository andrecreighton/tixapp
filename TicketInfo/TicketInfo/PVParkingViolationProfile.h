//
//  PVParkingViolationProfile.h
//  TicketInfo
//
//  Created by Andre Creighton on 4/21/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVParkingViolationProfile : NSObject



// amountDue value will come from the key amount_due
@property (nonatomic,assign) NSInteger amountDue;

// issueDate value will come from the key issue_date
@property (nonatomic,strong) NSString *issueDate;

// state value will come from the key
@property (nonatomic,strong) NSString *state;

@property (nonatomic,strong) NSString *plateNumber;

@property (nonatomic,strong) NSString *violationDescription;


+(PVParkingViolationProfile *)collectFromDictionary:(NSDictionary *)dictionary;





@end
