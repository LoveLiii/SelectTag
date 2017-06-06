//
//  XVTagItem.m
//  SelectTag
//
//  Created by 彭学伟 on 2017/5/11.
//  Copyright © 2017年 彭学伟. All rights reserved.
//

#import "XVTagItem.h"

@implementation XVTagItem

- (instancetype)init
{
    if (self = [super init]) {
        self.textColor = [UIColor whiteColor];
        CGFloat fontSize = 13;
        if (IS_IPHONE_PLUS) {
            fontSize = fontSize * 1.2;
        }
        self.font = [UIFont systemFontOfSize:fontSize];
        self.textAlignment = NSTextAlignmentCenter;
        self.delegate = self;
        self.backgroundColor = ShowColor;
        
    }
    return self;
}

-(void)textFieldDidBeginEditing:(UITextField*)textField

{
    [textField resignFirstResponder];
    if ([self.itemDelagete respondsToSelector:@selector(XVTagItem:)]) {
        [self.itemDelagete XVTagItem:self];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [textField resignFirstResponder];
    return YES;
}

- (void)setAddShowColor:(UIColor *)addShowColor {
    self.backgroundColor = addShowColor;
}

- (void)setAddTextColor:(UIColor *)addTextColor {
    self.textColor = addTextColor;
}

//设置文字的边距
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.padding.left,
                      bounds.origin.y + self.padding.top,
                      bounds.size.width - self.padding.right - self.padding.left,
                      bounds.size.height - self.padding.bottom - self.padding.bottom);
}
- (void)setPadding:(UIEdgeInsets)padding
{
    _padding = padding;
    
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
