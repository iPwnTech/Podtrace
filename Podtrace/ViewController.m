//
//  ViewController.m
//  Podtrace
//
//  Created by Jerry Leung on 6/1/17.
//  Copyright © 2017 iPwn Technologies Pty Ltd. All rights reserved.
//

#import "ViewController.h"
#import <MBCircularProgressBar/MBCircularProgressBarView.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *proximityBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
}


- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.proximityBar.value == 0) {
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showWithStatus:@"Searching for your AirPods. Ensure your Bluetooth is enabled."];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (self.proximityBar.value == 0) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:@"Failed to find AirPods. Please move elsewhere and restart the search."];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        });
        
    }
    
}



- (void)viewDidDisappear {
    
    [self.centralManager stopScan];

}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    NSDictionary *scansettings = [NSDictionary dictionaryWithObjectsAndKeys:@YES, CBCentralManagerScanOptionAllowDuplicatesKey, nil];
    [self.centralManager scanForPeripheralsWithServices:nil options:scansettings];
    
}



- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; {

    if ([peripheral.name rangeOfString:[[NSUserDefaults standardUserDefaults] stringForKey:@"airpodName"] options:NSCaseInsensitiveSearch].location != NSNotFound && peripheral.name != nil)
    {
        
        [SVProgressHUD dismiss];
        
        float absoluterssi = fabs(RSSI.doubleValue);
        float min = 40;
        float max = 80;
        float percentagerssi;
        
        
        if (absoluterssi < min) {
            percentagerssi = 100;
        }
        else {
            percentagerssi = (1-(absoluterssi - min)/(max-min))*100;
        }
        
        [UIView animateWithDuration:1.f animations:^{
            self.proximityBar.value = percentagerssi;
        }];
        
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
