//
//  QRCodeView.h
//
//  Created by andy on 16/1/16.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  @author andy, 16-01-16 02:01:48
 *
 *  @brief 扫码视图类
 *  @since v0.1.0
 */
@interface QRCodeView : UIView


/*!
 *  @author andy, 16-08-24 09:08:42
 *
 *  @brief 构造方法
 *  @param frame         CGRect
 *  @param maskInsets    扫描高亮区域距离四个边的边距
 *  @param orientation   默认的视图方向
 *  @param animationType 动画类型(1-扫描网从上到下铺满(默认)  其它一条扫描线从上到下做往复运动 )
 *  @param cornerColor   扫描高亮区域四个拐角的颜色
 *  @return QRCodeView实例对象
 */

+ (instancetype)viewWithFrame:(CGRect)frame;


+ (instancetype)viewWithFrame:(CGRect)frame
                   maskInsets:(UIEdgeInsets)maskInsets;

- (instancetype)initWithFrame:(CGRect)frame
                   maskInsets:(UIEdgeInsets)maskInsets;

+ (instancetype)viewWithFrame:(CGRect)frame
                   maskInsets:(UIEdgeInsets)maskInsets
                aniamtionType:(NSUInteger)animationType;

- (instancetype)initWithFrame:(CGRect)frame
                   maskInsets:(UIEdgeInsets)maskInsets
                aniamtionType:(NSUInteger)animationType;

+ (instancetype)viewWithFrame:(CGRect)frame
                   maskInsets:(UIEdgeInsets)maskInsets
                aniamtionType:(NSUInteger)animationType
                  cornerColor:(UIColor *)cornerColor;

- (instancetype)initWithFrame:(CGRect)frame
                   maskInsets:(UIEdgeInsets)maskInsets
                aniamtionType:(NSUInteger)animationType
                  cornerColor:(UIColor *)cornerColor;

/*!
 @brief  扫码成功回调
 @param  success 是否扫码成功
 @param  context 扫码内容(如果扫码成功,则返回对应码的内容,否则返回错误信息)
 */
@property (nonatomic,copy) void(^scanBlock)(BOOL success,NSString *context);

/**
 *  @brief 开始扫描
 */
- (void)startScan;

/**
 *  @brief 停止扫描
 */
- (void)stopScan;

@end
