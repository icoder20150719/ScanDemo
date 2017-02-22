//
//  DHQRImageViewController.m
//  ScanDemo
//
//  Created by xiongan on 17/1/11.
//  Copyright © 2017年 大华. All rights reserved.
//

#import "DHQRImageViewController.h"

@interface DHQRImageViewController ()

@end

@implementation DHQRImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *QRImage = [self QRCodeImageWithText:self.text];
    self.imageView.image = QRImage;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存到相册" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
}

- (void)save {
    UIImage *image = [UIImage imageWithData:UIImagePNGRepresentation(self.imageView.image)];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil) ;
}

/**
 通过CoreImage框架生成一个二维码图片

 @param text 文字
 @return 带二维码的图片
 */
- (UIImage *)QRCodeImageWithText:(NSString *)text {
    if (text.length==0) {
        return nil;
    }
    NSData *stringData = [text dataUsingEncoding:NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    UIColor *onColor = [UIColor grayColor];
    UIColor *offColor = [UIColor greenColor];
    //上色，ps：默认是黑白色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    //绘制
    CGSize size = CGSizeMake(300, 300);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    //翻转
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return codeImage;
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
