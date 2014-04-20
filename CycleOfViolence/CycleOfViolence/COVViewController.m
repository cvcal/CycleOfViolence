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
    
    //add background blood splatter, with a black background
    self.view.backgroundColor = [UIColor blackColor]; 
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:
                                    @"blood_splatter_transparency_by_sagacious-d3h1yw6.png"]];
    [self.view addSubview:backgroundView];
    
    // send image behind the text/storyboard stuff.
    [self.view sendSubviewToBack:backgroundView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // add the name to the navigation bar
    PFUser *currUser = [PFUser currentUser];
    NSString *title = [NSString stringWithFormat:@"Welcome, %@!", currUser.username];
    [self.navigationItem setTitle:title];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
