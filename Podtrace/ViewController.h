//
//  ViewController.h
//  Podtrace
//
//  Created by Jerry Leung on 6/1/17.
//  Copyright © 2017 iPwn Technologies Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *centralManager;



@end

