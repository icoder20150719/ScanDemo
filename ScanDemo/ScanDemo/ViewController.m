//
//  ViewController.m
//  ScanDemo
//
//  Created by xiongan on 16/11/2.
//  Copyright © 2016年 大华. All rights reserved.
//

#import "ViewController.h"
#import "DHScanViewController.h"
#import "DHQRImageViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)scanClick:(id)sender {
    [self.navigationController pushViewController:[DHScanViewController new] animated:YES];
}
- (IBAction)readQRCode:(id)sender {
    UIImagePickerController *pickerVc = [[UIImagePickerController alloc]init];
    pickerVc.allowsEditing = YES;
    pickerVc.delegate = self;
    pickerVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:pickerVc animated:YES completion:nil];
    
}
- (IBAction)randerQRCode:(id)sender {
    DHQRImageViewController *imageVc = [[DHQRImageViewController alloc]initWithNibName:@"DHQRImageViewController" bundle:nil];
    imageVc.text = self.tf.text;
    [self.navigationController pushViewController:imageVc animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {

    [picker dismissViewControllerAnimated:YES completion:nil];
    [self decodeToQRCodeWithImage:image];
}

/**
 基于CoreImage框架识别图片中的二维码

 @param qrcodeImage 带二维码图片
 */
- (void)decodeToQRCodeWithImage:(UIImage *)qrcodeImage {
    UIImage * srcImage = qrcodeImage;
    //初始化一个context
    CIContext *context = [CIContext contextWithOptions:nil];
    //定义识别特征-识别QRCode ps:支持iOS8.0及以上系统，iOS9.0以上支持人脸识别
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyLow}];
    CIImage *image = [CIImage imageWithCGImage:srcImage.CGImage];
    //识别,并且按质量高的排序
    NSArray *features = [detector featuresInImage:image];
    //识别结果
    CIQRCodeFeature *feature = [features firstObject];
    NSString *result;
    if (feature) {
        result = feature.messageString;
    }else {
        result = @"识别失败！！";
    }
    
    [[[UIAlertView alloc]initWithTitle:result message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil]show];
}

@end
