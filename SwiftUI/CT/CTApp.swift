//
//  CTApp.swift
//  CT
//
//  Created by Development on 25.06.2022.
//

import SwiftUI

@main
struct CTApp: App {
    @StateObject var model = ColorTraceViewModel()
    var body: some Scene {
        WindowGroup {
            ColorTraceView()
                .environmentObject(model)
        }
    }
}
