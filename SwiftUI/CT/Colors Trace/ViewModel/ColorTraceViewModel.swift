//
//  ColorTraceViewModel.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import Foundation

class ColorTraceViewModel: ObservableObject {
    
    @Published
    private(set) var items: [ColorItem] = [
        ColorItem(type: .orange),
        ColorItem(type: .green),
        ColorItem(type: .blue),
        ColorItem(type: .red)
    ]
    
    var selectedItem: ColorItem? {
        items.filter {$0.isSelected == true}.first
    }
    
    var isSelected: Bool {
        selectedItem == nil ? false : true
    }
        
    private func deselectAll() {
        items.indices.forEach {items[$0].isSelected = false}
    }

    private func index(for item: ColorItem) -> Int? {
        guard let index = (items.firstIndex {$0.id == item.id}) else {
            return nil
        }
        return index
    }
    
}

extension ColorTraceViewModel {
    
    func colorWasChanged(for item: ColorItem) {
        guard let index = index(for: item) else {
            return
        }
        guard !items[index].isSelected else {
            // Deselect item that previously was selected
            items[index].wasSelected()
            return
        }
        // Deselect all items
        deselectAll()
        // Select the item that was tapped
        items[index].wasSelected()
    }
    
}
