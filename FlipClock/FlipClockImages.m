//
//  FlipClockImages.m
//  FlipClock
//
//  Created by Mateusz Matoszko on 7/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define TILE_HEIGHT 100

#import "FlipClockImages.h"

@implementation FlipClockImages

@synthesize fullTiles = _fullTiles;
@synthesize topTiles = _topTiles;
@synthesize bottomTiles = _bottomTiles;

static FlipClockImages *_images;

+ (FlipClockImages *)images
{
    if (_images == nil) {
        _images = [[FlipClockImages alloc] initWithTileHeight:TILE_HEIGHT];
        NSLog(@"start");
    }

    return _images;
}

- (UIImage *)getTopImageWithNumber:(int)index
{
    return [_topTiles objectAtIndex:index];
}

- (UIImage *)getBottomImageWithNumber:(int)index
{
    return [_bottomTiles objectAtIndex:index];
}

- (id)initWithTileHeight:(int)height
{
    self = [super init];
    if (self) {
        self.fullTiles = [[NSMutableArray alloc] initWithCapacity:10];
        self.topTiles = [[NSMutableArray alloc] initWithCapacity:10];
        self.bottomTiles = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (int i = 0; i < 10; ++i) {
            UIImage *imageWannabe = [FlipClockImages makeImageWithText:[NSString stringWithFormat:@"%d", i] andHeight:height];
            [_fullTiles addObject:imageWannabe];
            
            NSArray *splitted = [FlipClockImages splitImage:imageWannabe];
            
            UIImage *top = [splitted objectAtIndex:0];
            [_topTiles addObject:top];
            
            UIImage *bottom = [splitted objectAtIndex:1];
            [_bottomTiles addObject:bottom];
        }
    }
    return self;
}


+ (UIImage *)viewToImage:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

+ (NSArray *)splitImage:(UIImage *)image
{
    CGSize size = CGSizeMake(image.size.width, image.size.height/2);
    
    UIGraphicsBeginImageContext(size);
    [image drawAtPoint:CGPointZero];
    UIImage *top = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(size);
    [image drawAtPoint:CGPointMake(CGPointZero.x, -image.size.height/2)];
    UIImage *bottom = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *result = [NSArray arrayWithObjects:top , bottom, nil];
    
    return result;
}

+ (UIImage *)makeImageWithText:(NSString *)text andHeight:(int)height
{
    int width = height/2;
    int lineSize = width/10;
    int cornerRadius = width/10;
    int fontSize = 160*height/200;
    
    
    UILabel *digitLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    digitLabel.font = [UIFont systemFontOfSize:fontSize];
    digitLabel.text = text;
    digitLabel.textAlignment = UITextAlignmentCenter;
    digitLabel.textColor = [UIColor whiteColor];
    digitLabel.backgroundColor = [UIColor clearColor];
    [digitLabel sizeToFit];
    
    UIView *viewWithText = [[UIView alloc] initWithFrame:CGRectZero];
    viewWithText.frame = CGRectMake(0.f, 0.f, width, height);
    viewWithText.layer.cornerRadius = cornerRadius;
    viewWithText.layer.masksToBounds = YES;
    viewWithText.backgroundColor = [UIColor blackColor];
    
    digitLabel.center = CGPointMake(viewWithText.bounds.size.width / 2, viewWithText.bounds.size.height / 2);
    [viewWithText addSubview:digitLabel];
    
    UIView *horizontalLine = [[UIView alloc] init];
    horizontalLine.backgroundColor = [UIColor blackColor];
    horizontalLine.frame = CGRectMake(0.f, 0.f, viewWithText.frame.size.width, lineSize);
    horizontalLine.center = digitLabel.center;
    
    [viewWithText addSubview:horizontalLine];
    
    UIImage *readyImage = [FlipClockImages viewToImage:viewWithText];
    
    return readyImage;
}

@end
