//
//  COVQueryTableViewController.m
//  CycleOfViolence
//
//  Created by Chloé Calvarin on 4/22/14.
//
//

#import "COVQueryTableViewController.h"

@interface COVQueryTableViewController ()

@end

@implementation COVQueryTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Make this view seemingly consistent with our non-table viewControllers.
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:
                                    @"blood_splatter_transparency_by_sagacious-d3h1yw6.png"]];
    [self.view addSubview:backgroundView];
    
    // send image behind the text/storyboard stuff.
    [self.view sendSubviewToBack:backgroundView];
    
}

@end
