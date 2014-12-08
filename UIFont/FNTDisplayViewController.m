//
//  FNTDisplayViewController.m
//  UIFont
//
//  Created by Rain on 2014. 2. 18..
//  Copyright (c) 2014년 Camp Mobile. All rights reserved.
//

#import "FNTDisplayViewController.h"

@interface FNTDisplayViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (weak, nonatomic) IBOutlet UILabel *korean;
@property (weak, nonatomic) IBOutlet UILabel *upperCase;
@property (weak, nonatomic) IBOutlet UILabel *lowerCase;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *japanese;
@property (weak, nonatomic) IBOutlet UILabel *chinese;
@property (weak, nonatomic) IBOutlet UILabel *fontNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;
@property (nonatomic, strong) UIFont *font;
@end


@implementation FNTDisplayViewController


- (instancetype)initWithFont:(UIFont *)font
{
    self = [self initWithNibName:@"FNTDisplayViewController" bundle:nil];
    if (self) {
        [self setFont:font];
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.f) {
        [self.topLayout setConstant:20.f];
    }

    [self adjustLabels];

    UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
    [stepper setValue:self.font.pointSize];
    [stepper setStepValue:1.f];
    [stepper setMinimumValue:6.f];
    [stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:stepper]];

    [self setTitle:[NSString stringWithFormat:@"%ld", (long)self.font.pointSize]];

    [self.fontNameLabel setText:self.font.fontName];
    [self.fontSizeLabel setText:self.title];
}


- (void)stepperValueChanged:(UIStepper *)stepper
{
    [self setTitle:[NSString stringWithFormat:@"%ld", (long)stepper.value]];
    [self.fontSizeLabel setText:self.title];

    NSString *fontName = self.font.fontName;
    UIFont *font = [UIFont fontWithName:fontName size:stepper.value];
    [self setFont:font];

    [self adjustLabels];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)adjustLabels
{
    [self.scrollView setNeedsUpdateConstraints];

    [self.korean        setFont:self.font];
    [self.upperCase      setFont:self.font];
    [self.lowerCase setFont:self.font];
    [self.number        setFont:self.font];
    [self.japanese setFont:self.font];
    [self.chinese setFont:self.font];

    [self.korean sizeToFit];
    [self.upperCase sizeToFit];
    [self.lowerCase sizeToFit];
    [self.number sizeToFit];
    [self.japanese sizeToFit];
    [self.chinese sizeToFit];

    [UIView animateWithDuration:0.25f animations:^{
        [self.scrollView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            CGFloat sHeight = 10.f + CGRectGetHeight(self.korean.frame) + 10.f + CGRectGetHeight(self.upperCase.frame) + 10.f + CGRectGetHeight(self.lowerCase.frame) + 10.f + CGRectGetHeight(self.number.frame) + 10.f + CGRectGetHeight(self.japanese.frame) + 10.f + CGRectGetHeight(self.chinese.frame) + 50.f;

            CGSize contentSize = self.scrollView.contentSize;
            contentSize.height = MAX(CGRectGetHeight(self.scrollView.frame), sHeight);
            [self.scrollView setContentSize:contentSize];
        }
    }];

}

@end
