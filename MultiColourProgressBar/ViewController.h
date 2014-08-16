//
//  ViewController.h
//  MultiColourProgressBar
//
//  Created by leon on 14-8-11.
//  Copyright (c) 2014年 com.xdd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView * progressBarView;

@property(nonatomic, strong) IBOutlet UIImageView * startClick;

@property (nonatomic,strong) IBOutlet UIButton * deleteBtn;

-(IBAction)deleteBtnAction:(id)sender;

@end
