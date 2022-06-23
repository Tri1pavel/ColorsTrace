//
//  ColorsTraceHandler.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import Foundation
import UIKit

struct ColorsTraceHandler {
    private var colors: [UIButton]
    private var selectedColor: UIColor? {
        willSet {
            colorWasChangedCompletionHandler(newValue)
        }
    }
    private var colorWasChangedCompletionHandler: (UIColor?) -> ()
    
    init(colors: [UIButton],
         colorWasChanged: @escaping (UIColor?) -> ()) {
        self.colors = colors
        self.colorWasChangedCompletionHandler = colorWasChanged
    }
    
    mutating func colorWasChanged(_ sender: UIButton) {
        defer {
            selectedColor = sender.isSelected ? sender.backgroundColor : nil
        }
        
        guard !sender.isSelected else {
            // Deselect button that previously was selected
            sender.isSelected.toggle()
            return
        }
        
        // Deselect all buttons
        colors.forEach { $0.isSelected = false }
        // Select the button that was tapped
        sender.isSelected.toggle()
    }
    
}
