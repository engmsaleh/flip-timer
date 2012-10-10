//
//  FlipClockTile.m
//  FlipClock
//
//  Created by Mateusz Matoszko on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlipClockDigit.h"

#define ANIMATION_DURATION 0.28
#define Z_DEPTH 100.0

@implementation FlipClockDigit

@synthesize top = _top;
@synthesize nextTop = _nextTop;
@synthesize bottom = _bottom;
@synthesize nextBottom = _nextBottom;

- (id)initWithFrame:(CGRect)frame andValue:(int)value
{
    digit = value;
    self = [super init];
    if (self) {
        self.frame = frame;
        
        float tileWidth = frame.size.width;
        float tileHeight = frame.size.height/2;
        
        CGRect topFrame  = CGRectMake(0, 0, tileWidth, tileHeight);
        
        self.top = [[FlipClockTile alloc] initWithFrame:topFrame andValue:value which:true];
        
        [self addSublayer:_top];
        
        
        CGRect bottomFrame = CGRectMake(0, tileHeight, tileWidth, tileHeight);
        
        self.bottom = [[FlipClockTile alloc] initWithFrame:bottomFrame andValue:value which:false];
        
        [self addSublayer:_bottom];
        
//        NSLog(@"top %d", [[self sublayers] indexOfObject:_top]);
//        NSLog(@"bottom %d", [[self sublayers] indexOfObject:_bottom]);
    }
    
    return self;
}


- (int)digit
{
    return digit;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self nextAnimationState];
}

- (void)nextAnimationState
{
    switch (myAnimationState) {
        case ready:
        {
            [self flipViews];
            myAnimationState = topDown;
        }
            break;
            
        case topDown:
        {
            [_top removeFromSuperlayer];
            self.top = nil;
            
            self.top = _nextTop;
            self.nextTop = nil;
            
            
            [_nextBottom removeFromSuperlayer];
            [self insertSublayer:_nextBottom atIndex:[self.sublayers count]];
            
            myAnimationState = bottomDown;
        }
            break;
            
        case bottomDown:
        {
            [_bottom removeFromSuperlayer];
            self.bottom = _nextBottom;
            
            self.nextBottom = nil;
            myAnimationState = ready;
        }
            break;
    }
}

- (void)flipViews
{
    CATransform3D skewedIdentityTransform = CATransform3DIdentity;
    skewedIdentityTransform.m34 = 1.0 / -Z_DEPTH;
    
    CGRect properFrame = _top.frame;
    CGPoint newTopAnchor = CGPointMake(0.5f, 1.f);
    _top.anchorPoint = newTopAnchor;
    _top.frame = properFrame;
    
    // top animation
    CABasicAnimation *topAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    topAnim.beginTime = CACurrentMediaTime();
    topAnim.duration = ANIMATION_DURATION;
    
    topAnim.fromValue = [NSValue valueWithCATransform3D:skewedIdentityTransform];
    topAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(skewedIdentityTransform, -M_PI_2, 1.f, 0.f, 0.f)];
    
    topAnim.delegate = self;
    topAnim.removedOnCompletion = NO;
    topAnim.fillMode = kCAFillModeForwards;
    topAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.50 :0.50 :1.0 :1.0];
    
    [_top addAnimation:topAnim forKey:@"topDownFlip"];
    
    
    properFrame = _nextBottom.frame;
    CGPoint newBottomAnchor = CGPointMake(0.5f, 0.f);
    _nextBottom.anchorPoint = newBottomAnchor;
    _nextBottom.frame = properFrame;
    
    // bottom animation
    CABasicAnimation *bottomAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    bottomAnim.beginTime = topAnim.beginTime + topAnim.duration;
    bottomAnim.duration = topAnim.duration;
    
    bottomAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(skewedIdentityTransform, M_PI_2, 1.f, 0.f, 0.f)];
    bottomAnim.toValue = [NSValue valueWithCATransform3D:skewedIdentityTransform];
    
    bottomAnim.delegate = self;
    bottomAnim.removedOnCompletion = FALSE;
    bottomAnim.fillMode = kCAFillModeBoth;
    bottomAnim.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.30 :1.00 :1.00 :1.00];
    
    [_nextBottom addAnimation:bottomAnim forKey:@"bottomDownFlip"];
}

- (void)setDigit:(int)value
{
    if (digit != value) {
        digit = value;
        
        float tileWidth = _top.frame.size.width;
        float tileHeight = _top.frame.size.height;
        
        CGRect topFrame  = CGRectMake(0, 0, tileWidth, tileHeight);
        self.nextTop = [[FlipClockTile alloc] initWithFrame:topFrame andValue:value which:true];
        
        CGRect bottomFrame  = CGRectMake(0, tileHeight, tileWidth, tileHeight);
        self.nextBottom = [[FlipClockTile alloc] initWithFrame:bottomFrame andValue:value which:false];
        
//        [self insertSublayer:_nextTop below:_bottom];
//        [self insertSublayer:_nextBottom below:_bottom];
        [self insertSublayer:_nextTop atIndex:0];
        [self insertSublayer:_nextBottom atIndex:0];
        
        
        [self nextAnimationState];
    }
    
}

@end
