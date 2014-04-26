//
//  COVViewController.m
//  CycleOfViolence
//
//  Created by Chloe Calvarin on 4/12/14.
//
//

#import "COVViewController.h"

@interface COVViewController ()

@end

@implementation COVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add background blood splatter, with a black background
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:
                                    @"blood_splatter_transparency_by_sagacious-d3h1yw6.png"]];
    [self.view addSubview:backgroundView];
    
    // send image behind the text/storyboard stuff.
    [self.view sendSubviewToBack:backgroundView];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Add the name to the navigation bar. We need to do this in viewDidAppear
    // so that we update the user when the modal login view is dismissed.
    PFUser *currUser = [PFUser currentUser];
    // Break the user's name into words and select the first.
    NSString *userFirstName = [[currUser[@"fullName"] componentsSeparatedByString:@" "] objectAtIndex:0];
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", userFirstName];
    [self.navigationItem setTitle:title];
}

@end
