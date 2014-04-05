//
//  COVGameMainViewController.m
//  CycleOfViolence
//
//  Created by Chloé Calvarin on 3/6/14.
//
//

#import "COVGameMainViewController.h"

@interface COVGameMainViewController ()

@property (weak, nonatomic) IBOutlet UILabel *targetDisplay;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UIButton *suicideButton;
@property (weak, nonatomic) IBOutlet UIButton *murderButton;

@end

@implementation COVGameMainViewController
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
    
    // Get the current user and game.
    PFUser *currUser = [PFUser currentUser];
    COVGame *currGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                    objectId:currUser[@"currentGameID"]];
    // Set the title to show the user.
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", currUser.username];
    [_navBar setTitle:title];
    
    [currGame refresh];
    if (currGame.playersRemaining > 1) {
        // Get the target from the cycle in the user's current game.
        PFUser *target = [currGame getTarget:currUser];
        
        // Set the view controller to display the current user and target.
        self.targetDisplay.text = [NSString stringWithFormat:@"Your target is: %@",
                                   target.username];
    }
    else {
        self.targetDisplay.text = @"You're the last one alive. Congrats on winning!";
        // Disable the 'I've been killed' button
        [self.murderButton setEnabled:NO];
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
    
    if (sender == self.suicideButton || sender == self.murderButton) {
        NSLog(@"leaveButton tapped");
        
        // This button removes a user from the game.
        if (currGame.playersRemaining <= 1) {
            NSLog(@"Game end, deleting game, hopefully.");
            [currGame cleanGameForDelete];
            [currGame deleteInBackground];
        }
        else {
            NSLog(@"User leaving game, hopefully.");
            [currGame removePlayer:currUser];
            
            // Update Parse cloud storage
            [currGame saveInBackground];
        }
        
        // Update the currentGameID in the User who left, or the manager who deleted the game.
        currUser[@"currentGameID"] = [NSNull null];
        [currUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
                
                // Since user is no longer in the game, return them to the home screen.
                [self performSegueWithIdentifier:@"toHomeScreenFromMain" sender:self];
                
            } else {
                NSLog(@"Failed to save in background.");
            }
        }];
    }
}

@end
