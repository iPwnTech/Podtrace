//
//  FirstLaunch.m
//  Podtrace
//
//  Created by Jerry Leung on 6/1/17.
//  Copyright © 2017 iPwn Technologies Pty Ltd. All rights reserved.
//

#import "FirstLaunch.h"

@interface FirstLaunch ()

@end

@implementation FirstLaunch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"airpodName"] != nil) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"HasName"];
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
