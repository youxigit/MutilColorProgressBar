//
//  MutilColorProgressBar.h
//  MutilColorProgressBar
//
//  Created by leon on 14-8-11.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MutilColorProgressBar : UIView
{
    
}

@property (nonatomic, assign) CGFloat progressBarHight;
@property (nonatomic, assign) CGFloat maxPersistentTime;

-(void)starting;
-(void)paused;
-(void)forBack;
@end
