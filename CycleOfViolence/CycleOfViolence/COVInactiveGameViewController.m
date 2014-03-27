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
    self.targetDisplay.text = [NSString stringWithFormat:@"You are: %@\n and your target is: %@",
                          currUser.username, target.username];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
