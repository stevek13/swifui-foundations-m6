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
        ScrollView {
            LazyVStack {

                ForEach(model.restaurants) { business in
                    Text(business.name ?? "")
                    Divider()
                }
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
