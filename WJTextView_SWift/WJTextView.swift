//
//  WJTextView.swift
//  WJTextView_SWift
//
//  Created by WenJie on 15/7/2.
//  Copyright (c) 2015年 fosung_newMac. All rights reserved.
//

import UIKit

class WJTextView: UITextView {
    private var _editing:Bool! = false
    internal var fontOfPlaceHolder:UIFont! = UIFont.systemFontOfSize(10);
    internal var placeHolder:String!=""{
        didSet{
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "editBegin", name: UITextViewTextDidBeginEditingNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "editEnd", name: UITextViewTextDidEndEditingNotification, object: nil)
        }
    }
     override func drawRect(rect: CGRect) {
        if !_editing&&(!self.placeHolder.isEmpty)&&(!self.hasText()) {
            var fdPlaceHolder:NSString = placeHolder
            fdPlaceHolder.drawAtPoint(CGPointMake(5, 5), withAttributes: [NSFontAttributeName:fontOfPlaceHolder,NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        }
    }
    func editBegin(){
        _editing = true
        setNeedsDisplay()
    }
    func editEnd(){
        _editing = false
        setNeedsDisplay()
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
}
