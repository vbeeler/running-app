//
//  RunningAppApp.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/28/22.
//

import SwiftUI
import Firebase

@main
struct RunningApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
