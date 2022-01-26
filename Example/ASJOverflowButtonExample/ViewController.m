//
//  ViewController.m
//  ASJOverflowButtonExample
//
//  Created by sudeep on 21/12/15.
//  Copyright © 2015 sudeep. All rights reserved.
//

#import "ViewController.h"
#import "ASJOverflowButton.h"

@interface ViewController ()

@property (strong, nonatomic) ASJOverflowButton *overflowButton;
@property (copy, nonatomic) NSArray *overflowItems;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

- (void)setup;
- (void)setupDefaults;
- (void)setupOverflowItems;
- (void)setupOverflowButton;
- (void)handleOverflowBlocks;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

#pragma mark - Setup

- (void)setup
{
    [self setupDefaults];
    [self setupOverflowItems];
    [self setupOverflowButton];
    [self handleOverflowBlocks];
}

- (void)setupDefaults
{
    self.title = @"Tap me -->";
    _itemLabel.superview.hidden = YES;
}

- (void)setupOverflowItems
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i=1; i<=6; i++)
    {
        NSString *itemName = [NSString stringWithFormat:@"Item %d", i];
        NSString *imageName = [NSString stringWithFormat:@"item_%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        ASJOverflowItem *item = [ASJOverflowItem itemWithName:itemName image:image backgroundColor:nil];
        [temp addObject:item];
    }
    _overflowItems = [NSArray arrayWithArray:temp];
}

- (void)setupOverflowButton
{
    UIImage *image = [UIImage imageNamed:@"overflow_icon"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.widthAnchor constraintEqualToConstant:25].active = YES;
    [button.heightAnchor constraintEqualToConstant:25].active = YES;
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlStateNormal];
    
    _overflowButton = [[ASJOverflowButton alloc] initWithTarget:self.navigationController title:@"My Button" image:nil button:button items:_overflowItems];
    
    _overflowButton.dimsBackground = YES;
    _overflowButton.hidesSeparator = NO;
    _overflowButton.hidesShadow = NO;
    _overflowButton.dimmingLevel = 0.3f;
    _overflowButton.menuItemHeight = 50.0f;
    _overflowButton.widthMultiplier = 0.4f;
    _overflowButton.itemTextColor = [UIColor blackColor];
    _overflowButton.menuBackgroundColor = [UIColor whiteColor];
    _overflowButton.itemHighlightedColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
    _overflowButton.menuMargins = MenuMarginsMake(15.0f, 15.0f, 15.0f);
    _overflowButton.separatorInsets = SeparatorInsetsMake(10.0f, 5.0f);
    _overflowButton.menuAnimationType = MenuAnimationTypeZoomIn;
    _overflowButton.itemFont = [UIFont fontWithName:@"Verdana" size:13.0f];
    
    self.navigationItem.rightBarButtonItem = _overflowButton;
}

- (void)handleOverflowBlocks
{
    __weak typeof(self) weakSelf = self;
    [_overflowButton setItemTapBlock:^(ASJOverflowItem *item, NSInteger idx)
     {
        weakSelf.itemLabel.text = item.name;
        if (weakSelf.itemLabel.superview.hidden) {
            weakSelf.itemLabel.superview.hidden = NO;
        }
    }];
    
    [_overflowButton setHideMenuBlock:^{
        NSLog(@"hidden");
    }];
}

@end
