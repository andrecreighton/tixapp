//
//  PVParkingViolationInfo.m
//  TicketInfo
//
//  Created by Andre Creighton on 4/19/16.
//  Copyright © 2016 Andre. All rights reserved.
//

#import "PVParkingViolationInfo.h"

@interface PVParkingViolationInfo ()

@property(strong,nonatomic) NSMutableArray *arrayOfViolations;
@property(strong,nonatomic) NSString *appTokenString;
@property(strong,nonatomic) NSMutableArray *arrayContainingViolationInfo;

@end


@implementation PVParkingViolationInfo


-(void)grabParkingViolationInfoUsingLicensePlate:(NSString *)licensePlate withBlock:(void (^)(NSArray* infoFound))blockCompletion{

    
    NSString *string = [NSString stringWithFormat:@"https://data.cityofnewyork.us/resource/uvbq-3m68.json?plate=%@",licensePlate];
    
    NSURL *url = [NSURL URLWithString:string];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
       
        
        if(data == nil)
        {
            [self inValidEntryNotification];
        }
        else{
        
        NSArray* arrayOfViolations = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", arrayOfViolations);
        blockCompletion(arrayOfViolations);
        }
        
    }];
    
    [dataTask resume];
    
    
}


-(void)inValidEntryNotification
{
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"inValidEntry"
     object:self];
    
}




@end
