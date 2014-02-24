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

- (IBAction) unwindToMainWithGame:(UIStoryboardSegue *)segue
{
    NSLog(@"Called unwindToMainWithGame");
    //COVGame* newGame = [[COVGame alloc] init:@"newGame"];
//    PFObject *newGame = [PFObject objectWithClassName:@"Game"];
//    newGame[@"cycle"] = [[NSMutableArray alloc] init];
//    newGame[@"numberOfPlayers"] = 0;
//    newGame[@"playersRemaining"] = 0;
//    newGame[@"name"] = self.name.text;
//    
//    [newGame saveInBackground];
}

- (IBAction) unwindToMainWithoutGame:(UIStoryboardSegue *)segue
{
    NSLog(@"Called unwindToMainWithoutGame");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self.createButton) {
        //TODO: Make the game
        COVGame* newGame = [COVGame alloc];
        NSLog(@"Allocated COVGame");
        newGame = [newGame init:self.name.text];
        NSLog(@"Initialized COVGame");
        //[newGame saveInBackground];
        [newGame saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
            } else {
                NSLog(@"Failed to save in background.");
            }
        }];
        NSLog(@"Called prepareForSegue via createButton");
        return;
    } else if (sender == self.cancelButton) {
        NSLog(@"Called prepareForSegue via cancelButton");
        return;
    } else {
        NSLog(@"Called prepareForSegue via someOtherMeans");
        return;
    }
    
}


@end
