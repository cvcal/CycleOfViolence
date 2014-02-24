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
    NSLog(@"Called unwind");
    //COVGame* newGame = [[COVGame alloc] init:@"newGame"];
    PFObject *newGame = [PFObject objectWithClassName:@"Game"];
    newGame[@"cycle"] = [[NSMutableArray alloc] init];
    newGame[@"numberOfPlayers"] = 0;
    newGame[@"playersRemaining"] = 0;
    newGame[@"name"] = self.name.text;
    
    [newGame saveInBackground];
}

@end
