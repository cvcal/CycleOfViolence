//
//  COVQueryTableViewController.m
//  CycleOfViolence
//
//  Created by Chloé Calvarin on 4/22/14.
//
//

#import "COVQueryTableViewController.h"

@interface COVQueryTableViewController ()

@end

@implementation COVQueryTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Make this view seemingly consistent with our non-table viewControllers.
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:
                                    @"blood_splatter_transparency_by_sagacious-d3h1yw6.png"]];
    [self.view addSubview:backgroundView];

    // Change appearance of navigation bar.
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor =
                [UIColor colorWithRed:96/255.0f green:77/255.0f blue:96/255.0f alpha:0.5f];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:
                @{NSForegroundColorAttributeName : [UIColor lightTextColor]}];
    
    // Send image behind the text/storyboard stuff.
    [self.view sendSubviewToBack:backgroundView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
                                           forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set cells as semi-transparent.
    cell.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    
    // Set text as white, smaller text as light.
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor lightTextColor];
    
    // Don't allow the cells to be highlighted.
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
