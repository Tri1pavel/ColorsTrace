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
    private(set) var items: [ColorItem] = [
        ColorItem(color: .red, offset: CGPoint(x: 10.0, y: 20.0)),
        ColorItem(color: .green, offset: CGPoint(x: 100.0, y: 60.0)),
        ColorItem(color: .orange, offset: CGPoint(x: 150.0, y: 200.0)),
        ColorItem(color: .blue, offset: CGPoint(x: 70.0, y: 120.0))
    ]
    
    @Published
    private(set) var colors: [ColorButtonItem] = [
        ColorButtonItem(type: .orange),
        ColorButtonItem(type: .green),
        ColorButtonItem(type: .blue),
        ColorButtonItem(type: .red)
    ]
    
    var selectedColor: ColorButtonItem? {
        colors.filter {$0.isSelected == true}.first
    }
    
    var isSelected: Bool {
        selectedColor == nil ? false : true
    }
    
    private func addItem(_ item: ColorItem) {
        items.append(item)
    }
    
    private func deselectAll() {
        colors.indices.forEach {colors[$0].isSelected = false}
    }

    private func index(for color: ColorButtonItem) -> Int? {
        guard let index = (colors.firstIndex {$0.id == color.id}) else {
            return nil
        }
        return index
    }
    
}

extension ColorTraceViewModel {
    
    func colorWasChanged(for color: ColorButtonItem) {
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
    
    func wasTapped(at location: CGPoint) {
        guard let selectedColor = self.selectedColor else { return }
        
        let offset = CGPoint(x: location.x - ColorItem.size * 0.5,
                             y: location.y - ColorItem.size * 0.5)
        let item = ColorItem(color: selectedColor.type, offset: offset)
        self.addItem(item)
    }
    
}
