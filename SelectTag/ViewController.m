//
//  ViewController.m
//  SelectTag
//
//  Created by 彭学伟 on 2017/5/11.
//  Copyright © 2017年 彭学伟. All rights reserved.
//

#import "ViewController.h"
#import "XVTagView.h"

#define KSCREENWIDTH ([[UIScreen mainScreen ] bounds].size.width)
#define KSCREEMHEIGHT ([[UIScreen mainScreen ] bounds].size.height)

@interface ViewController ()<XVTagViewDelegate>
@property(nonatomic, strong) XVTagView *supplyTagView;
@property(nonatomic, strong) UIView *cutLine;
@property(nonatomic, strong) XVTagView *abtainTagView;
@property(nonatomic, strong) UIView *mainView;
@property(nonatomic, assign) CGFloat supplyHeight;
@property(nonatomic, assign) CGFloat abtainHeight;

@property(nonatomic, strong) NSMutableArray *supplyArray;

@property(nonatomic, strong) NSMutableArray *abtainArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

- (void)setupUI {
    
    self.supplyArray = [NSMutableArray array];
    self.abtainArray = [NSMutableArray array];
    self.supplyHeight = 0.f;
    self.abtainHeight = 0.f;
    
    self.view.backgroundColor = COLORRGB(0xf9f9f9);
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(15, 6, KSCREENWIDTH - 30, 0)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    
    self.mainView.layer.shadowColor = [UIColor blackColor].CGColor;
//    阴影的透明度
    self.mainView.layer.shadowOpacity = 0.1f;
//    阴影的圆角
    self.mainView.layer.shadowRadius = 4.f;
//    阴影偏移量
    self.mainView.layer.shadowOffset = CGSizeMake(4,4);
    
    [self.view addSubview:self.mainView];
    
    
    
    self.supplyTagView = [[XVTagView alloc] init];
    self.supplyTagView.frame = CGRectMake(0, 0, KSCREENWIDTH - 30, 0);
    self.supplyTagView.delegate = self;
    self.supplyTagView.titleLabel.text = @"我能提供";
    self.supplyTagView.tipLabel.text = @"(最多可添加3个)";
    [self.mainView addSubview:self.supplyTagView];
    [self.supplyTagView addTags:@[@"金融", @"金融哈哈"]];
    
    self.cutLine = [[UIView alloc] initWithFrame:CGRectMake(19, CGRectGetHeight(self.supplyTagView.bounds), KSCREENWIDTH - 30 - 38, 0.5)];
    self.cutLine.backgroundColor = [UIColor lightGrayColor];
    [self.mainView addSubview:self.cutLine];
    
    self.abtainTagView = [[XVTagView alloc] init];
    self.abtainTagView.frame = CGRectMake(0, 0, KSCREENWIDTH - 30, 0);
    self.abtainTagView.delegate = self;
    self.abtainTagView.titleLabel.text = @"我想得到";
    self.abtainTagView.tipLabel.text = @"(最多可添加3个)";
    [self.mainView addSubview:self.abtainTagView];
    [self.abtainTagView addTags:@[@"金融哈哈哈哈哈哈", @"金融哈哈哈"]];
    
}

#pragma mark -- XVTagViewDelegate

- (void)XVTagView:(XVTagView *)XVTagView addItemSuccess:(BOOL)success {
    
    if (success) {
        NSLog(@"添加成功");
    } else {
        NSLog(@"添加失败");
    }
}

- (void)XVTagView:(XVTagView *)XVTagView removeItemSuccess:(BOOL)success {
    if (success) {
        NSLog(@"删除成功");
    } else {
        NSLog(@"删除失败");
    }
}

- (void)XVTagView:(XVTagView *)XVTagView XVTagItem:(XVTagItem *)XVTagItem {
    if (![XVTagItem.text isEqualToString:@"+添加"]) {
        if (XVTagView == self.supplyTagView) {
            [self.supplyTagView remove:XVTagItem.text];
        } else {
            [self.supplyTagView addOneTag:XVTagItem.text];
        }
        
    }
//    NSLog(@"item.text -- %@",XVTagItem.text);
}

- (void)XVTagView:(XVTagView *)XVTagView sizeChange:(CGRect)newSize {
    NSLog(@"%f",newSize.size.height);
    
    if (XVTagView == self.supplyTagView) {
        CGRect lineFrame = self.cutLine.frame;
        lineFrame.origin.y = newSize.size.height;
        self.cutLine.frame = lineFrame;
        
        CGRect abtainFrame = self.abtainTagView.frame;
        abtainFrame.origin.y = self.cutLine.frame.origin.y + 0.5;
        self.abtainTagView.frame = abtainFrame;
        
        self.supplyHeight = newSize.size.height;
    } else {
        self.abtainHeight = newSize.size.height;
    }
    
    CGRect frame = self.mainView.frame;
    frame.size.height = self.supplyHeight + self.abtainHeight + 0.5;
    self.mainView.frame = frame;

}

- (void)XVTagView:(XVTagView *)XVTagView getItemArray:(NSMutableArray *)itemArray {
    
    if (XVTagView == self.supplyTagView) {
        NSLog(@"supplyitems -- %@",itemArray);
        self.supplyArray = itemArray;
    } else {
        NSLog(@"abtainitems -- %@",itemArray);
        self.abtainArray = itemArray;
    }
}


- (IBAction)submit:(id)sender {
    NSMutableArray *selectItems = [NSMutableArray arrayWithObjects:self.supplyArray, self.abtainArray, nil];
    NSLog(@"items -- %@",selectItems);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
