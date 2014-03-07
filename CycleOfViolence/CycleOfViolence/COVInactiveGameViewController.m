//
//  COVInactiveGameViewController.m
//  CycleOfViolence
//
//  Created by Reyna Hulett on 3/6/14.
//
//

#import "COVInactiveGameViewController.h"

@implementation COVInactiveGameViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Don't allow users to return to the home screen while they are in a game.
        self.navigationItem.hidesBackButton = YES;
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
