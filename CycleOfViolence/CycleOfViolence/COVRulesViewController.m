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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the rules according to the correct game.
    PFUser *currUser = [PFUser currentUser];
    COVGame *currGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                    objectId:currUser[@"currentGameID"]];
    self.rules.text = currGame.rules;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
