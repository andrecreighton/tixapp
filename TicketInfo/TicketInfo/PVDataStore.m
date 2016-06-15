//
//  PVDataStore.m
//  TicketInfo
//
//  Created by Andre Creighton on 4/21/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import "PVDataStore.h"

@implementation PVDataStore

+(instancetype)sharedDataStore{
    
    static PVDataStore *_sharedDataStore = nil;
  
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[PVDataStore alloc] init];
    });
    
    return _sharedDataStore;
    
}

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        
        _parkingInfo = [NSMutableArray new];
        _parkingInfoAfterSearch = [NSMutableArray new];
        
    }
    
    
    return self;
    
}


-(void)searchForParkingPVInfoUsingLicensePlate:(NSString *)licensePlate withCompletion:(void (^)(NSArray *array))completion
{
  
    PVParkingViolationInfo *info = [PVParkingViolationInfo new];
  
    [self.parkingInfoAfterSearch removeAllObjects];
    
    [info grabParkingViolationInfoUsingLicensePlate:licensePlate withBlock:^(NSArray *infoFound) {
    
        for(NSDictionary *dictionary in infoFound)
        {
        
            [self.parkingInfoAfterSearch addObject:[PVParkingViolationProfile collectFromDictionary:dictionary]];
            
        }
        [self.parkingInfo removeAllObjects];
        
        [self.parkingInfo addObjectsFromArray:self.parkingInfoAfterSearch];
        
           NSLog(@"parking info count %li", self.parkingInfo.count);
        
        
        
        completion(self.parkingInfo);
        
    }];
    
    
    
}



@end
