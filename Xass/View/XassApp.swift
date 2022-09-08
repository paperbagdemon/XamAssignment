//
//  XassApp.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import SwiftUI

@main
struct XassApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
