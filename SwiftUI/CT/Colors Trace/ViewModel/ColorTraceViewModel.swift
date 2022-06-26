//
//  ColorTraceViewModel.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import Foundation
import CoreGraphics

class ColorTraceViewModel: ObservableObject {
    
    @Published
    private(set) var items: [ColorItem] = []
    
    @Published
    private(set) var colors: [ColorButtonItem] = [
        ColorButtonItem(type: .orange),
        ColorButtonItem(type: .green),
        ColorButtonItem(type: .blue),
        ColorButtonItem(type: .red)
    ]
    
    @Published
    private(set) var undoStack: Stack = Stack<ColorItem>()
    
    @Published
    private(set) var redoStack: Stack = Stack<ColorItem>()
    
    // *** colors variables
    var selectedColor: ColorButtonItem? {
        colors.filter {$0.isSelected == true}.first
    }
    
    var isSelected: Bool {
        selectedColor == nil ? false : true
    }
        
    // *** colors methods
    private func deselectAll() {
        colors.indices.forEach {colors[$0].isSelected = false}
    }

    private func index(for color: ColorButtonItem) -> Int? {
        guard let index = (colors.firstIndex {$0.id == color.id}) else {
            return nil
        }
        return index
    }
    
    // *** items methods
    private func addItem(_ item: ColorItem) {
        items.append(item)
    }
    
    private func removeLastItem() {
        items.removeLast()
    }
    
    private func getItemNumber(for color: ColorButtonItemType) -> Int {
        items.filter {$0.color == color}.count + 1
    }
}

extension ColorTraceViewModel {
    
    func colorButtonWasTapped(for color: ColorButtonItem) {
        guard let index = index(for: color) else {
            return
        }
        guard !colors[index].isSelected else {
            // Deselect item that previously was selected
            colors[index].wasSelected()
            return
        }
        // Deselect all items
        deselectAll()
        // Select the item that was tapped
        colors[index].wasSelected()
    }
    
    func colorCanvasWasTapped(at location: CGPoint) {
        guard let selectedColor = self.selectedColor else { return }

        let offset = CGPoint(x: location.x - ColorItem.size * 0.5,
                             y: location.y - ColorItem.size * 0.5)
        let color = selectedColor.type
        let number = getItemNumber(for: color)
        let item = ColorItem(color: color,
                             number: number,
                             offset: offset)
        self.addItem(item)
        
        self.undoStack.push(item)
    }
    
    func undoButtonWasTapped() {
        guard let item = self.undoStack.pop() else {
            return
        }
        
        self.redoStack.push(item)
        
        self.removeLastItem()
    }
    
    func redoButtonWasTapped() {
        guard let popped = self.redoStack.pop() else {
            return
        }

        let offset = CGPoint(x: popped.offset.x,
                             y: popped.offset.y)
        let color = popped.color
        let number = getItemNumber(for: color)
        let item = ColorItem(color: color,
                             number: number,
                             offset: offset)
        self.addItem(item)
        
        self.undoStack.push(item)
    }
    
}
