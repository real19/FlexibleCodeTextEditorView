//
//  ViewController.swift
//  Test
//
//  Created by Suleman Imdad on 5/26/18.
//  Copyright © 2018 CodingAssignment. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var mainTextView: NSTextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupTextView()
    }
    
    func setupTextView(){
        mainTextView.font = NSFont(name: "Menlo", size: 12)
        
        // Do any additional setup after loading the view.
        mainTextView.startAddingLineNumbers()
        
        // add line spacing
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        
        let attributedString = NSAttributedString(string: codeString, attributes: [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font:NSFont(name: "Menlo", size: 12) ?? NSFont.systemFont(ofSize: 12)])
        
        mainTextView.textStorage?.setAttributedString(attributedString)
        
        mainTextView.textContainerInset = NSSize(width: 5, height: 5)
        
    }
    
    
    
    
}
