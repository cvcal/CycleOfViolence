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
    
    // Send image behind the text/storyboard stuff.
    [self.view sendSubviewToBack:backgroundView];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Add the name to the navigation bar. We need to do this in viewDidAppear
    // so that we update the user when the modal login view is dismissed.
    PFUser *currentUser = [PFUser currentUser];
    NSString *userFirstName = [[currentUser[@"fullName"]
                                componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", userFirstName];
    [self.navigationItem setTitle:title];
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
