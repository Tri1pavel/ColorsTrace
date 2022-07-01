//
//  ColorCanvasHandler.swift
//  CT
//
//  Created by Development on 01.07.2022.
//

import Foundation
import UIKit

/// An object that hold canvas for displaying selected color as rounded view by tap.
/// Handle tap gesture to add UIView on canvas.
/// Handle event when undo & redo stack of UIView's was changed.
///
/// - Parameters
///     - *canvas*: UIView for adding selected color view by user's tap.
///     - *wasChanged*: Completion handler event when undo & redo stack of UIView's was changed.
class ColorCanvasHandler {
    private var canvas: UIView
    private var wasChangedCompletionHandler: (Bool, Bool) -> ()
    
    private var selectedColor: UIColor?
    
    private var hash: [UIColor? : Int] = [:]
    private var undoStack = Stack<UIView>()
    private var redoStack = Stack<UIView>()
    
    private var isUndoEnabled: Bool {
        self.undoStack.isEmpty ? false : true
    }
    
    private var isRedoEnabled: Bool {
        self.redoStack.isEmpty ? false : true
    }
    
    init(canvas: UIView,
         wasChanged: @escaping (Bool, Bool) -> ()) {
        self.canvas = canvas
        self.wasChangedCompletionHandler = wasChanged
        
        self.addTapGestureRecognizerToCanvas()
    }
    
    private func addTapGestureRecognizerToCanvas() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addView(gesture:)))
        self.canvas.addGestureRecognizer(tap)
    }
    
    @objc
    private func addView(gesture: UITapGestureRecognizer) {
        guard let color = selectedColor else {
            return
        }
        // Get location on canvas
        let location = gesture.location(in: self.canvas)
        // Add view at location on canvas with specific color
        addView(at: location, color: color)
    }
    
    private func addView(at location: CGPoint, color: UIColor?) {
        let size = 50.0
        let view = UILabel(frame: CGRect.init(x: location.x - size * 0.5, y: location.y - size * 0.5, width: size, height: size))
        view.backgroundColor = color
        // Add rounded corners
        view.layer.cornerRadius = size * 0.5
        view.clipsToBounds = true
        // Set font
        view.font = UIFont.boldSystemFont(ofSize: 20)
        // Set text attributes
        view.textColor = .white
        view.textAlignment = .center
        // Update hash for added color
        let current = self.updateHash(color:view.backgroundColor, ascending: true)
        view.text = String(current)
        // Add to canvas
        self.canvas.addSubview(view)
        // Add view to "undo" stack
        self.undoStack.push(view)
        // Completion handler
        self.wasChangedCompletionHandler(isUndoEnabled, isRedoEnabled)
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

extension ColorCanvasHandler {
        
    func colorWasChanged(_ color: UIColor?) {
        self.selectedColor = color
    }
    
    func undo() {
        guard let view = self.undoStack.pop() else {
            return
        }
        // Update hash for removed color
        self.updateHash(color: view.backgroundColor, ascending: false)
        // Remove view from canvas
        view.removeFromSuperview()
        // Add view to "redo" stack
        redoStack.push(view)
        // Completion handler
        self.wasChangedCompletionHandler(isUndoEnabled, isRedoEnabled)
    }
    
    func redo() {
        guard let view = self.redoStack.pop() else {
            return
        }
        // Get location from restored view on canvas
        let location = CGPoint(x: view.frame.origin.x + view.frame.width * 0.5,
                               y: view.frame.origin.y + view.frame.height * 0.5)
        // Add restored view at location on canvas with specific color
        addView(at: location, color: view.backgroundColor)
    }
    
}

