//
//  COVGameHistoryViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 4/25/14.
//
//

#import "COVGame.h"
#import "COVQueryTableViewController.h"

@interface COVGameHistoryViewController : COVQueryTableViewController

// Method overrides from COVQueryTableViewController and UITableViewController
- (id)initWithCoder:(NSCoder *)aDecoder;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (PFQuery *)queryForTable;
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;


@end
