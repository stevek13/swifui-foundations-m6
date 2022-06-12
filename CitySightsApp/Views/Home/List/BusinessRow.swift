//
//  BusinessRow.swift
//  CitySightsApp
//
//  Created by Steve Kite on 6/11/22.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business: Business
    
    var body: some View {
        HStack {
            // Image
            let uiImage = UIImage(data: business.imageData ?? Data())
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .frame(width: 58, height: 58)
                .cornerRadius(5)
                .scaledToFit()
                
            // Name and distance
            VStack(alignment:.leading) {
                Text(business.name ?? "")
                    .bold()
                Text(String(format: "%.1f miles away", (business.distance ?? 0)/1609))
                    .font(.caption)
            }
            Spacer()
            
            // Star rating and number of reviews
            VStack(alignment:.leading) {
                Image("regular_\(business.rating ?? 0)")
                Text("\(business.reviewCount ?? 0) Reviews")
                    .font(.caption)
            }
            Divider()
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}
    
