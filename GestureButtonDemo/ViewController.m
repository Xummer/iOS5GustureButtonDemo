//
//  ViewController.m
//  GestureButtonDemo
//
//  Created by Xummer on 13-5-15.
//  Copyright (c) 2013年 Xummer. All rights reserved.
//

#import "ViewController.h"

// UIScrollView category for dismiss keyboard
@implementation UIScrollView (bgTouched)

// tap scrollview to dismiss keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction:)];
    [tapGesture setNumberOfTapsRequired:1];
    [_gView addGestureRecognizer:tapGesture];
    
    [_scrollview setContentSize:CGSizeMake(_scrollview.frame.size.width, _gView.frame.size.height + 50)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// dismiss keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)buttonAction:(id)sender
{
    NSLog(@"buttonAction:");
    [_button setSelected:!_button.selected];
    [_label setText:_button.selected?@"Button Tapped":@"I'm the view who add UITapGesture"];
}

- (void)tappedAction:(UIGestureRecognizer *)sender
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 6.0) {
        CGPoint pt = [sender locationInView:_button];
        NSLog(@"%@", NSStringFromCGPoint(pt));
        if (CGRectContainsPoint( _button.bounds, pt)) {
            [self buttonAction:_button];
            NSLog(@"111");
            return;
        }
    }
        
    // do some Tapped Action
    NSLog(@"tappedAction:");
}

@end
