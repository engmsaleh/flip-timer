//
//  FlipClockTile.h
//  FlipClock
//
//  Created by Mateusz Matoszko on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipClockTile.h"

typedef enum {
    ready = 0,
    topDown,
    bottomDown
} animationState;

@interface FlipClockDigit : CALayer
{
    animationState myAnimationState;
    int digit;
}

@property (nonatomic, weak) FlipClockTile *top;
@property (nonatomic, weak) FlipClockTile *nextTop;
@property (nonatomic, weak) FlipClockTile *bottom;
@property (nonatomic, weak) FlipClockTile *nextBottom;

- (id)initWithFrame:(CGRect)frame andValue:(int)value;

- (int)digit;
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
- (void)nextAnimationState;
- (void)flipViews;
- (void)setDigit:(int)value;

@end
