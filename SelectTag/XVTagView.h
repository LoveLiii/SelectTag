//
//  XVTagView.h
//  SelectTag
//
//  Created by 彭学伟 on 2017/5/11.
//  Copyright © 2017年 彭学伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XVTagItem.h"

@class XVTagView,XVTagItem;
@protocol XVTagViewDelegate <NSObject>

- (void)XVTagView:(XVTagView *)XVTagView sizeChange:(CGRect)newSize;
- (void)XVTagView:(XVTagView *)XVTagView XVTagItem:(XVTagItem *)XVTagItem;

- (void)XVTagView:(XVTagView *)XVTagView addItemSuccess:(BOOL )success;
- (void)XVTagView:(XVTagView *)XVTagView removeItemSuccess:(BOOL )success;

- (void)XVTagView:(XVTagView *)XVTagView getItemArray:(NSMutableArray *)itemArray;

@end

@interface XVTagView : UIView

@property (nonatomic,weak) id<XVTagViewDelegate> delegate;

@property (nonatomic, strong)XVTagItem *addItem;

@property(nonatomic) UIEdgeInsets padding;

@property(nonatomic) UILabel *titleLabel;

@property(nonatomic) UILabel *tipLabel;

//批量添加
- (void)addTags:(NSArray *)tags;
//单独添加
- (void)addOneTag:(NSString *)text;
//根据标签文字移除
- (void)remove:(NSString *)text;

@end
