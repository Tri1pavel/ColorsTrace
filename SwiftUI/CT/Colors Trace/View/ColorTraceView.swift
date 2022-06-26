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
            VStack(spacing: 0) {
                ColorCanvasView()
                ColorItemsView(size: geometry.size.width / CGFloat(model.items.count))
                Divider()
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
