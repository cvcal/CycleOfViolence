//
//  COVInactiveGameViewController.m
//  CycleOfViolence
//
//  Created by Reyna Hulett on 3/6/14.
//
//

#import "COVInactiveGameViewController.h"

@interface COVInactiveGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *targetDisplay;
@property (weak, nonatomic) IBOutlet UIButton *leaveButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end

@implementation COVInactiveGameViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Don't allow users to return to the home screen while they are in a game.
        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get the current user.
    PFUser *currUser = [PFUser currentUser];
    
    // Set the title to show the user.
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", currUser.username];
    [_navBar setTitle:title];
    
    // Get the target from the cycle in the user's current game.
    COVGame *currGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                    objectId:currUser[@"currentGameID"]];
    
    // Find the current user in the cycle.
    NSUInteger userIndex = -1;
    for (NSUInteger i = 0; i < [currGame.cycle count]; i++) {
        PFUser *entry = (PFUser *)[currGame.cycle objectAtIndex:i];
        if ([currUser.objectId isEqualToString:entry.objectId]) {
            userIndex = i;
            break;
        }
    }
    
    // The target is stored one after the current user.
    NSUInteger targetIndex = (userIndex + 1) % [currGame.cycle count];
    PFUser *target = [currGame.cycle objectAtIndex:targetIndex];
    
    // Get the target's data from Parse, since it is not stored in cycle.
    target = (PFUser *)[target fetchIfNeeded];
    
    // Set the view controller to display the current user and target.
    self.targetDisplay.text = [NSString stringWithFormat:
                               @"You are: %@\n and your target is: %@",
                               currUser.username,
                               target.username];
    
    // Show the buttons selectively.
    // If we're the manager
    if ([currUser.objectId isEqualToString: (currGame.gameManager).objectId]){
        [self.leaveButton setTitle:@"Delete Game" forState:UIControlStateNormal];
        [self.startButton setTitle:@"Start Game" forState:UIControlStateNormal];
        
    }
    else {
        // Disable the 'start game' button
        [self.startButton setEnabled:NO];
        // Make the text appropriate for the 'Leave Game" button
        [self.leaveButton setTitle:@"Leave Game" forState:UIControlStateNormal];
    }
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonTapped:(id)sender {
    PFUser *currUser = [PFUser currentUser];
    COVGame *currGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                    objectId:currUser[@"currentGameID"]];
    
    if(sender == self.startButton) {
        // Start the game!
        NSLog(@"startButton tapped");
        [currGame startGame];
    }
    else if (sender == self.leaveButton) {
        NSLog(@"leaveButton tapped");
        
        // This button either lets a user leave the game, or it deletes the game if
        // the user is the manager
        if ([currUser.objectId isEqualToString: (currGame.gameManager).objectId]) {
            NSLog(@"Manager deleting game, hopefully.");
            [currGame cleanGameForDelete];
            [currGame refresh];
            [currGame delete];
        }
        else {
            NSLog(@"User leaving game, hopefully.");
            [currGame removePlayer:currUser];
        }
        
        // Update the currentGameID in the User who left, or the manager who deleted the game.
        currUser[@"currentGameID"] = [NSNull null];
        [currUser saveInBackground];
    }
}

@end
