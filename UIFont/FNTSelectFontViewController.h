//
//  FNTSelectFontViewController.h
//  UIFont
//
//  Created by Rain on 2014. 5. 7..
//  Copyright (c) 2014년 Camp Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNTSelectFontViewController : UIViewController
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) void(^selectionBlock)(UIViewController *viewController, NSString *selectedFontName);
@end
