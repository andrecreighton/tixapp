//
//  PVParkingViolationInfo.h
//  TicketInfo
//
//  Created by Andre Creighton on 4/19/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface PVParkingViolationInfo : NSObject







-(void)grabParkingViolationInfoUsingLicensePlate:(NSString *)licensePlate withBlock:(void (^)(NSArray* infoFound))blockCompletion;

@end
