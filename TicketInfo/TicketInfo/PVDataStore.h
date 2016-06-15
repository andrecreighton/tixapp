//
//  PVDataStore.h
//  TicketInfo
//
//  Created by Andre Creighton on 4/21/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PVParkingViolationInfo.h"
#import "PVParkingViolationProfile.h"

@interface PVDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *parkingInfo;
@property (strong, nonatomic) NSMutableArray *parkingInfoAfterSearch;


+(instancetype)sharedDataStore;

-(void)searchForParkingPVInfoUsingLicensePlate:(NSString *)licensePlate withCompletion:(void (^)(NSArray *array))completion;



@end
