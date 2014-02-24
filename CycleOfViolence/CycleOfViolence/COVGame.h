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
+ (NSString *)parseClassName;

// The stuff we actually care about.
@property NSMutableArray *cycle;

@property NSString *name;

@property u_int32_t numberOfPlayers;

@property u_int32_t playersRemaining;

- (id) init:(NSString *) gameName;

@end
