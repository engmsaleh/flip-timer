//
//  FlipClock.h
//  FlipClock
//
//  Created by Mateusz Matoszko on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipClockDigit.h"


@interface FlipClock : UIControl
{
    int _hours, _minutes, _seconds;
}

@property (nonatomic, strong) NSTimer *aTimer;

@property (nonatomic, strong) NSMutableArray *tiles;

- (id)initWithTilePosition:(CGPoint) position andHeight:(int)height;

- (void)setTimer:(int)hours:(int)minutes:(int)seconds;
- (void)setClock:(int)hours:(int)minutes:(int)seconds;

- (void)setSeconds:(int)value;
- (void)addSecond:(id)sender;
- (void)substractSecond:(id)sender;

- (void)setMinutes:(int)value;

- (void)setHours:(int)value;

@end
