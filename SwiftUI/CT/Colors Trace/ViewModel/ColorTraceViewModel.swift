//
//  ColorTraceViewModel.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import Foundation

class ColorTraceViewModel: ObservableObject {
    
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
    
}
