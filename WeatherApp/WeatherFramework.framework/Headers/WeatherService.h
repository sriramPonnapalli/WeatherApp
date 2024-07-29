//
//  WeatherService.h
//  WeatherFramework
//
//  Created by sriram ponnapalli on 12/07/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherService : NSObject

- (void)weatherInfoWithLatitude:(double)latitude
                      longitude:(double)longitude
                     completion:(void (^)(NSDictionary *weatherDetails, NSError *error))completion;

- (void)weatherInfoWithAddress:(NSString *)address
                    completion:(void (^)(NSDictionary *weatherDetails, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
