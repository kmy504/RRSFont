//
//  FNTMainViewController.m
//  UIFont
//
//  Created by Rain on 14. 2. 3..
//  Copyright (c) 2014년 Camp Mobile. All rights reserved.
//


#import "FNTMainViewController.h"
#import "FNTDisplayViewController.h"
#import "FNTSelectFontViewController.h"
#import "FNTFontSizeViewController.h"
#import "FNTDisplaySystemFontsViewController.h"


NSString *FNTFontNameKey = @"FNTFontNameKey";
NSString *FNTFontSizeKey = @"FNTFontSizeKey";
NSString *FNTDisplayByFontSize = @"FNTDisplayByFontSize";
NSString *FNTDisplayBySystemFont = @"FNTDisplayBySystemFont";


@interface FNTMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, assign) CGFloat fontSize;
@end


@interface NSArray (FNTAdditions)
- (id)fnt_objectAtIndexPath:(NSIndexPath *)indexPath;
@end


@implementation FNTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupDefaultValues];

    [self setTitle:@"Font"];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark Setter Override


- (void)setFontName:(NSString *)fontName
{
    [[NSUserDefaults standardUserDefaults] setValue:fontName forKeyPath:FNTFontNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    _fontName = fontName;
}


- (void)setFontSize:(CGFloat)fontSize
{
    [[NSUserDefaults standardUserDefaults] setFloat:fontSize forKey:FNTFontSizeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    _fontSize = fontSize;
}


#pragma mark Internal Methods


- (void)setupDefaultValues
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    [mutableArray addObject:@[FNTFontNameKey, FNTFontSizeKey, FNTDisplayByFontSize]];
    [mutableArray addObject:@[FNTDisplayBySystemFont]];
    [self setContents:[mutableArray copy]];

    if ([[NSUserDefaults standardUserDefaults] valueForKey:FNTFontNameKey]) {
        _fontName = [[NSUserDefaults standardUserDefaults] valueForKey:FNTFontNameKey];
    } else {
        [self setFontName:@"AppleSDGothicNeo-Medium"];
    }
    if ([[NSUserDefaults standardUserDefaults] valueForKey:FNTFontSizeKey]) {
        _fontSize = [[NSUserDefaults standardUserDefaults] floatForKey:FNTFontSizeKey];
    } else {
        [self setFontSize:11.f];
    }
}


- (NSString *)textAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *value = nil;
    NSString *key = [self.contents fnt_objectAtIndexPath:indexPath];

    if ([key isEqualToString:FNTFontNameKey]) {
        value = @"Font Name";
    } else if ([key isEqualToString:FNTFontSizeKey]) {
        value = @"Font Size";
    } else if ([key isEqualToString:FNTDisplayByFontSize]) {
        value = @"Show by Font Size";
    } else if ([key isEqualToString:FNTDisplayBySystemFont]) {
        value = @"Show System Fonts";
    }

    return value;
}


- (NSString *)detailTextAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *value = nil;
    NSString *key = [self.contents fnt_objectAtIndexPath:indexPath];

    if ([key isEqualToString:FNTFontNameKey]) {
        value = [self.fontName copy];
    } else if ([key isEqualToString:FNTFontSizeKey]) {
        value = [NSString stringWithFormat:@"%ld", (long)self.fontSize];
    }

    return value;
}


- (UITableViewCellAccessoryType)cellAccessoryTypeAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellAccessoryType type = UITableViewCellAccessoryNone;
    NSString *key = [self.contents fnt_objectAtIndexPath:indexPath];

    if ([key isEqualToString:FNTDisplayByFontSize] || [key isEqualToString:FNTDisplayBySystemFont]) {
        type = UITableViewCellAccessoryDisclosureIndicator;
    }

    return type;

}


#pragma mark UITableViewDataSource, UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contents.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.contents objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

    [cell.textLabel setText:[self textAtIndexPath:indexPath]];
    [cell.detailTextLabel setText:[self detailTextAtIndexPath:indexPath]];
    [cell setAccessoryType:[self cellAccessoryTypeAtIndexPath:indexPath]];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSString *key = [self.contents fnt_objectAtIndexPath:indexPath];
    if ([key isEqualToString:FNTFontNameKey]) {
        FNTSelectFontViewController *viewController = [[FNTSelectFontViewController alloc] initWithNibName:NSStringFromClass([FNTSelectFontViewController class]) bundle:nil];
        [viewController setModalTransitionStyle:(UIModalTransitionStyleCrossDissolve)];
        __weak FNTMainViewController *weakSelf = self;
        [viewController setFontName:self.fontName];
        [viewController setSelectionBlock:^(UIViewController *controller, NSString *selectedFontName) {
            __strong FNTMainViewController *strongSelf = weakSelf;
            [strongSelf setFontName:selectedFontName];
            [controller dismissViewControllerAnimated:YES completion:nil];
            [strongSelf.tableView reloadData];
        }];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:viewController] animated:YES completion:nil];
    } else if ([key isEqualToString:FNTFontSizeKey]) {
        FNTFontSizeViewController *viewController = [[FNTFontSizeViewController alloc] initWithNibName:NSStringFromClass([FNTFontSizeViewController class]) bundle:nil];
        [viewController setModalTransitionStyle:(UIModalTransitionStyleCrossDissolve)];
        __weak FNTMainViewController *weakSelf = self;
        [viewController setFontSize:self.fontSize];
        [viewController setSelectionBlock:^(UIViewController *controller, CGFloat selectedFontSize) {
            __strong FNTMainViewController *strongSelf = weakSelf;
            [strongSelf setFontSize:selectedFontSize];
            [controller dismissViewControllerAnimated:YES completion:nil];
            [strongSelf.tableView reloadData];
        }];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:viewController] animated:YES completion:nil];
    } else if ([key isEqualToString:FNTDisplayByFontSize]) {
        UIFont *font = [UIFont fontWithName:self.fontName size:self.fontSize];

        if (font == nil)
        {
            return;
        }

        [self.navigationController pushViewController:[[FNTDisplayViewController alloc] initWithFont:font] animated:YES];
    } else if ([key isEqualToString:FNTDisplayBySystemFont]) {
        FNTDisplaySystemFontsViewController *viewController = [[FNTDisplaySystemFontsViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end


@implementation NSArray (FNTAdditions)

- (id)fnt_objectAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.count <= indexPath.section) {
        return nil;
    }

    NSArray *rows = (NSArray *)[self objectAtIndex:indexPath.section];
    if (![rows isKindOfClass:[NSArray class]]) {
        return nil;
    }

    if (rows.count <= indexPath.row) {
        return nil;
    }

    return [rows objectAtIndex:indexPath.row];
}

@end
