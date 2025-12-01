//
//  VWWWaterView.m
//  Water Waves
//
//  Created by ashwini langde on 06/10/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import "VWWWaterView.h"

@interface VWWWaterView ()
{
    UIColor *_currentWaterColor;
    
    
    float a;
    float b;
    
    BOOL jia;
}
@end


@implementation VWWWaterView
@synthesize currentLinePointY;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        a = 1.5;
        b = 0;
        jia = NO;
        
        _currentWaterColor = [UIColor colorWithRed:8/255.0f green:194/255.0f blue:230/255.0f alpha:1];
        
        //currentLinePointY = 270; //250;
        
        [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)animateWave
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    float y=currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    
    for(float x=0;x<=320;x++)
    {
        y= a * sin( x/180*M_PI + 4*b/M_PI ) * 5 + currentLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, 320, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, currentLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
}


@end
