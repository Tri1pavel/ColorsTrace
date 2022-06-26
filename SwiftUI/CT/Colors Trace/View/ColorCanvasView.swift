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
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color("background"))
                
                ForEach(model.items) { item in
                    Circle()
                        .fill(Color(item.color.name))
                        .frame(width: item.size.width, height: item.size.height)
                        .padding(.leading, item.offset.x)
                        .padding(.top, item.offset.y)
                }
            }
            .onTapGesture { location in
                model.wasTapped(at :location)
            }
            .clipped()
        }
    }
}

struct OnTap: ViewModifier {
    @State private var location: CGPoint = .zero
    let response: (CGPoint) -> Void
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                response(location)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded {
                        location = $0.location
                    }
            )
    }
}

extension View {
    func onTapGesture(_ handler: @escaping (CGPoint) -> Void) -> some View {
        self.modifier(OnTap(response: handler))
    }
}

struct ColorCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        ColorCanvasView()
            .environmentObject(ColorTraceViewModel())
    }
}
