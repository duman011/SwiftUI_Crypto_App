//
//  SwiftUI_Crypto_AppApp.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 26.12.2023.
//

import SwiftUI

@main
struct SwiftUI_Crypto_AppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
