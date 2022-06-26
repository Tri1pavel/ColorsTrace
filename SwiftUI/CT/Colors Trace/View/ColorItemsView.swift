//
//  ColorItemsView.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import SwiftUI

struct ColorItemsView: View {
    @EnvironmentObject var model: ColorTraceViewModel
    let size: CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(model.colors) { color in
                Button {
                    model.colorWasChanged(for: color)
                } label: {
                    Rectangle()
                        .fill(Color(color.type.name))
                        .frame(width: size, height: size)
                        .overlay {
                            if color.isSelected {
                                Color(white: 0, opacity: 0.25)
                            }
                        }
                }
            }
        }
    }
    
}

struct ColorItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorItemsView(size: 390.0 / 4.0)
            .previewLayout(.sizeThatFits)
            .environmentObject(ColorTraceViewModel())
    }
}
