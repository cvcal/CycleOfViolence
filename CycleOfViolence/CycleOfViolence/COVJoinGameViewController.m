//
//  COVJoinGameViewController.m
//  ParseStarterProject
//
//  Created by James Yu on 12/29/11.
// Adapted by John Phillpot and Reyna Hulett 2/27/2014.
//

#import "COVJoinGameViewController.h"

@implementation COVJoinGameViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad
{
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
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
    if ([indexPath row] > self.objects.count -1 ) {
        return;
    }
    COVGame *currentGame = (COVGame *)[self objectAtIndexPath:indexPath];
    NSLog(@"Selected game: %@", currentGame.name);
    [self performSegueWithIdentifier:@"ConfirmationSegue" sender:self];
    
}

// Tell the destination view controller what game it should display info for.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ConfirmationSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        COVGame *currentGame = (COVGame *)[self objectAtIndexPath:indexPath];
        COVConfirmJoinGameViewController *destination = segue.destinationViewController;
        destination.currentGame = currentGame;
    } else {
        NSLog(@"Segue from JoinGame VC, but not to ConfirmJoinGame.");
    }
}

// Allow COVJoinGameViewController to be unwound to.
-(IBAction)unwindToJoinGame:(UIStoryboardSegue *)segue
{
    // Nothing to do.
}

@end