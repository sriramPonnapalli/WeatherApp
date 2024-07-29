//
//  WeatherService.m
//  WeatherFramework
//
//  Created by sriram ponnapalli on 12/07/24.
//

#import "WeatherService.h"

@implementation WeatherService
- (void)weatherInfoWithLatitude:(double)latitude
                      longitude:(double)longitude
                     completion:(void (^)(NSDictionary *weatherDetails, NSError *error))completion {
    // Construct the URL for Google Weather API
    NSString *urlString = [NSString stringWithFormat:@"https://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&q=%f,%f&aqi=no", latitude, longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        completion(json, nil);
    }];
    [dataTask resume];
}

- (void)weatherInfoWithAddress:(NSString *)address
                    completion:(void (^)(NSDictionary *weatherDetails, NSError *error))completion {
    // Construct the URL for Google Weather API
    NSString *urlString = [NSString stringWithFormat:@"https://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&q=%@&aqi=no", address];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        completion(json, nil);
    }];
    [dataTask resume];
}
@end
