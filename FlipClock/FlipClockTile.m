//
//  FlipClockTile.m
//  FlipClock
//
//  Created by Mateusz Matoszko on 01.09.2012.
//
//

#import "FlipClockTile.h"

@implementation FlipClockTile

- (id)initWithFrame:(CGRect)frame andValue:(int)value which:(BOOL)isOnTop
{
    self = [super init];
    
    if (self) {
        self.frame = frame;
        
        if (isOnTop)
            self.contents = (id)[[FlipClockImages images] getTopImageWithNumber:value].CGImage;
        else
            self.contents = (id)[[FlipClockImages images] getBottomImageWithNumber:value].CGImage;
        
        self.masksToBounds = YES;
    }
    
    return self;
}

- (void)dealloc
{
    self.contents = nil;
}

@end
