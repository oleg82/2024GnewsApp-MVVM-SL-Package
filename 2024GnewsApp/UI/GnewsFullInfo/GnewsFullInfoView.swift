//
//  GnewsFullInfoView.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 29.09.2024.
//

import SwiftUI
import CoreLayer

struct GnewsFullInfoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPresentedArticle = false
    @State private var isLoadingWebView = true
    
    var info: ArticlesArticlesInner
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: info.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }.padding(5)
                Text(info.title ?? "")
                    .font(.title)
                    .padding(5)
                Text(info.description ?? "")
                    .foregroundStyle(.gray)
                    .padding(5)
                Text("Дата публикации: \(info.publishedAt ?? "")")
                    .foregroundStyle(.gray)
                    .padding(5)

                if let str = info.url, let url = URL(string: str) {
                    HStack{
                        Text(.init("[Ссылка на первоисточник] (\(info.url ?? "")"))
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        .environment(\.openURL, OpenURLAction { url in
                            isPresentedArticle.toggle()
                            return .handled
                        })
                    }
                    .padding(5)
                    .sheet(isPresented: $isPresentedArticle) {
                        NavigationStack {
                            ScrollView {
                                ZStack {
                                    LoadingWebView(url: url)
                                }
                            }
                            .navigationTitle("Первоисточник")
                            .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }

            }
        }
        .navigationTitle("Новость")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.uturn.left")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}
