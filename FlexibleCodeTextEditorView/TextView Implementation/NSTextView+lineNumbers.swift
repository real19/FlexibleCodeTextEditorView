//
//  NSTextView+lineNumbers.swift
//  Test
//
//  Created by Suleman Imdad on 5/26/18.
//  Copyright © 2018 CodingAssignment. All rights reserved.
//

import Foundation
import AppKit

// create an extension that associates a custom rulerview on textView
extension NSTextView {
    
    var lineNumberRulerView:LineNumberRulerView {
        get {
            return objc_getAssociatedObject(self, &LineNumberRulerViewAssociatedObjectKey) as! LineNumberRulerView
        }
        set {
            objc_setAssociatedObject(self, &LineNumberRulerViewAssociatedObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func startAddingLineNumbers() {
        
        //enable frame change notifications on TextView
        postsFrameChangedNotifications = true
        
        //add Observer for notifications on TextView
        NotificationCenter.default.addObserver(self, selector: #selector(onFramesDidChange), name: NSView.frameDidChangeNotification, object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onTextDidChange), name: NSText.didChangeNotification, object: self)
        
        if let scrollView = enclosingScrollView {
            lineNumberRulerView = LineNumberRulerView(textView: self)
            scrollView.verticalRulerView = lineNumberRulerView
            scrollView.hasVerticalRuler = true
            scrollView.rulersVisible = true
        }
    }
    
    // This event is triggered when the frames change such as when the window sizes
    @objc func onFramesDidChange(notification: NSNotification) {
        //refresh the Rulerview
        lineNumberRulerView.needsDisplay = true
    }
    // This event is triggered anytime we change the text inside the textView
    @objc func onTextDidChange(notification: NSNotification) {
        //refresh the Rulerview
        lineNumberRulerView.needsDisplay = true
    }
}

