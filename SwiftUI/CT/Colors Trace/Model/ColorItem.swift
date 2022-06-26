//
//  ColorItem.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import Foundation

struct ColorItem: Identifiable {
    let id = UUID()
    let type: ColorItemType
    var isSelected: Bool = false
    
    mutating func wasSelected() {
        isSelected = !isSelected
    }
}

enum ColorItemType : String {
    case orange, green, blue, red

    var name: String {
        self.rawValue + "Color"
    }
}
