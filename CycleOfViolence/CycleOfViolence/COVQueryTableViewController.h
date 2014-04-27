//
//  COVQueryTableViewController.h
//  CycleOfViolence
//
//  Created by Chloé Calvarin on 4/22/14.
//
//

#import <Parse/Parse.h>

@interface COVQueryTableViewController : PFQueryTableViewController

// Method overrides from PFQueryTableViewController and UITableViewController
- (void)viewDidLoad;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
        forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
