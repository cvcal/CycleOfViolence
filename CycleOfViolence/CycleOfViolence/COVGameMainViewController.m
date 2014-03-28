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
    
    // Get the current user.
    PFUser *currUser = [PFUser currentUser];
    
    // Set the title to show the user.
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", currUser.username];
    [_navBar setTitle:title];
    
    // Get the target from the cycle in the user's current game.
    COVGame *currGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                    objectId:currUser[@"currentGameID"]];
    PFUser *target = [currGame getTarget:currUser];
    
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
