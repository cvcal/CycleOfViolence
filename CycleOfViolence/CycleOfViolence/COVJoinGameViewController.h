//
//  COVJoinGameViewController.h
//  ParseStarterProject
//
//  Created by James Yu on 12/29/11.
//  Adapted by John Phillpot and Reyna Hulett 2/27/2014.
//

#import <Parse/Parse.h>
#import "COVGame.h"
#import "COVConfirmJoinGameViewController.h"

@interface COVJoinGameViewController : PFQueryTableViewController

// Method overrides from PFQueryTableViewController and UITableViewController
- (id)initWithCoder:(NSCoder *)aDecoder;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (PFQuery *)queryForTable;
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

// Unwind Methods
- (IBAction)unwindToJoinGame:(UIStoryboardSegue *)segue;

@end