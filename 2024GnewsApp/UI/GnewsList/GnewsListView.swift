//
//  GnewsListView.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 29.09.2024.
//

import SwiftUI
import Combine
import CoreLayer

struct GnewsListView: View {
    var viewModel: GnewsViewModel
    let category: DefaultAPI.Category_topHeadlinesGet
    
    @State private var subs: Set<AnyCancellable> = []
    @State private var isOn = false
    @State private var loadedArticles: [ArticlesArticlesInner] = []
    
    var body: some View {
        NavigationView {
            List(loadedArticles, id: \.self) { item in
                NavigationLink(destination: GnewsFullInfoView(info: item)) {
                    let isElemLast = loadedArticles.needToLoad(item)
                    let isLoading = isElemLast && viewModel.canLoad == false
                    
                    GnewsItemView(title: item.title ?? "", description: item.description ?? "", imageUrl: item.image ?? "")
                        .progressBar(isLoading: isLoading)
                        .onAppear {
                            viewModel.loadNext(category: category)
                        }
                }
            }
            .onAppear {
                viewModel.articlesData.sink { articles in
                    loadedArticles = articles
                }.store(in: &subs)

                viewModel.loadNext(category: category)
            }
        }
    }
}

