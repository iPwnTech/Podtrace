//
//  SpecifyName.m
//  Podtrace
//
//  Created by Jerry Leung on 6/1/17.
//  Copyright © 2017 iPwn Technologies Pty Ltd. All rights reserved.
//

#import "SpecifyName.h"
#import "XLForm.h"

@interface SpecifyName ()

@end

@implementation SpecifyName

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *dismiss = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                style:UIBarButtonItemStyleDone target:self action:@selector(dismissClicked:)];
    self.navigationItem.rightBarButtonItem = dismiss;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}



- (void)initializeForm {
    
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"Configure Podtrace"];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"Name of AirPods"];
    section.footerTitle = @"This name must be the same as the name listed in under the Bluetooth menu in the Settings app. Ensure that it is correct otherwise the utility will not function as expected. This field is case sensitive.";
    [form addFormSection:section];
    
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"airpodName" rowType:XLFormRowDescriptorTypeText title:@"Name"];
    [row.cellConfigAtConfigure setObject:@"Name of AirPods" forKey:@"textField.placeholder"];
    row.value = [[NSUserDefaults standardUserDefaults] stringForKey:@"airpodName"];
    [section addFormRow:row];
    


    self.form = form;
}


- (void) dismissClicked:(id) sender {
    
    NSDictionary *dict = [self formValues];
    NSString *valueToSave = dict[@"airpodName"];
    
    
    if (valueToSave == (id)[NSNull null]) {
        UIAlertController *alert =   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"You must specify the name of your AirPods before continuing."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    else if ([valueToSave length] == 0) {
       
        UIAlertController *alert =   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"You must specify the name of your AirPods before continuing."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
        
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"airpodName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
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
