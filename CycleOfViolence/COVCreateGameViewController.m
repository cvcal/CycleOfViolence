//
//  COVCreateGameViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import "COVCreateGameViewController.h"

@interface COVCreateGameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation COVCreateGameViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // If we hit the create button, we should make the game!
    if (sender == self.createButton) {
        COVGame* newGame = [COVGame alloc];
        NSLog(@"Allocated COVGame");
        newGame = [newGame init:self.name.text];
        NSLog(@"Initialized COVGame");
        
        // Include debugging output.
        [newGame saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
            } else {
                NSLog(@"Failed to save in background.");
            }
        }];
        // Let us know how we got here.
        NSLog(@"Called prepareForSegue via createButton");
        return;
    } else if (sender == self.cancelButton) {
        // Let us know how we got here.
        NSLog(@"Called prepareForSegue via cancelButton");
        return;
    } else {
        // This shouldn't happen.
        NSLog(@"Called prepareForSegue via someOtherMeans");
        return;
    }
    
}


@end
