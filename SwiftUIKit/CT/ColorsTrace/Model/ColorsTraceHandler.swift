//
//  ColorsTraceHandler.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import Foundation
import UIKit

/// An object that manages trace of selected color by switching beetwen color buttons.
/// Handle tap gesture to add *UIView* on canvas.
/// Handle event when color was changed.
/// Handle event when undo stack of *UIView* was changed.
/// Handle event when redo stack of *UIView* was changed.
///
/// - **Parameter**
///     - **canvas**: *UIView* for adding selected color view by tap
///     - **colors**: *[UIButton]* for switch beetwen colors. Color = *UIButton.backgroundColor*
///     - colorWasChangedCompletionHandler: Completion handler event when color was changed
///     - undoWasChangedCompletionHandler: Completion handler event when undo stack was changed
///     - redoWasChangedCompletionHandler: Completion handler event when redo stack was changed

class ColorsTraceHandler {
    private var canvas: UIView
    private var colors: [UIButton]
    private var colorWasChangedCompletionHandler: (UIColor?) -> ()
    private var undoWasChangedCompletionHandler: (Bool) -> ()
    private var redoWasChangedCompletionHandler: (Bool) -> ()
    
    private var selectedColor: UIColor? {
        willSet {
            self.colorWasChangedCompletionHandler(newValue)
        }
    }
    private var hash: [UIColor? : Int] = [:]
    private var undoStack = Stack<UIView>()
    private var redoStack = Stack<UIView>()
    

    init(canvas: UIView,
         colors: [UIButton],
         colorWasChanged: @escaping (UIColor?) -> (),
         undoWasChanged: @escaping (Bool) -> (),
         redoWasChanged: @escaping (Bool) -> ()) {
        self.canvas = canvas
        self.colors = colors
        self.colorWasChangedCompletionHandler = colorWasChanged
        self.undoWasChangedCompletionHandler = undoWasChanged
        self.redoWasChangedCompletionHandler = redoWasChanged
        
        self.addTapGestureRecognizerToCanvas()
    }
    
    private func addTapGestureRecognizerToCanvas() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addView(gesture:)))
        self.canvas.addGestureRecognizer(tap)
    }
    
    @objc
    private func addView(gesture: UITapGestureRecognizer) {
        guard let color = selectedColor else { return }
        // Get location on canvas
        let location = gesture.location(in: self.canvas)
        addView(at: location, color: color)
    }
    
    private func addView(at location: CGPoint, color: UIColor?) {
        let size = 50.0
        let view = UILabel(frame: CGRect.init(x: location.x - size * 0.5, y: location.y - size * 0.5, width: size, height: size))
        view.backgroundColor = color
        // Update hash for added color
        let current = self.updateHash(color:view.backgroundColor,
                                      ascending: true)
        // Add rounded corners
        view.layer.cornerRadius = size * 0.5
        view.clipsToBounds = true
        // Set text attributes
        view.textColor = .white
        view.textAlignment = .center
        view.text = current == 0 ? "" : String(current)
        // Set font
        view.font = UIFont.boldSystemFont(ofSize: 20)
        // Add to canvas
        self.canvas.addSubview(view)
        // Add view to "undo" stack
        self.undoStack.push(view)
        // Undo completion handler
        let isEnabled = self.undoStack.items.isEmpty ? false : true
        self.undoWasChangedCompletionHandler(isEnabled)
    }
    
    @discardableResult
    private func updateHash(color: UIColor?, ascending: Bool) -> Int {
        var current = hash[color] ?? 0
        current = ascending ?
                    current + 1 :
                    max(0, current - 1)
        hash[color] = current
        return current
    }
    
}

extension ColorsTraceHandler {
    
    func colorWasChanged(_ sender: UIButton) {
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
    
    func undo() {
        guard let view = self.undoStack.pop() else {
            return
        }
        // Update hash for removed color
        self.updateHash(color: view.backgroundColor,
                        ascending: false)
        // Remove view from canvas
        view.removeFromSuperview()
        // Undo completion handler
        let isUndoEnabled = self.undoStack.items.isEmpty ? false : true
        self.undoWasChangedCompletionHandler(isUndoEnabled)
        // Add view to "redo" stack
        redoStack.push(view)
        // Redo completion handler
        let isRedoEnabled = self.redoStack.items.isEmpty ? false : true
        self.redoWasChangedCompletionHandler(isRedoEnabled)
    }
    
    func redo() {
        guard let view = self.redoStack.pop() else {
            return
        }
        // Get location from restored view on canvas
        let location = CGPoint(x: view.frame.origin.x + view.frame.width * 0.5,
                               y: view.frame.origin.y + view.frame.height * 0.5)
        // Add restored view to canvas
        addView(at: location, color: view.backgroundColor)
        // Redo completion handler
        let isRedoEnabled = self.redoStack.items.isEmpty ? false : true
        self.redoWasChangedCompletionHandler(isRedoEnabled)
    }
    
}
