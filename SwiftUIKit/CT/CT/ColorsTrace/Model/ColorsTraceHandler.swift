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
    private var selectedColor: UIColor? {
        willSet {
            colorWasChangedCompletionHandler(newValue)
        }
    }
    private var colorWasChangedCompletionHandler: (UIColor?) -> ()
    
    init(canvas: UIView,
         colors: [UIButton],
         colorWasChanged: @escaping (UIColor?) -> ()) {
        self.canvas = canvas
        self.colors = colors
        self.colorWasChangedCompletionHandler = colorWasChanged
        
        self.addTapGestureRecognizerToCanvas()
    }
    
    private func addTapGestureRecognizerToCanvas() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addCircle(gesture:)))
        self.canvas.addGestureRecognizer(tap)
    }
    
    @objc
    private func addCircle(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.canvas)
        let size = 50.0
        let circle = UIView(frame: CGRect.init(x: location.x - size * 0.5, y: location.y - size * 0.5, width: size, height: size))
        circle.layer.cornerRadius = size * 0.5
        circle.backgroundColor = selectedColor
        self.canvas.addSubview(circle)
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
