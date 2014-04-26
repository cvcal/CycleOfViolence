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
@dynamic gameManagerId;
@dynamic state;
@dynamic rules;
@dynamic startTime;
@dynamic winnerName;
@dynamic managerName;
@dynamic uniqueId;

+ (NSString *)parseClassName
{
    return @"COVGame";
}

- (id)initWithName:(NSString *)gameName
{
    self = [super init];
    
    if(self)
    {
        // Initialize COVGame properties. numberOfPlayes and playersRemaining are automatically
        // set to zero.
        self.cycle = [[NSMutableArray alloc] init];
        self.name = gameName;
        self.state = waitingToStart;
        self.winnerName = @"None";
        
        // The current user must have created the game and is the game manager by default.
        PFUser *creator = [PFUser currentUser];
        self.gameManagerId = creator.objectId;
        self.managerName = creator[@"fullName"];

    
        // Add the player who created the game. We need to access the objectId in addPlayer;
        // saving creates the ID.
        [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background from init game.");
            } else {
                NSLog(@"Failed to save in background from init game.");
            }
        }];
    }
    
    return self;
}

- (void)addPlayer:(PFUser *)newPlayer
{
    // Generate a random position for the new player and insert them.
    int random = arc4random_uniform(self.numberOfPlayers);
    [self.cycle insertObject:newPlayer atIndex:random];
    ++self.numberOfPlayers;
    ++self.playersRemaining;
    
    // Store the game's ID in the User who joined (pointers don't save properly).
    newPlayer[@"currentGameID"] = self.objectId;
    // Make the game the latest in the player's history.
    [newPlayer[@"gameHistory"] insertObject:self.objectId atIndex:0];
    
    // The calling function should update Parse cloud storage
}

- (void)startGame
{
    self.state = inProgress;
}

- (void)abortGame
{
    [self prepareToEndGame];
    self.state = aborted;
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Sucessfully saved in background from init game.");
        } else {
            NSLog(@"Failed to save in background from init game.");
        }
    }];
}

- (void)completeGame
{
    // When the game ends, the victor is the last player left in the cycle.
    PFUser *winner =(PFUser *)[self.cycle objectAtIndex:0];
    [winner fetchIfNeeded];
    self.winnerName = winner[@"fullName"];
    // Clean up the game.
    [self prepareToEndGame];
    self.state = completed;
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Sucessfully saved in background from init game.");
        } else {
            NSLog(@"Failed to save in background from init game.");
        }
    }];
}

- (void)removePlayer:(PFUser *)exPlayer
{
    NSLog(@"Removing player %@", exPlayer.username);
    // Remove the user from the cycle
    NSUInteger userIndex = -1;
    NSUInteger end = [self.cycle count];
    for (NSUInteger i = 0; i < end; i++) {
        NSLog(@"At index %lu", (unsigned long)i);
        PFUser *entry = (PFUser *)[self.cycle objectAtIndex:i];
        if ([exPlayer.objectId isEqualToString:entry.objectId]) {
            userIndex = i;
            break;
        }
    }
    
    [self.cycle removeObjectAtIndex:userIndex];
    self.playersRemaining = (u_int32_t)[self.cycle count];
}

- (void)prepareToEndGame
{
    // Empty out all the users and update them as well, so they don't link to a
    // non-existant game.
    while ([self.cycle count] != 0){
        PFUser *user = [self.cycle objectAtIndex:0];
        user = (PFUser *)[user fetchIfNeeded];
        [self removePlayer:user];
    }
}

- (PFUser*)getTarget:(PFUser *)assassin
{
    // Find the assassin in the cycle.
    NSUInteger userIndex = -1;
    for (NSUInteger i = 0; i < [self.cycle count]; i++) {
        PFUser *entry = (PFUser *)[self.cycle objectAtIndex:i];
        if ([assassin.objectId isEqualToString:entry.objectId]) {
            userIndex = i;
            break;
        }
    }
    
    // The target is stored one after the current user.
    NSUInteger targetIndex = (userIndex + 1) % [self.cycle count];
    PFUser *target = [self.cycle objectAtIndex:targetIndex];
    
    // Get the target's data from Parse, since it is not stored in cycle.
    target = (PFUser *)[target fetchIfNeeded];
    return target;
}

- (NSString *) getStatusAsString
{
    switch(self.state) {
        case 0:
            return @"waitingToStart";
        case 1:
            return @"inProgress";
        case 2:
            return @"completed";
        case 3:
            return @"aborted";
    }
}

@end
