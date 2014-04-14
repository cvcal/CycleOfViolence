//
//  COVCreateGameViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import "COVViewController.h"
#import "COVGame.h"

@interface COVCreateGameViewController : COVViewController

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)buttonTapped:(id)sender;
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;

@end
