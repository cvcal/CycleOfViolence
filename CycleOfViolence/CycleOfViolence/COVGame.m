//
//  COVGame.m
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import "COVGame.h"
#import <Parse/PFObject+Subclass.h>

@implementation COVGame

// These declarations tell the (pre)compiler to generate the
// getters and setters necessary to make a PFObject work.
@dynamic cycle;
@dynamic name;
@dynamic numberOfPlayers;
@dynamic playersRemaining;

// Required to make a proper subclass of PFObject.
+ (NSString *)parseClassName {
    return @"COVGame";
}

- (id) init:(NSString *) gameName
{
    self = [super init];
    if(self)
    {
        // These all work once we have declared the relevant properties dynamic.
        self.cycle = [[NSMutableArray alloc] init];
        self.numberOfPlayers = 0;
        self.playersRemaining = 0;
        self.name = gameName;
    }
    
    //TODO: Add the player who created the game!
    
    return self;
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
