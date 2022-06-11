//
//  LaunchView.swift
//  CitySightsApp
//
//  Created by Steve Kite on 5/12/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    var body: some View {
        
        // Detect the authorization status of gelocating the user
        
        if model.authorizationState == .notDetermined {
            // if undetermined, show onboarding
            
        }
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            // if approved, show home view
            HomeView()
        }
        else {
            // if denied, show denied view
        }
        
       
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
