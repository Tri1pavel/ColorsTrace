//
//  ColorSelectionHandler.swift
//  CT
//
//  Created by Development on 01.07.2022.
//

import Foundation
import UIKit

/// An object that track selected color.
/// Handle event when selected color was changed.
///
/// - Parameters
///     - *colors*: [UIButtons] representing available colors for selection.
///     - *wasChanged*: Completion handler event when selected color was changed.
class ColorSelectionHandler {
    private var colors: [UIButton]
    private var colorWasChangedCompletionHandler: (UIColor?) -> ()
    
    private var selectedColor: UIColor? {
        willSet {
            self.colorWasChangedCompletionHandler(newValue)
        }
    }
    
    init(colors: [UIButton],
         colorWasChanged: @escaping (UIColor?) -> ()) {
        self.colors = colors
        self.colorWasChangedCompletionHandler = colorWasChanged
    }
}

extension ColorSelectionHandler {
    
    func wasChanged(_ sender: UIButton) {
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
