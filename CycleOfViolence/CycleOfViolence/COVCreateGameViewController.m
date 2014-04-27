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
@property (weak, nonatomic) IBOutlet UITextField *startDateField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    
    // Get current time
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy HH:mm"];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    
    // Default start time to current time.
    self.startDateField.text = currentTime;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // This is useful so that the scroll view actually scrolls to the bottom.
    [self.scrollView setContentSize:CGSizeMake(320, 808)];
}


- (IBAction)buttonTapped:(id)sender
{
    // If the segue was iniated by the create button, make a new game.
    if (sender == self.createButton) {
        // Let us know how we got here.
        NSLog(@"Called buttonTapped via createButton");
        // Disable create button during operation
        [self.createButton setEnabled:NO];
        
        // Check
        if ([self.name.text isEqualToString: @""]) {
            [[[UIAlertView alloc] initWithTitle:@"Missing Game Name"
                                        message:@"Please include a name for your game."
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
        } else {
            NSLog(@"Checking if the name is a duplicate.");
            
            // Verify that the game name is not taken by an unstarted game.
            PFQuery *query = [PFQuery queryWithClassName:@"COVGame"];
            [query whereKey:@"name" equalTo:self.name.text];
            [query whereKey:@"state" equalTo:@(waitingToStart)];
            NSInteger numberGamesWithSameName = [query countObjects];
            NSLog(@"Queried parse for game name.");
            
            if (numberGamesWithSameName != 0) {
                // Display an alert.
                [[[UIAlertView alloc] initWithTitle:@"Duplicate Game Name"
                                            message:@"That name is already in use!"
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
            } else {
                // Get date from date field so we can check if the game is valid.
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MM-dd-yyy HH:mm"];
                [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
                
                NSDate *startDateFromInput = [dateFormatter dateFromString:self.startDateField.text];
                
                if (startDateFromInput != nil) {
                    COVGame *newGame = [COVGame alloc];
                    NSLog(@"Allocated COVGame");
                    newGame = [newGame initWithName:self.name.text]; // Use the name from the UITextField.
                    
                    NSString *defaultRules = @"Basic Rules: When the game starts, you will receive the name of one other player, your target. Your goal is to assassinate them by meeting the kill criterion, below. Meanwhile, someone else will be trying to assassinate you; if they succeed, you will report it and be removed from the game. You win by being the last one alive.\n\n";
                    newGame.rules = [defaultRules stringByAppendingString:self.rules.text];
                    newGame.startTime = startDateFromInput;
                    newGame.actualStartTime = startDateFromInput;
                    NSLog(@"Initialized COVGame");
                    
                    // Save the game.
                    [newGame saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSLog(@"Sucessfully saved in background.");
                            PFUser *creator = [PFUser currentUser];
                            // We have to do this here because the COVGame's
                            // objectId is null until it has been saved.
                            newGame[@"uniqueId"] = newGame.objectId;
                            [newGame addPlayer:creator];
                            [newGame saveInBackground];
                            
                            [creator saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                // Now can proceed to home screen.
                                [self performSegueWithIdentifier:@"toHomeScreenFromCreate" sender:self];
                            }];
                            
                        } else {
                            NSLog(@"Failed to save in background.");
                            [[[UIAlertView alloc] initWithTitle:@"Cloud save failed"
                                                        message:@"Please try again some other time."
                                                       delegate:nil
                                              cancelButtonTitle:@"ok"
                                              otherButtonTitles:nil] show];
                        }
                    }];
                } else {
                    // Date format failed
                    [[[UIAlertView alloc] initWithTitle:@"Date Format Incorrect"
                                                message:@"Please format the start time as MM-dd-yyy HH:mm"
                                               delegate:nil
                                      cancelButtonTitle:@"ok"
                                      otherButtonTitles:nil] show];
                }
            }
        }
    } else {
        // This shouldn't happen.
        NSLog(@"Called buttonTapped via some other means");
    }
    
    // re-enable create button during operation
    [self.createButton setEnabled:YES];
}


@end
