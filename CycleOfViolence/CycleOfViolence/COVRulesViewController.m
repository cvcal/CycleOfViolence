//
//  COVRulesViewController.m
//  CycleOfViolence
//
//  Created by Reyna Hulett on 4/5/14.
//
//

#import "COVRulesViewController.h"

@interface COVRulesViewController ()

@property (weak, nonatomic) IBOutlet UITextView *rules;

@end

@implementation COVRulesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the rules according to the correct game.
    PFUser *currentUser = [PFUser currentUser];
    COVGame *currentGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                    objectId:currentUser[@"currentGameID"]];
    self.rules.text = currentGame.rules;
}

@end
