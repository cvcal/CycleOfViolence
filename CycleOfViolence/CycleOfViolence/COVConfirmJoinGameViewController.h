//
//  COVConfirmJoinGameViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 3/1/14.
//
//

#import "COVViewController.h"
#import "COVGame.h"

@interface COVConfirmJoinGameViewController : COVViewController

// Store game locally for convenience
@property COVGame *currentGame;

// Method overrides from COVViewController and UIViewController
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

// Own methods
- (IBAction)buttonTapped:(id)sender;

@end
