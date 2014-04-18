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

@property COVGame *currentGame;

- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

- (IBAction)buttonTapped:(id)sender;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
