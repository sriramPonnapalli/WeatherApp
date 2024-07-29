//
//  ViewController.m
//  WeatherApp
//  Testinggg
//  Created by sriram ponnapalli on 12/07/24.
// ok
 
#import "ViewController.h"
#import <WeatherFramework/WeatherService.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *longitudeTF;
@property (strong, nonatomic) IBOutlet UITextField *latitudeTF;
@property (strong, nonatomic) IBOutlet UILabel *conditionLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UILabel *windLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationNameLabel;

@property (nonatomic, strong) WeatherService *weatherService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weatherService = [[WeatherService alloc] init];
    self.searchBtn.layer.cornerRadius = 5;
    self.searchBtn.clipsToBounds = YES;
}

- (IBAction)searchBtnAct:(id)sender {
    double latitude = [self.latitudeTF.text doubleValue];
    double longitude = [self.longitudeTF.text doubleValue];
    
    [self.weatherService weatherInfoWithLatitude:latitude longitude:longitude completion:^(NSDictionary *weatherDetails, NSError *error) {
        if (error) {
            NSLog(@"Error fetching weather: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.conditionLabel.text = @"Error fetching weather";
                self.temperatureLabel.text = @"";
                self.windLabel.text = @"";
                self.locationNameLabel.text = @"";
            });
        } else {
            NSLog(@"Weather details: %@", weatherDetails);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *current = weatherDetails[@"current"];
                NSDictionary *location = weatherDetails[@"location"];
                self.conditionLabel.text = current[@"condition"][@"text"];
                self.temperatureLabel.text = [NSString stringWithFormat:@"%@°C", current[@"temp_c"]];
                self.windLabel.text = [NSString stringWithFormat:@"%@ km/h", current[@"wind_kph"]];
                self.locationNameLabel.text = location[@"name"];
            });
        }
    }];
}

@end


 /*    latitude      longitude         name
  
       42.546245     1.601554          Andorra
       23.424076     53.847818         United Arab Emirates
       33.93911      67.709953         Afghanistan
       17.060816     -61.796428        Antigua and Barbuda
       18.220554     -63.068615        Anguilla
       41.153332     20.168331         Albania
       40.069099     45.038189         Armenia
       12.226079     -69.060087        Netherlands Antilles
       -11.202692     17.873887        Angola
       -75.250973     -0.071389        Antarctica
       -38.416097     -63.616672       Argentina
       -14.270972     -170.132217      American Samoa
       47.516231     14.550072         Austria
*/
