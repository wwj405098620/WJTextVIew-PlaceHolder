//  ver 1.2
//  更新内容:本次更新重新设计了实现方式：以前的实现为继承，这次改为类别实现，使依赖关系更轻量级，由于不继承原生控件类，将会加大扩展性和维护性。
//  Created by WenJie on 15/8/21.
//  Copyright (c) 2015年 fosung_newMac. All rights reserved.
//



#import <UIKit/UIKit.h>
@interface UITextView (WJPlaceHolder)

/**
 *  设置提示语
 */
@property (nonatomic, weak) NSString  *placeHolder;

/**
 *  设置提示语的字体,默认为[UIFont systemFontOfSize:13]
 */
@property (nonatomic, weak) UIFont    *placeHolderFont;

/**
 *  设置提示语的字体颜色,默认为[UIColor lightGrayColor]
 */
@property (nonatomic, weak) UIColor   *placeHolderColor;
@end


