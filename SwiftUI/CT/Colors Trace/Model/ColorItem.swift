//
//  ColorItem.swift
//  CT
//
//  Created by Development on 26.06.2022.
//

import Foundation
import CoreGraphics

struct ColorItem: Identifiable {
    static let size: CGFloat = 50.0
    
    let id = UUID()
    let color: ColorButtonItemType
    let number: Int
    let offset: CGPoint
    let size: CGSize
    
    init(color: ColorButtonItemType,
         number: Int,
         offset: CGPoint,
         size: CGSize = CGSize(width: ColorItem.size,
                               height: ColorItem.size)
    ) {
        self.color = color
        self.number = number
        self.offset = offset
        self.size = size
    }
}
