//
//  MapNode.m
//  Glimmer
//
//  Created by MikeRiy on 15/11/12.
//  Copyright © 2015年 MikeRiy. All rights reserved.
//

#import "MapNode.h"

@implementation MapNode

@synthesize x;
@synthesize y;
@synthesize isOpen;
@synthesize name;
@synthesize path;

-(instancetype)initWithCross:(NSInteger)mx vertical:(NSInteger)my
{
    if(self = [super init]){
        self.x = mx;
        self.y = my;
        self.name = [NSString stringWithFormat:@"%li_%li", mx, my];
    }
    return self;
}

-(UIView*)image:(UIView*)parent
{
    if(!_view){
        //NSLog(self.path);
        _view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.path]];
        [_view.layer setAnchorPoint:CGPointMake(0, 0)];
        [parent addSubview:_view];
    }
    return _view;
}

-(void)close
{
    self.isOpen = NO;
    if(_view)
    {
        [_view removeFromSuperview];
        _view = nil;
    }
}

-(void)dealloc
{
    [self close];
}

@end
