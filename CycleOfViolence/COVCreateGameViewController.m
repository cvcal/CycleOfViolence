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
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end


@implementation COVCreateGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Include custom initialization.
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // If the segue was iniated by the create button, make a new game.
    if (sender == self.createButton) {
        // Let us know how we got here.
        NSLog(@"Called prepareForSegue via createButton");
        
        COVGame *newGame = [COVGame alloc];
        NSLog(@"Allocated COVGame");
        newGame = [newGame init:self.name.text]; // Use the name from the UITextField.
        NSLog(@"Initialized COVGame");
        
        // Include debugging output.
        [newGame saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
            } else {
                NSLog(@"Failed to save in background.");
            }
        }];
        
    } else if (sender == self.cancelButton) {
        // Let us know how we got here.
        NSLog(@"Called prepareForSegue via cancelButton");

    } else {
        // This shouldn't happen.
        NSLog(@"Called prepareForSegue via someOtherMeans");
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
