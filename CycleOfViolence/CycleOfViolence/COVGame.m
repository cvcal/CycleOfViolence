//
//  COVGame.m
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import "COVGame.h"

@implementation COVGame

// These declarations tell the (pre)compiler to generate the
// getters and setters necessary to make a PFObject work.
@dynamic cycle;
@dynamic name;
@dynamic numberOfPlayers;
@dynamic playersRemaining;
@dynamic gameManager;

+ (NSString *)parseClassName {
    return @"COVGame";
}

- (id)init:(NSString *)gameName
{
    self = [super init];
    
    if(self)
    {
        // Initialize COVGame properties. numberOfPlayes and playersRemaining are automatically
        // set to zero.
        self.cycle = [[NSMutableArray alloc] init];
        self.name = gameName;
    }
    
    // Add the player who created the game.
    PFUser *creator = [PFUser currentUser];
    [self addPlayer:creator];
    // The creator is the game manager by default.
    self.gameManager = creator;
    
    return self;
}

- (void) addPlayer:(PFUser *)newPlayer
{
    // Generate a random position for the new player and insert them.
    int random = arc4random_uniform(self.numberOfPlayers);
    [self.cycle insertObject:newPlayer atIndex:random];
    ++self.numberOfPlayers;
    ++self.playersRemaining;
    [self save]; // We need the objectId for the User, so we can't saveInBackground.
    
    // Store the game's ID in the User who joined (pointers don't save properly).
    PFUser *currUser = [PFUser currentUser];
    currUser[@"currentGameID"] = self.objectId;
    [currUser saveInBackground];
}


@end
