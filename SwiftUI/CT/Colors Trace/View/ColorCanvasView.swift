//
//  ColorCanvasView.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import SwiftUI

struct ColorCanvasView: View {
    @EnvironmentObject var model: ColorTraceViewModel
    
    var body: some View {
        Rectangle()
            .fill(Color("background"))
    }
}

struct ColorCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCanvasView()
            .environmentObject(ColorTraceViewModel())
    }
}
