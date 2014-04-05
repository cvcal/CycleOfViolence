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
#import <Parse/PFObject+Subclass.h>

// Boilerplate to subclass PFObject.
@interface COVGame : PFObject < PFSubclassing >

@property NSMutableArray *cycle; // Array of players indicating taget ordering.
@property NSString *name; // Name of the game.
@property u_int32_t numberOfPlayers; // Number of total participants.
@property u_int32_t playersRemaining; // Number not yet assassinated.
@property PFUser *gameManager; // The player who can start the game.
@property BOOL gameStarted; // Whether game play has begun.
@property NSString *rules;

// Required to make a proper subclass of PFObject.
+ (NSString *)parseClassName;

// Initializes the game with name gameName and no players.
- (id) init:(NSString *)gameName;

// Adds the specified player to the game.
- (void) addPlayer:(PFUser *)newPlayer;

// Removes the specified player from the game.
- (void) removePlayer:(PFUser *)exPlayer;

// Start the game
- (void) startGame;

// Clean up the game to prepare for deleting
- (void) cleanGameForDelete;

// Gets the target for the given player
- (PFUser*) getTarget:(PFUser *)assassin;

@end
