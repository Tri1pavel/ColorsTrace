//
//  ColorButtonItem.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import Foundation

struct ColorButtonItem: Identifiable {
    let id = UUID()
    let type: ColorButtonItemType
    var isSelected: Bool = false
    
    mutating func wasSelected() {
        isSelected = !isSelected
    }
}

enum ColorButtonItemType : String {
    case orange, green, blue, red

    var name: String {
        self.rawValue + "Color"
    }
}
