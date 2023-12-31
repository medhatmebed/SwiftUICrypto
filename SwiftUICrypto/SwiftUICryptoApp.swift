//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 12/30/23.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
