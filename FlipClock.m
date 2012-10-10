//
//  FlipClock.m
//  FlipClock
//
//  Created by Mateusz Matoszko on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipClock.h"

#define NUMBER_OF_TILES 6
#define BASE 10
#define FLIP_DELAY 1.0

@implementation FlipClock

@synthesize aTimer = _aTimer;

@synthesize tiles = _tiles;

- (id)initWithTilePosition:(CGPoint) position andHeight:(int)height
{
    int width = height/2;
    
    CGRect frame = CGRectMake(position.x, position.y, NUMBER_OF_TILES*width, height);
    
    self = [super initWithFrame:frame];
    
    
    if (self) {
        self.tiles = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_TILES];
        for (int i = 0; i < NUMBER_OF_TILES; ++i) {
            frame = CGRectMake(i * width, 0, width, height);
            FlipClockDigit *fpd = [[FlipClockDigit alloc] initWithFrame:frame andValue:0];
            [self.tiles addObject:fpd];
            
            
            [self.layer addSublayer:fpd];
        }
    }
    
    return self;
}


- (void)setTimer:(int)hours:(int)minutes:(int)seconds
{
    self.hours = hours;
    self.minutes = minutes;
    self.seconds = seconds;
    
    self.aTimer = [NSTimer scheduledTimerWithTimeInterval:FLIP_DELAY target:self selector:@selector(substractSecond:) userInfo:nil repeats:YES];
}

- (void)setClock:(int)hours:(int)minutes:(int)seconds
{
    self.hours = hours;
    self.minutes = minutes;
    self.seconds = seconds;
    
    self.aTimer = [NSTimer scheduledTimerWithTimeInterval:FLIP_DELAY target:self selector:@selector(addSecond:) userInfo:nil repeats:YES];
}

- (void)setSeconds:(int)value
{
    if (_seconds != value) {
        _seconds = value;
        if (_seconds > 59) {
            _seconds = 0;
            self.minutes = _minutes + 1;
        }
        else if (_seconds < 0) {
            _seconds = 59;
            self.minutes = _minutes - 1;
        }
        [[_tiles objectAtIndex:4] setDigit:_seconds/BASE];
        [[_tiles objectAtIndex:5] setDigit:_seconds%BASE];
    }
}

- (void)addSecond:(id)sender
{
    self.seconds = _seconds + 1;
}

- (void)substractSecond:(id)sender
{
    self.seconds = _seconds - 1;
}

- (void)setMinutes:(int)value
{
    if (_minutes != value) {
        _minutes = value;
        if (_minutes > 59) {
            _minutes = 0;
            self.hours = _hours + 1;
        }
        else if (_minutes < 0) {
            _minutes = 59;
            self.hours = _hours - 1;
        }
        [[_tiles objectAtIndex:2] setDigit:_minutes/BASE];
        [[_tiles objectAtIndex:3] setDigit:_minutes%BASE];
    }
}

- (void)setHours:(int)value
{
    if (_hours != value) {
        _hours = value;
        if (_hours > 99) {
            _hours = 0;
            self.seconds = 0;
            self.minutes = 0;
        }
        else if (_hours < 0) {
            _hours = 99;
            self.seconds = 59;
            self.minutes = 59;
        }
        
        [[_tiles objectAtIndex:0] setDigit:_hours/BASE];
        [[_tiles objectAtIndex:1] setDigit:_hours%BASE];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
