//
//  ViewController.m
//  FlipClock
//
//  Created by Mateusz Matoszko on 7/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "FlipClock.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGPoint originPoint = CGPointMake(10.f, 10.f);
    
    FlipClock *clock = [[FlipClock alloc] initWithTilePosition:originPoint andHeight:100];
    [self.view addSubview:clock];
    
    [clock setTimer:0 :3 :0];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
