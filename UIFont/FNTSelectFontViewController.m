//
//  FNTSelectFontViewController.m
//  UIFont
//
//  Created by Rain on 2014. 5. 7..
//  Copyright (c) 2014년 Camp Mobile. All rights reserved.
//

#import "FNTSelectFontViewController.h"

@interface FNTSelectFontViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *allFontName;
@property (nonatomic, strong) NSArray *fontNames;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation FNTSelectFontViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *mutableArray = [NSMutableArray array];

    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    for (NSInteger indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        [mutableArray addObjectsFromArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
    }
    [self setAllFontName:[mutableArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    [self setFontNames:[self.allFontName copy]];

    [self setSelectedIndexPath:[NSIndexPath indexPathForRow:[self.fontNames indexOfObject:self.fontName] inSection:0]];

    [self.tableView reloadData];

    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemCancel) target:self action:@selector(close)]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fontNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }

    NSString *text = [self.fontNames objectAtIndex:indexPath.row];
    [cell.textLabel setText:text];
    [cell setAccessoryType:([text isEqualToString:self.fontName]) ? (UITableViewCellAccessoryCheckmark) : (UITableViewCellAccessoryNone)];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectionBlock(self, [self.fontNames objectAtIndex:indexPath.row]);
}


#pragma mark UISearchBarDelegate


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        [self setFontNames:[self.allFontName filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText]]];
    }
    else {
        [self setFontNames:[self.allFontName copy]];
    }
    [self.tableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

@end
