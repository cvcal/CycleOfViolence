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
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

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
    PFUser *currentUser = [PFUser currentUser];
    self.currentGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                    objectId:currentUser[@"currentGameID"]];
    // Set the title to show the user.
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", currentUser.username];
    [self.navBar setTitle:title];
    
    [self.currentGame refresh];
    if (self.currentGame.playersRemaining > 1) {
        // Get the target from the cycle in the user's current game.
        PFUser *target = [self.currentGame getTarget:currentUser];
        
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

- (IBAction)buttonTapped:(id)sender
{
    PFUser *currentUser = [PFUser currentUser];
    if (sender == self.suicideButton || sender == self.murderButton) {
        NSLog(@"leaveButton/murderButton tapped");
        // Disable buttons during operation
        [self.suicideButton setEnabled:NO];
        [self.murderButton setEnabled:NO];
        
        // This button removes a user from the game.
        if (self.currentGame.playersRemaining <= 1) {
            NSLog(@"Game end, deleting game, hopefully.");
            [self.currentGame completeGame];
        }
        else {
            NSLog(@"User leaving game, hopefully.");
            [self.currentGame removePlayer:currentUser];
            
            // Update Parse cloud storage
            [self.currentGame saveInBackground];
        }
        
        // Update the currentGameID in the User who left.
        currentUser[@"currentGameID"] = [NSNull null];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
                
                // Since user is no longer in the game, return them to the home screen.
                [self performSegueWithIdentifier:@"toHomeScreenFromMain" sender:self];
                
            } else {
                NSLog(@"Failed to save in background.");
                [[[UIAlertView alloc] initWithTitle:@"Cloud save failed"
                                            message:@"Please try again some other time."
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
            }
        }];
        
        // Re-enable buttons during operation, this shouldn't be called if operation succeeds
        // and segues out.
        [self.suicideButton setEnabled:YES];
        [self.murderButton setEnabled:YES];
    }
    else if (sender == self.refreshButton) {
        [self viewDidLoad];
    }
}

@end
