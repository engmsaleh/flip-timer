//
//  FlipClockTile.h
//  FlipClock
//
//  Created by Mateusz Matoszko on 01.09.2012.
//
//

//#import <QuartzCore/QuartzCore.h>
#import "FlipClockImages.h"

@interface FlipClockTile : CALayer

- (id)initWithFrame:(CGRect)frame andValue:(int)value which:(BOOL)isOnTop;

- (void)dealloc;

@end
