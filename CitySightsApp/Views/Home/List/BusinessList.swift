//
//  BusinessList.swift
//  CitySightsApp
//
//  Created by Steve Kite on 5/15/22.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack (alignment: .leading, pinnedViews:[.sectionHeaders] ) {
                
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                    .padding([.leading, .trailing], 15)
                BusinessSection(title: "Sights", businesses: model.sights)
                    .padding([.leading, .trailing], 15)
                }
            }
        }
    }


struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
