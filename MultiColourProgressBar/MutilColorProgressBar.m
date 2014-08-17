//
//  MutilColorProgressBar.m
//  MutilColorProgressBar
//
//  Created by leon on 14-8-11.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import "MutilColorProgressBar.h"

typedef NS_ENUM(NSInteger,ProgressBarBackGroundColor)
{
    ProgressBarBackGroundCyanColor,
    ProgressBarBackGroundRedColor,
    ProgressBarBackGroundBlueColor,
    ProgressBarBackGroundGreenColor,
    ProgressBarBackGroundpurpleColor
};

@interface MutilColorProgressBar (){
    NSMutableArray * _coloredBars;
    float _detailWidth;
    BOOL _isEnd;
}

@property (nonatomic, strong) UIView * progressBarView;
@property (nonatomic, strong) UIView * cursorView;
@property (nonatomic, strong) NSTimer * cursorTimer;
@property (nonatomic, strong) NSTimer * progressTimer;
@property (nonatomic, assign)ProgressBarBackGroundColor progressColor;

@end

@implementation MutilColorProgressBar
@synthesize progressBarView;
@synthesize cursorView;
@synthesize progressBarHight;
@synthesize progressTimer;
@synthesize cursorTimer;
@synthesize progressColor;
@synthesize maxPersistentTime;

#pragma mark - Dealloc
-(void)dealloc
{
    [self.cursorTimer invalidate];
    self.cursorTimer = nil;
    [self.progressTimer invalidate];
    self.progressTimer = nil;
    progressBarView = nil;
    cursorView = nil;
    [_coloredBars removeAllObjects];
    _coloredBars = nil;
}

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (progressBarHight <= 0) {
            progressBarHight = 5.0f;
        }
        maxPersistentTime = 15.0f;
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    if (progressBarView == nil) {
        progressBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, progressBarHight)];
    }
    
    if (cursorView == nil) {
        cursorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2,progressBarHight)];
        [cursorView setBackgroundColor:[UIColor yellowColor]];
    }
    
    _coloredBars = nil;
    _coloredBars = [[NSMutableArray alloc]initWithCapacity:15];
    _detailWidth = 0.0f;
    
    [self addSubview:progressBarView];
    [self addSubview:cursorView];
    self.cursorTimer = [NSTimer timerWithTimeInterval:0.5f target:self selector:@selector(changeCursorStatus) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.cursorTimer forMode:NSDefaultRunLoopMode];
    
}

-(void)changeCursorStatus
{
    [cursorView setHidden:!cursorView.hidden];
}

-(void)changeProgressBarFrame
{
    float screenWidth = [[UIScreen mainScreen]bounds].size.width;
    if (cursorView.frame.origin.x + cursorView.bounds.size.width >= screenWidth) {
        _isEnd = YES;
        return;
    }
    float speed = screenWidth/maxPersistentTime;
    float detail = 0.05*speed;
    _detailWidth += detail;
    CGRect rect = self.frame;
    [UIView animateWithDuration:0.05 animations:^{
        [self setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width+detail, rect.size.height)];
        [self.cursorView setFrame:CGRectMake(rect.size.width , rect.origin.y, 2, rect.size.height)];
    }];
}

-(void)starting
{
    _detailWidth = 0.0f;
    if (progressTimer == nil) {
        progressTimer = [NSTimer timerWithTimeInterval:0.05f target:self selector:@selector(changeProgressBarFrame) userInfo:nil repeats:YES];
         [[NSRunLoop currentRunLoop]addTimer:progressTimer forMode:NSDefaultRunLoopMode];
    }
    [progressTimer setFireDate:[NSDate date]];
    if (!_isEnd) {
        [self setBackgroundColor:[self currentBarColor]];
    }
}

-(void)paused
{
    if (_detailWidth > 0) {
        CGRect rect = self.frame;
        UIView * markView = [[UIView alloc]initWithFrame:CGRectMake(rect.size.width - _detailWidth,rect.origin.y ,_detailWidth,rect.size.height )];
        [markView setBackgroundColor:self.backgroundColor];
        [_coloredBars addObject:markView];
        [self addSubview:markView];
    }
    [self.progressTimer setFireDate:[NSDate distantFuture]];
}

-(void)forBack
{
    UIView *lastView = [_coloredBars lastObject];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.frame;
        frame.size.width -= lastView.frame.size.width;
        self.frame = frame;
        
        CGRect f = self.cursorView.frame;
        f.origin.x = frame.size.width;
        self.cursorView.frame = f;
        
        //移除最后一个view
        [lastView removeFromSuperview];
    } completion:^(BOOL finished) {
        [_coloredBars removeObject:lastView];
        UIView * lastView = [_coloredBars lastObject];
        [self setBackgroundColor:lastView.backgroundColor];
        _isEnd = NO;
    }];
}

-(UIColor*)currentBarColor
{
    switch (_coloredBars.count%5) {
        case ProgressBarBackGroundCyanColor:
            return [UIColor cyanColor];
            break;
        case ProgressBarBackGroundRedColor:
            return [UIColor redColor];
            break;
        case ProgressBarBackGroundBlueColor:
            return [UIColor blueColor];
            break;
        case ProgressBarBackGroundGreenColor:
            return [UIColor greenColor];
            break;
        case ProgressBarBackGroundpurpleColor:
            return [UIColor purpleColor];
            break;
    }
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
