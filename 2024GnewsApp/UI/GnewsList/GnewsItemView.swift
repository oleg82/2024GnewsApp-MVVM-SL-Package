//
//  GnewsItemView.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 29.09.2024.
//

import SwiftUI

struct GnewsItemView: View {
    let title: String
    let description: String
    let imageUrl: String
    
    @State var scalingFactor: CGFloat = 1
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }.padding(5)
            
            Text(title)
            Text(description)
        }
        .onDisappear {
            self.scalingFactor = 0.2
        }
        .modifier(ReversingScale(to: scalingFactor) {
            self.scalingFactor = 1
        })
        .animation(.default, value: scalingFactor)
    }
}

extension GnewsItemView {
    func progressBar(isLoading: Bool) -> some View {
        self.modifier(LoadingModifier(withLoading: isLoading))
    }
}

struct ReversingScale: AnimatableModifier {
    var value: CGFloat

    private let target: CGFloat
    private let onEnded: () -> ()

    init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
        self.target = value
        self.value = value
        self.onEnded = onEnded // << callback
    }

    var animatableData: CGFloat {
        get { value }
        set { value = newValue
            let callback = onEnded
            if newValue == target {
                    DispatchQueue.main.async(execute: callback)
            }
        }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(value)
    }
}
