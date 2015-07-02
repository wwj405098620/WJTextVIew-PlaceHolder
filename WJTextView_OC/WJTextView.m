//
//  WJTextView.m
//  WJTextView
//
//  Created by fosung_newMac on 15/6/23.
//  Copyright (c) 2015年 fosung_newMac. All rights reserved.
//

#import "WJTextView.h"

@implementation WJTextView

{
    BOOL _editing;
}


-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editBegin) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editEnd) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if ((!_editing)&&self.placeHolder&&self.placeHolder.length>0&&![self hasText]) {
        [_placeHolder drawAtPoint:CGPointMake(5, 5) withAttributes:@{NSFontAttributeName:_fontOfPlaceHolder?_fontOfPlaceHolder:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    }
}

- (void)editBegin
{
    _editing = YES;
    [self setNeedsDisplay];
}
- (void)editEnd
{
    _editing = NO;
    [self setNeedsDisplay];
}
@end
