//
//  DHScanViewController.m
//  ScanDemo
//
//  Created by xiongan on 16/11/2.
//  Copyright © 2016年 大华. All rights reserved.
//

#import "DHScanViewController.h"
#import "QRCodeView.h"

@interface DHScanViewController ()

@end

@implementation DHScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    QRCodeView *qrView = [[QRCodeView alloc]initWithFrame:self.view.bounds maskInsets:UIEdgeInsetsMake(140, 20, 20, 20) aniamtionType:1 cornerColor:[UIColor redColor]];
    [self.view addSubview:qrView];
    qrView.scanBlock = ^(BOOL success,NSString *context){
    
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:nil message:context delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    };
    [qrView startScan];
    // Do any additional setup after loading the view.
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
