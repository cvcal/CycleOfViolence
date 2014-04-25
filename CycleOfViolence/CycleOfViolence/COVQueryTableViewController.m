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
    
    // send image behind the text/storyboard stuff.
    [self.view sendSubviewToBack:backgroundView];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Add the name to the navigation bar. We need to do this in viewDidAppear
    // so that we update the user when the modal login view is dismissed.
    PFUser *currUser = [PFUser currentUser];
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", currUser[@"fullName"]];
    [self.navigationItem setTitle:title];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
                                           forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // set cells as semi-transparent.
    cell.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    // set text as white
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor lightTextColor];
}

@end
