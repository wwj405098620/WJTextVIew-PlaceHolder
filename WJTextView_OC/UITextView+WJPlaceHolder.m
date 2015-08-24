
#import "UITextView+WJPlaceHolder.h"
#import <objc/runtime.h>

static const char *PlaceHolderTextViewKey = "PlaceholderTextViewKey";

@implementation UITextView (WJPlaceHolder)


// 控制PlaceHolder的显示隐藏
- (void)controlPlaceHolder{
    // 当textview在编辑状态、未设置提示语或已有text时隐藏提示语
    BOOL ifHiddenPlaceHolder = [self isFirstResponder]||!self.placeHolder||self.placeHolder.length<=0||[self hasText];
    self.placeHolderTextView.hidden = ifHiddenPlaceHolder;
}

#pragma mark GET SET
//color font等属性为计算属性的情况下,他们的值被placeHolderTextView强引用,self不需要拥有,内存管理上设置为weak
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    self.placeHolderTextView.textColor = placeHolderColor;
}
-(UIColor *)placeHolderColor
{
    return self.placeHolderTextView.textColor;
}
-(UIFont *)placeHolderFont
{
    return self.placeHolderTextView.font;
}
-(void)setPlaceHolderFont:(UIFont *)placeHolderFont
{
    self.placeHolderTextView.font = placeHolderFont;
}
- (NSString *)placeHolder
{
    return self.placeHolderTextView.text;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    self.placeHolderTextView.text = placeHolder;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(controlPlaceHolder) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlPlaceHolder) name:UITextViewTextDidEndEditingNotification object:self];
    [self controlPlaceHolder];
}


#pragma mark 私有Property
//利用runtime的associate机制动态添加set&get方法

//使用UITextview而不用UILabel,是为了有效利用UITextView的自动换行和顶端对齐特性,减少代码量
-(void)setPlaceHolderTextView:(UITextView *)placeHolderTextView
{
    objc_setAssociatedObject(self, PlaceHolderTextViewKey, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(UITextView *)placeHolderTextView
{
    if (!objc_getAssociatedObject(self, PlaceHolderTextViewKey)) {
        UITextView *textView = [[UITextView alloc]init];
        textView.backgroundColor = [UIColor clearColor];
        textView.userInteractionEnabled = NO;
        textView.font = [UIFont systemFontOfSize:13];
        textView.textColor = [UIColor lightGrayColor];
        textView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:textView];
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:textView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:textView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0],
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:textView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0]
                               ]];
        [self setPlaceHolderTextView:textView];
        }
    return objc_getAssociatedObject(self, PlaceHolderTextViewKey);
}

@end
