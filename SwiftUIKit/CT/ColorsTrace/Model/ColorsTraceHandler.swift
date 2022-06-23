//
//  ColorsTraceHandler.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import Foundation
import UIKit

class ColorsTraceHandler {
    private var canvas: UIView
    private var colors: [UIButton]
    private var colorWasChangedCompletionHandler: (UIColor?) -> ()
    
    private var selectedColor: UIColor? {
        willSet {
            colorWasChangedCompletionHandler(newValue)
        }
    }
    private var hash: [UIColor? : Int] = [:]
    
    init(canvas: UIView,
         colors: [UIButton],
         colorWasChanged: @escaping (UIColor?) -> ()) {
        self.canvas = canvas
        self.colors = colors
        self.colorWasChangedCompletionHandler = colorWasChanged
        
        self.addTapGestureRecognizerToCanvas()
    }
    
    private func addTapGestureRecognizerToCanvas() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addView(gesture:)))
        self.canvas.addGestureRecognizer(tap)
    }
    
    @objc
    private func addView(gesture: UITapGestureRecognizer) {
        guard selectedColor != nil  else { return }
        // Update hash for selected color
        let current = self.updateHash(ascending: true)
        // Get location on canvas
        let location = gesture.location(in: self.canvas)
        let size = 50.0
        let view = UILabel(frame: CGRect.init(x: location.x - size * 0.5, y: location.y - size * 0.5, width: size, height: size))
        view.backgroundColor = selectedColor
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
    }
    
    @discardableResult
    private func updateHash(ascending: Bool) -> Int {
        var current = hash[selectedColor] ?? 0
        current = ascending ?
                    current + 1 :
                    max(0, current - 1)
        hash[selectedColor] = current
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
    
}
