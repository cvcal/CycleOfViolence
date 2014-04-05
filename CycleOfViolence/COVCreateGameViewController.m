//
//  COVCreateGameViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import "COVCreateGameViewController.h"

@interface COVCreateGameViewController ()

// These are private properties, the objects on the storyboard for this view controller.
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *rules;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end


@implementation COVCreateGameViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender
{
    // If the segue was iniated by the create button, make a new game.
    if (sender == self.createButton) {
        // Let us know how we got here.
        NSLog(@"Called buttonTapped via createButton");
        
        COVGame *newGame = [COVGame alloc];
        NSLog(@"Allocated COVGame");
        newGame = [newGame init:self.name.text]; // Use the name from the UITextField.
        
        NSString *defaultRules = @"Basic Rules: When the game starts, you will receive the name of one other player, your target. Your goal is to assassinate them by meeting the kill criterion, below. Meanwhile, someone else will be trying to assassinate you; if they succeed, you will report it and be removed from the game. You win by being the last one alive.\n\n";
        newGame.rules = [defaultRules stringByAppendingString:self.rules.text];
        
        NSLog(@"Initialized COVGame");
        
        // Save the game.
        [newGame saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
                
                PFUser *currUser = [PFUser currentUser];
                [currUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    // Now can proceed to home screen.
                    [self performSegueWithIdentifier:@"toHomeScreenFromCreate" sender:self];
                }];
                
            } else {
                NSLog(@"Failed to save in background.");
            }
        }];
    } else {
        // This shouldn't happen.
        NSLog(@"Called buttonTapped via some other means");
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // If the segue was iniated by the create button, verify that the game name is unique.
    if (sender == self.createButton) {
        // Let us know how we got here.
        NSLog(@"Called shouldPerformSegueWithIdentifier via createButton");
        
        // Verify that the game name is not taken.
        PFQuery *query = [PFQuery queryWithClassName:@"COVGame"];
        [query whereKey:@"name" equalTo:self.name.text];
        NSInteger numberGamesWithSameName = [query countObjects];
        
        if (numberGamesWithSameName != 0) {
            // Display an alert.
            [[[UIAlertView alloc] initWithTitle:@"Duplicate Game Name"
                                        message:@"That name is already in use!"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
            return NO;
        } else {
            // Game name is okay; proceed with segue.
            return YES;
        }
        
    } else {
        // Nothing to check if sender is not createButton.
        return YES;
    }
}


@end
