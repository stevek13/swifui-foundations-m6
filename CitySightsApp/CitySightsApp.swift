//
//  CitySightsApp.swift
//  CitySightsApp
//
//  Created by Steve Kite on 5/12/22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
