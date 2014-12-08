//
//  FNTFontSizeViewController.m
//  UIFont
//
//  Created by Rain on 2014. 5. 7..
//  Copyright (c) 2014년 Camp Mobile. All rights reserved.
//

#import "FNTFontSizeViewController.h"


NSUInteger FNTFontSizePadding = 5;


@interface FNTFontSizeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation FNTFontSizeViewController

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

    [self setSelectedIndexPath:[NSIndexPath indexPathForRow:(self.fontSize - FNTFontSizePadding) inSection:0]];

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(close)]];
}


- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.selectedIndexPath) {
        [self.tableView scrollToRowAtIndexPath:self.selectedIndexPath atScrollPosition:(UITableViewScrollPositionMiddle) animated:animated];
    }
}


#pragma mark UITableViewDataSource, UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }

    NSInteger fontSize = indexPath.row + FNTFontSizePadding;
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld", (long)fontSize]];
    [cell setAccessoryType:(self.fontSize == fontSize) ? (UITableViewCellAccessoryCheckmark) : (UITableViewCellAccessoryNone)];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectionBlock(self, indexPath.row + FNTFontSizePadding);
}


@end
