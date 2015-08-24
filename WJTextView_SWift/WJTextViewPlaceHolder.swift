//  ver 1.2
//  更新内容:本次更新重新设计了实现方式：以前的实现为继承，这次改为类别实现，使依赖关系更轻量级，由于不继承原生控件类，将会加大扩展性和维护性。
//  Created by WenJie on 15/8/21.
//  Copyright (c) 2015年 fosung_newMac. All rights reserved.
//


import Foundation
import UIKit

var WJPlaceHolderTextViewKey = 0

extension UITextView {


    /**
    *  设置提示语的字体,默认为[UIFont systemFontOfSize:13]
    */
    var placeHolderFont:UIFont?{
        set{
            self.placeHolderTextView.font = newValue
        }
        get{
            return self.placeHolderTextView.font
        }
    }
    
    /**
    *  设置提示语的字体颜色,默认为[UIColor lightGrayColor]
    */
    var placeHolderColor:UIColor?{
        set{
            self.placeHolderTextView.textColor = newValue
        }
        get{
            return self.placeHolderTextView.textColor
        }
    }
    
    /**
    *  设置提示语
    */
    var placeHolder:String?{
        set{
            self.placeHolderTextView.text = newValue
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "controlPlaceHolder", name: UITextViewTextDidBeginEditingNotification, object: self)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "controlPlaceHolder", name: UITextViewTextDidEndEditingNotification, object: self)
            self.controlPlaceHolder()
        }
        get{
            return self.placeHolderTextView.text
        }
    }
    
    
    // 控制PlaceHolder的显示隐藏
     func controlPlaceHolder(){
        var ifHiddenPlaceHolder = self.isFirstResponder()||self.placeHolder==nil||self.placeHolder?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)==0||self.hasText()
        self.placeHolderTextView.hidden = ifHiddenPlaceHolder
    }
    
    
    //利用runtime的associate机制动态添加set&get方法
    //使用UITextview而不用UILabel,是为了有效利用UITextView的自动换行和顶端对齐特性,减少代码量
    private var placeHolderTextView:UITextView {
        set{
            objc_setAssociatedObject(self, &WJPlaceHolderTextViewKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
        get{
            if objc_getAssociatedObject(self, &WJPlaceHolderTextViewKey)==nil {
                var textView = UITextView()
                textView.backgroundColor = UIColor.clearColor()
                textView.userInteractionEnabled = false
                textView.font = UIFont.systemFontOfSize(13)
                textView.textColor = UIColor.lightGrayColor()
                textView.setTranslatesAutoresizingMaskIntoConstraints(false)
                self.addSubview(textView)
                self.addConstraints([
                    NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: textView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0),
                    
                    NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: textView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0),
                    
                    NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: textView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0),
                    
                    NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: textView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0),
                    ])
                self.placeHolderTextView = textView
            }
            return objc_getAssociatedObject(self, &WJPlaceHolderTextViewKey) as! UITextView
        }
    }
 

}