

#import "WJTextView.h"

@implementation WJTextView

{
    BOOL _editing;
    BOOL _hasText;
}


-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editBegin) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editEnd) name:UITextViewTextDidEndEditingNotification object:nil];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    _hasText = self.text&&self.text.length>0;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if ((!_editing)&&self.placeHolder&&self.placeHolder.length>0&&!_hasText) {
        [_placeHolder drawAtPoint:CGPointMake(5, 5) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
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
    _hasText = self.text&&self.text.length>0;
    [self setNeedsDisplay];
}
@end
