//
//  SectionHeaderViee.swift
//  Github Profile
//
//  Created by Arosha Piyadigama on 6/23/21.
//

import SwiftUI

struct SectionHeaderView: View {
    
    var sectionHeader: String
    var viewAll = "View all"
    
    var body: some View {
        HStack {
            Text(sectionHeader)
                .font(.title2)
                .fontWeight(.bold)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Text(viewAll)
                .underline()
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(sectionHeader: "")
    }
}
