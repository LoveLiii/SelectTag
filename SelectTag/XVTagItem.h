//
//  XVTagItem.h
//  SelectTag
//
//  Created by 彭学伟 on 2017/5/11.
//  Copyright © 2017年 彭学伟. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLORRGB(c)    [UIColor colorWithRed:((c>>16)&0xFF)/255.0	\
green:((c>>8)&0xFF)/255.0	\
blue:(c&0xFF)/255.0         \
alpha:1.0]


#define IS_IPHONE_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )

//显示的颜色
#define ShowColor COLORRGB((0x759bc8))

@class XVTagItem;

@protocol XVTagItemDelegate <NSObject>

- (void)XVTagItem:(XVTagItem *)XVTagItem;

@end

@interface XVTagItem : UITextField <UITextFieldDelegate>

@property (nonatomic,assign) id<XVTagItemDelegate> itemDelagete;

@property(nonatomic) UIEdgeInsets padding;
@property (nonatomic, strong) UIColor *addShowColor;
@property (nonatomic, strong) UIColor *addTextColor;

@end
