//
//  ViewFactory.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 07.10.2024.
//

import SwiftUI
import CoreLayer

final class ViewFactory {
    @ViewBuilder static func getGnewsListView(serviceLocator: ServiceLocating, category: DefaultAPI.Category_topHeadlinesGet) -> some View {
        GnewsListView(viewModel: GnewsViewModel(serviceLocator: serviceLocator), category: category)
    }
}
