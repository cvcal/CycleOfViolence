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

typedef NS_ENUM(NSInteger, gameState) {
    waitingToStart, // Game has been created, but play has not begun. Players can join.
    inProgress, // Play has begun but game has not ended.
    completed, // Game ends with one player winning.
    aborted // Game is canceled before play begins.
};

// Boilerplate to subclass PFObject.
@interface COVGame : PFObject < PFSubclassing >

@property NSMutableArray *cycle; // Array of players indicating taget ordering.
@property NSString *name; // Name of the game.
@property u_int32_t numberOfPlayers; // Number of total participants.
@property u_int32_t playersRemaining; // Number not yet assassinated.
@property NSString* gameManagerId; // Stores objectID of the game manager
@property gameState state; // Records where the game is in its lifecycle.
@property NSString *rules;
@property NSDate *startTime;
@property NSString *winner; // The last person alive. Not valid if game is aborted.

// Required to make a proper subclass of PFObject.
+ (NSString *)parseClassName;

// Initializes the game with name gameName and no players.
- (id) initWithName:(NSString *)gameName;

// Adds the specified player to the game.
- (void) addPlayer:(PFUser *)newPlayer;

// Removes the specified player from the game.
- (void) removePlayer:(PFUser *)exPlayer;

// Start the game
- (void) startGame;

// Abort the game
- (void) abortGame;

// Mark the game as completed
- (void) completeGame;

// Clean up the game to prepare to end it
- (void) prepareToEndGame;

// Gets the target for the given player
- (PFUser*) getTarget:(PFUser *)assassin;

@end
