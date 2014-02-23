//
//  COVGame.m
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import "COVGame.h"

@implementation COVGame

- (id) init:(NSString *) gameName
{
    self = [super init];
    if(self)
    {
        self.cycle = [[NSMutableArray alloc] init];
        self.numberOfPlayers = 0;
        self.playersRemaining = 0;
        self.name = gameName;
    }
    
    //TODO: Add the player who created the game!
    
    return self;
}

- (void) initializeGame
{
    return;
}

- (void) addPlayer:(PFUser *)newPlayer
{
    // Generate a random position for the new player and insert them.
    int random = arc4random_uniform(self.numberOfPlayers);
    [self.cycle insertObject:newPlayer atIndex:random];
    ++self.numberOfPlayers;
    ++self.playersRemaining;
}





@end
