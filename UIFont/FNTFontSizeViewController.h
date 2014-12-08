//
//  FNTFontSizeViewController.h
//  UIFont
//
//  Created by Rain on 2014. 5. 7..
//  Copyright (c) 2014년 Camp Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNTFontSizeViewController : UIViewController
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) void(^selectionBlock)(UIViewController *viewController, CGFloat selectedFontSize);
@end
