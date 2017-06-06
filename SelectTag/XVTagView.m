//
//  XVTagView.m
//  SelectTag
//
//  Created by 彭学伟 on 2017/5/11.
//  Copyright © 2017年 彭学伟. All rights reserved.
//

#import "XVTagView.h"

@interface XVTagView ()<XVTagItemDelegate>

@end

@implementation XVTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.padding = UIEdgeInsetsMake(22, 19, 16, 19);//控件的距离
//    self.backgroundColor = [UIColor blueColor];
    //添加标题
    [self addHeaderView];
    
    //默认的添加按钮
    [self addFirstItem];
}

- (void)addHeaderView {
    UIView *headerView = [[UIView alloc] init];
    CGFloat headerWidht = [UIScreen mainScreen].bounds.size.width - 68;
    headerView.frame = CGRectMake(19, 18, headerWidht, 16);
//    headerView.backgroundColor = [UIColor yellowColor];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = COLORRGB(0x333333);
//    self.titleLabel.backgroundColor = [UIColor redColor];
    CGFloat fontSize = 14;
    if (IS_IPHONE_PLUS) {
        fontSize = fontSize * 1.2;
    }
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    self.titleLabel.frame = CGRectMake(0, 0, 80, 16);
    [headerView addSubview:self.titleLabel];
    
    self.tipLabel= [[UILabel alloc] init];
    self.tipLabel.textColor = COLORRGB(0x333333);
//    self.tipLabel.backgroundColor = [UIColor redColor];
    self.tipLabel.font = [UIFont systemFontOfSize:fontSize];
    self.tipLabel.frame = CGRectMake(headerWidht - 150, 0, 150, 16);
    self.tipLabel.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:self.tipLabel];
    
    [self addSubview:headerView];
}

- (void)addFirstItem {
    self.addItem = [[XVTagItem alloc] init];
    self.addItem.padding = UIEdgeInsetsMake(7, 15, 7, 15);//字体与控件的距离
    self.addItem.text = @"+添加";
    self.addItem.addShowColor = [UIColor whiteColor];
    self.addItem.addTextColor = COLORRGB(0x666666);
    self.addItem.itemDelagete = self;
    self.addItem.frame = CGRectZero;
    [self.addItem sizeToFit];
    self.addItem.layer.cornerRadius = self.addItem.frame.size.height / 2;
    self.addItem.layer.borderWidth = 0.5;
    self.addItem.layer.borderColor = COLORRGB(0x666666).CGColor;
    self.addItem.layer.masksToBounds = YES;
    [self addSubview:self.addItem];
}

#pragma mark --XVTagItemDelegate
- (void)XVTagItem:(XVTagItem *)XVTagItem {
    if([self.delegate respondsToSelector:@selector(XVTagView:XVTagItem:)]) {
        [self.delegate XVTagView:self XVTagItem:XVTagItem];
    }
}

- (void)addTags:(NSArray *)tags {
    for (int i = 0; i< tags.count; i++) {
        [self addOneTag:tags[i]];
    }
}
- (void)addOneTag:(NSString *)text {
    
    for (id object in self.subviews) {
        if ([object isKindOfClass:[XVTagItem class]]) {
            XVTagItem *item = object;
            if([item.text isEqualToString:text]) {
                if([self.delegate respondsToSelector:@selector(XVTagView:addItemSuccess:)]) {
                    [self.delegate XVTagView:self addItemSuccess:NO];
                }
                return;
            } else {
                if([self.delegate respondsToSelector:@selector(XVTagView:addItemSuccess:)]) {
                    [self.delegate XVTagView:self addItemSuccess:YES];
                }
            }
        }
    }
    
    CGRect frame = CGRectZero;
    if(self.subviews && self.subviews.count > 0) {
        frame = [self.subviews lastObject].frame;
    }
    
    XVTagItem *Item = [[XVTagItem alloc] init];
    Item.padding = UIEdgeInsetsMake(7, 15, 7, 15);//字体与控件的距离
    Item.text =text;
    Item.itemDelagete = self;
    Item.frame = CGRectMake(frame.origin.x, frame.origin.y, Item.frame.size.width, Item.frame.size.height);
    [Item sizeToFit];
    Item.layer.cornerRadius = Item.frame.size.height / 2;
    Item.layer.masksToBounds = YES;
    [self addSubview:Item];
    
}

- (void)remove:(NSString *)text
{
    
    for (id object in self.subviews) {
        if ([object isKindOfClass:[XVTagItem class]]) {
            XVTagItem *item = object;
            
            if([item.text isEqualToString:text]) {
                [item removeFromSuperview];
                if([self.delegate respondsToSelector:@selector(XVTagView:removeItemSuccess:)]) {
                    [self.delegate XVTagView:self removeItemSuccess:YES];
                }
                
            } else {
                if([self.delegate respondsToSelector:@selector(XVTagView:removeItemSuccess:)]) {
                    [self.delegate XVTagView:self removeItemSuccess:NO];
                }
            }
        }
    }
}

//动态更新布局
- (void)layoutSubviews {
    
    NSInteger itemCount = 1;
    
    NSMutableArray *itemArray = [NSMutableArray array];
    for (id object in self.subviews) {
        if ([object isKindOfClass:[XVTagItem class]]) {
            itemCount ++;
            XVTagItem *item = object;
            [itemArray addObject:item.text];
            if ([item.text isEqualToString:@"+添加"]) {
                [itemArray removeObject:item.text];
            }
            if ([self.delegate respondsToSelector:@selector(XVTagView:getItemArray:)]) {
                [self.delegate XVTagView:self getItemArray:itemArray];
            }
        }
    }
    
    if (itemCount > 4) {
        self.addItem.alpha = 0.4;
        self.addItem.userInteractionEnabled = NO;
    } else {
        self.addItem.alpha = 1;
        self.addItem.userInteractionEnabled = YES;
    }
    
    [UIView beginAnimations:nil context:nil];
    CGFloat paddingRight = self.padding.right;
    CGFloat cellspaceY = 12;
    CGFloat cellspaceX = 5;
    CGFloat y = self.padding.top + 34;
    CGFloat x = self.padding.left;
    CGRect frame;
    for (UIView *tag in self.subviews) {
        if ([tag isKindOfClass:[XVTagItem class]]) {
            frame = tag.frame;
            frame.origin.x = x;
            frame.origin.y = y;
            
            if(frame.origin.x + frame.size.width + paddingRight > self.frame.size.width) {
                // 换行
                frame.origin.x = self.padding.left;
                frame.origin.y = frame.origin.y + frame.size.height + cellspaceY;
                
                y = frame.origin.y;
            }
            
            if(frame.origin.x + frame.size.width > self.frame.size.width - paddingRight) {
                frame.size.width = self.frame.size.width - paddingRight - frame.origin.x;
            }
            
            x = frame.origin.x + frame.size.width + cellspaceX;
            tag.frame = frame;
        }
    }
    CGFloat containerHeight = frame.origin.y + frame.size.height + self.padding.bottom;
    CGRect containerFrame = self.frame;
    containerFrame.size.height = containerHeight;
    self.frame = containerFrame;
    if([self.delegate respondsToSelector:@selector(XVTagView:sizeChange:)]) {
        [self.delegate XVTagView:self sizeChange:self.frame];
    }
    [UIView commitAnimations];
}

@end
