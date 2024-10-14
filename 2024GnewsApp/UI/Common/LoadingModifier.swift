//
//  LoadingModifier.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 29.09.2024.
//

import SwiftUI

struct LoadingModifier: ViewModifier {
    let withLoading: Bool

    func body(content: Content) -> some View {
        if withLoading {
            VStack {
                content
                Divider()
                Spacer()
                ProgressView()
                    .progressViewStyle(.circular)
                Spacer()
            }
        } else {
            content
        }
    }
}
