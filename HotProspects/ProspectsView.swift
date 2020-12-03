//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Eric Liu on 12/3/20.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }

    var body: some View {
        NavigationView {
            Text("People: \(prospects.people.count)")
                .navigationBarTitle(title)
                .navigationBarItems(trailing: Button(action: {
                    let prospect = Prospect()
                    prospect.name = "Eric Liu"
                    prospect.emailAddress = "eric.liu@gmail.com"
                    self.prospects.people.append(prospect)
                }) {
                    Image(systemName: "qrcode.viewFinder")
                    Text("Scan")
                })
        }
        
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
