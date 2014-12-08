//
//  FNTDisplaySystemFontsViewController.m
//  UIFont
//
//  Created by Rain on 2014. 5. 12..
//  Copyright (c) 2014년 Camp Mobile. All rights reserved.
//

#import "FNTDisplaySystemFontsViewController.h"

@interface FNTDisplaySystemFontsViewController ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (nonatomic, strong) NSArray *textStyles;
@end

@implementation FNTDisplaySystemFontsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitle:@"preferred Font"];

    /*
     + (CGFloat)labelFontSize;
     + (CGFloat)buttonFontSize;
     + (CGFloat)smallSystemFontSize;
     + (CGFloat)systemFontSize;
     */

    /*
     + (UIFont *)preferredFontForTextStyle:(NSString *)style NS_AVAILABLE_IOS(7_0);

     UIKIT_EXTERN NSString *const UIFontTextStyleHeadline NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIFontTextStyleBody NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIFontTextStyleSubheadline NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIFontTextStyleFootnote NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIFontTextStyleCaption1 NS_AVAILABLE_IOS(7_0);
     UIKIT_EXTERN NSString *const UIFontTextStyleCaption2 NS_AVAILABLE_IOS(7_0);
     */

    [self setTextStyles:@[UIFontTextStyleHeadline, UIFontTextStyleBody, UIFontTextStyleSubheadline, UIFontTextStyleFootnote, UIFontTextStyleCaption1, UIFontTextStyleCaption2]];

    [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
        NSString *textStyle = [self.textStyles objectAtIndex:idx];
        UIFont *font = [UIFont preferredFontForTextStyle:textStyle];
        [label setFont:font];
        [label setText:textStyle];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
