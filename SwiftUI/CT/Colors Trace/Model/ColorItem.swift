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
    let offset: CGPoint
    let size: CGSize = CGSize(width: ColorItem.size,
                              height: ColorItem.size)
}
