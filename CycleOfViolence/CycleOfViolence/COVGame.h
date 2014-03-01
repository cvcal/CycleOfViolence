//
//  COVGame.h
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <Parse/PFObject.h>

// Boilerplate to subclass PFObject.
@interface COVGame : PFObject < PFSubclassing >

@property NSMutableArray *cycle; // array of players indicating taget ordering
@property NSString *name; // name of the game
@property u_int32_t numberOfPlayers; // number of total participants
@property u_int32_t playersRemaining; // number not yet assassinated

// Required to make a proper subclass of PFObject.
+ (NSString *)parseClassName;

// Initializes the game with name gameName and no players.
- (id) init:(NSString *)gameName;

// Adds the specified player to the game.
- (void) addPlayer:(PFUser *)newPlayer;

@end
