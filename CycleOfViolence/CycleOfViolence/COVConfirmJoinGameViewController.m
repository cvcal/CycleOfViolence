//
//  COVConfirmJoinGameViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 3/1/14.
//
//

#import "COVConfirmJoinGameViewController.h"

@interface COVConfirmJoinGameViewController ()

@end

@implementation COVConfirmJoinGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithGame:(COVGame *) currentGame
{
    if (self) {
        self.currentGame = currentGame;
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

@end
