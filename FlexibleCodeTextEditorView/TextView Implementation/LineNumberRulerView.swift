//
//  LineNumberRulerView.swift
//  Test
//
//  Created by Suleman Imdad on 5/26/18.
//  Copyright © 2018 CodingAssignment. All rights reserved.
//

import AppKit
import Foundation

var LineNumberRulerViewAssociatedObjectKey: UInt8 = 0

class LineNumberRulerView: NSRulerView {
    
    var font: NSFont! {
        didSet {
            //Refresh if the font is changed
            self.needsDisplay = true
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(textView: NSTextView) {
        super.init(scrollView: textView.enclosingScrollView!, orientation: NSRulerView.Orientation.verticalRuler)
        self.clientView = textView
        self.ruleThickness = 30
    }
    
    // override drawHashMarksAndLabels to build the line numbers
    override func drawHashMarksAndLabels(in rect: NSRect) {
        
        //Set background color to white
        NSColor.white.set()
        __NSRectFill(bounds)
        
        
        //Start adding Line Numbers
        if let clientTextView = self.clientView as? NSTextView {
            
            if let layoutManager = clientTextView.layoutManager {
                
                let relativePoint = self.convert(NSZeroPoint, from: clientTextView)
                
                let lineNumberAttributes = [.font: clientTextView.font!,
                                            .foregroundColor: NSColor.lightGray] as [NSAttributedStringKey : Any]
                
                let drawLineNumber = { (lineNumberString:String, y:CGFloat) -> Void in
                    let attributedString = NSAttributedString(string: lineNumberString, attributes: lineNumberAttributes)
                    let xCoordinate:CGFloat = 10.0
                    attributedString.draw(at: NSPoint(x: xCoordinate, y: relativePoint.y + y))
                }
                
                // 'G' or 'g' here denotes "GLYPH"

                let visibleGRange = layoutManager.glyphRange(forBoundingRect: clientTextView.visibleRect, in: clientTextView.textContainer!)
                
                let firstVisibleGCharacterIndex = layoutManager.characterIndexForGlyph(at: visibleGRange.location)
                
                let regexForNewLineCharacter = try! NSRegularExpression(pattern: "\n", options: [])
                
                //  Get the line number for the first visible line
                var lineNumber = regexForNewLineCharacter.numberOfMatches(in: clientTextView.string, options: [], range: NSMakeRange(0, firstVisibleGCharacterIndex)) + 1
                
                var gIndexForStringLine = visibleGRange.location
                
                // Loop through every line of text
                while gIndexForStringLine < NSMaxRange(visibleGRange) {
                    
                    // get the range of existing line of text
                    let characterRangeForStringLine = (clientTextView.string as NSString).lineRange(
                        for: NSMakeRange( layoutManager.characterIndexForGlyph(at: gIndexForStringLine), 0 )
                    )
                    let gRangeForStringLine = layoutManager.glyphRange(forCharacterRange: characterRangeForStringLine, actualCharacterRange: nil)
                    
                    var gIndexForGLine = gIndexForStringLine
                    
                    var gLineCount = 0
                    
                    while ( gIndexForGLine < NSMaxRange(gRangeForStringLine) ) {
                        
                        // See if the current line in the string spread across several lines of glyphs
                        var effectiveRange = NSMakeRange(0, 0)
                        
                        // Check the range of current "line of glyphs"...
                        // so if line is wrapped, that means that it would have more than one line of glyphs
                        let lineNumberRect = layoutManager.lineFragmentRect(forGlyphAt: gIndexForGLine, effectiveRange: &effectiveRange, withoutAdditionalLayout: true)
                        
                        if !(gLineCount > 0) {
                            drawLineNumber("\(lineNumber)", lineNumberRect.minY)
                        }
                        // Go to the next Glyph
                        gLineCount += 1
                        
                        gIndexForGLine = NSMaxRange(effectiveRange)
                    }
                    
                    gIndexForStringLine = NSMaxRange(gRangeForStringLine)
                    
                    lineNumber += 1
                }
                
                // Draw an additional line at the end of the text
                if layoutManager.extraLineFragmentTextContainer != nil {
                    drawLineNumber("\(lineNumber)", layoutManager.extraLineFragmentRect.minY)
                }
            }
        }
    }
}

