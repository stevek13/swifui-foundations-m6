//
//  HomeView.swift
//  CitySightsApp
//
//  Created by Steve Kite on 5/14/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
                // Determine if we should show list or map
            if !isMapShowing {
                // show list
                VStack (alignment: .leading){
                    HStack {
                        Image(systemName: "location")
                        Text("San Francisco")
                        Spacer()
                        Text("Switch to map")
                    }
                    .padding([.leading,.trailing], 15)
                    Divider()
                    
                    BusinessList()
                }
            } else {
                // show map
            }
        }
        else {
            // Sill waiting for data so show spinner
            ProgressView()
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
