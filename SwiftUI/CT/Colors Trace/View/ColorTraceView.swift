//
//  ColorTraceView.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import SwiftUI

struct ColorTraceView: View {
    @EnvironmentObject var model: ColorTraceViewModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    ColorCanvasView()
                    ColorItemsView(size: geometry.size.width / CGFloat(model.colors.count))
                    Divider()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if (model.isSelected) {
                            Circle()
                                .fill(Color(model.selectedColor!.type.name))
                                .frame(width: 32.0, height: 32.0)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ColorTraceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorTraceView()
                .previewDevice("iPhone 12 Pro")
                .environmentObject(ColorTraceViewModel())
            
            ColorTraceView()
                .previewDevice("iPhone 8")
                .environmentObject(ColorTraceViewModel())
        }
    }
}
