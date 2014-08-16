//
//  ViewController.m
//  MultiColourProgressBar
//
//  Created by leon on 14-8-11.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import "ViewController.h"
#import "MutilColorProgressBar.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) MutilColorProgressBar * coloredProgressBarView;

@property (nonatomic, strong)UILongPressGestureRecognizer * longPressGestureRecognizer;

@end

@implementation ViewController
@synthesize progressBarView;
@synthesize startClick;
@synthesize deleteBtn;
@synthesize longPressGestureRecognizer;
@synthesize coloredProgressBarView;

-(void)dealloc
{
    coloredProgressBarView = nil;
    longPressGestureRecognizer = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    coloredProgressBarView = [[MutilColorProgressBar alloc]initWithFrame:CGRectMake(0, 0, 0, 5)];
    [coloredProgressBarView setProgressBarHight:5];
    [progressBarView addSubview:coloredProgressBarView];
    
    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]init];
    [longPressGestureRecognizer setMinimumPressDuration:0.05f];
    [longPressGestureRecognizer addTarget:self action:@selector(handleLongPressGestureRecognizer:)];
    [startClick addGestureRecognizer:longPressGestureRecognizer];
    startClick.userInteractionEnabled = YES;
    
}

-(void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [startClick setImage:[UIImage imageNamed:@"video_record_btn_click"]];
            [coloredProgressBarView starting];
            break;
        case UIGestureRecognizerStateEnded:
            [startClick setImage:[UIImage imageNamed:@"video_record_btn"]];
            [coloredProgressBarView paused];
            break;
        default:
            break;
    }
}

-(IBAction)deleteBtnAction:(id)sender
{
    [coloredProgressBarView forBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
