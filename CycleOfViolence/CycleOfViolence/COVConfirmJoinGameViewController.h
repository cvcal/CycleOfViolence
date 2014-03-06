//
//  COVConfirmJoinGameViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 3/1/14.
//
//

#import <UIKit/UIKit.h>
#import "COVGame.h"

@interface COVConfirmJoinGameViewController : UIViewController

@property COVGame *currentGame;

- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
