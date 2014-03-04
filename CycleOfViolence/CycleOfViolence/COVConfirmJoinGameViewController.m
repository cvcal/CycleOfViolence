//
//  COVConfirmJoinGameViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 3/1/14.
//
//

#import "COVConfirmJoinGameViewController.h"

@interface COVConfirmJoinGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *gameInfo;
@property (weak, nonatomic) IBOutlet UIButton *joinGameButton;

@end

@implementation COVConfirmJoinGameViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Set the view controller to display information about its current game.
    self.gameInfo.text = [NSString stringWithFormat:@"Game name: %@\n",
                          self.currentGame.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender == self.joinGameButton) {
        NSLog(@"Called prepareForSegue from Join Game button.");
        PFUser *currUser = [PFUser currentUser];
        [self.currentGame addPlayer:currUser];
    } else {
        NSLog(@"Segue initiated by a button besides Join Game.");
    }
}

@end
