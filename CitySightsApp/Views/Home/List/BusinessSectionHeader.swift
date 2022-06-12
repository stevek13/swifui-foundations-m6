//
//  BusinessSectionHeader.swift
//  CitySightsApp
//
//  Created by Steve Kite on 6/11/22.
//

import SwiftUI

//
//  BusinessSectionHeader.swift
//  City Sights App
//
//  Created by Christopher Ching on 2021-04-16.
//

import SwiftUI

struct BusinessSectionHeader: View {
    
    var title: String
    
    var body: some View {
        
        ZStack (alignment: .leading) {
        
            Rectangle()
                .foregroundColor(.blue)
                
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}

struct BusinessSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSectionHeader(title: "Restaurants")
    }
}
