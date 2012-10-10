//
//  FlipClockImages.h
//  FlipClock
//
//  Created by Mateusz Matoszko on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FlipClockImages : NSObject

+ (FlipClockImages *)images;

@property (nonatomic, strong) NSMutableArray *fullTiles;
@property (nonatomic, strong) NSMutableArray *topTiles;
@property (nonatomic, strong) NSMutableArray *bottomTiles;

- (UIImage *)getTopImageWithNumber:(int)index;
- (UIImage *)getBottomImageWithNumber:(int)index;

+ (UIImage *)makeImageWithText:(NSString *)text andHeight:(int)height;
+ (UIImage *)viewToImage:(UIView *) view;
+ (NSArray *)splitImage:(UIImage *)image;

- (id)initWithTileHeight:(int)height;

@end
