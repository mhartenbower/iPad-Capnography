//
//  DoctorInformationViewController.m
//  Capstone2
//
//  Created by Johnathan Cornella on 9/25/15.
//  Copyright (c) 2015 Johnathan Cornella. All rights reserved.
//

#import "DoctorInformationViewController.h"
#import "ScanViewController.h"
#import "RFduinoManager.h"
@interface DoctorInformationViewController ()
{
    RFduinoManager *rfduinoManager;
    bool wasScanning;
}
@end

@implementation DoctorInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
