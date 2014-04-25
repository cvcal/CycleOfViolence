//
//  COVGameHistoryViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 4/24/14.
//
//

#import "COVGameHistoryViewController.h"

@implementation COVGameHistory

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Customize the table.
        
        // The className to query on.
        self.parseClassName = @"COVGame";
        
        // The key of the PFObject to display in the label of the default cell style.
        self.textKey = @"name";
        
        // The title for this table in the Navigation Controller.
        self.title = @"Games";
        
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 10;
    }
    
    return self;
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


// Define the query to use on the class.
- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"numberOfPlayers"];
    
    // Query for all games that have ended - either by aborting or completing.
    NSArray *endStates = @[@(completed),@(aborted)];
    [query whereKey:@"state" containedIn:endStates];
    
    return query;
}



// Customize the look of a cell representing an object.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of Players: %@", [object objectForKey:@"numberOfPlayers"]];
    
    return cell;
}

#pragma mark - Table view data source

#pragma mark - Table view delegate

// Segue to the ConfirmJoinGameViewController upon selecting a row.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
}

// Tell the destination view controller what game it should display info for.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

// Allow COVJoinGameViewController to be unwound to.
-(IBAction)unwindToJoinGame:(UIStoryboardSegue *)segue
{
    // Nothing to do.
}

@end
