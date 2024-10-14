//
//  ContentView.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 29.09.2024.
//

import SwiftUI
import CoreLayer

struct ContentView: View {
    enum ControlTag: Int {
        case worldNewsTag = 0, nationNewsTag, businessNewsTag
    }
    
    @State var selection: ControlTag = .worldNewsTag

    var body: some View {
        
        Picker(selection: $selection, label: Text("")) {
            Text("World news").tag(ControlTag.worldNewsTag)
            Text("Nation news").tag(ControlTag.nationNewsTag)
            Text("Business news").tag(ControlTag.businessNewsTag)
        }
        .pickerStyle(.segmented)
        
        
        switch selection {
        case .worldNewsTag:
            ViewFactory.getGnewsListView(serviceLocator: ServiceLocator.shared, category: DefaultAPI.Category_topHeadlinesGet.world)
        case .nationNewsTag:
            ViewFactory.getGnewsListView(serviceLocator: ServiceLocator.shared, category: DefaultAPI.Category_topHeadlinesGet.nation)
        case .businessNewsTag:
            ViewFactory.getGnewsListView(serviceLocator: ServiceLocator.shared, category: DefaultAPI.Category_topHeadlinesGet.business)
        }
    }
    
    init() {
        ServiceLocator.shared.register(service: GNewsProvider() as GNewsProviding)
    }

}
