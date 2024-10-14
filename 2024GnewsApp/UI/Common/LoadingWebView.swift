//
//  LoadingWebView.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 29.09.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        wkwebView.navigationDelegate = context.coordinator
        wkwebView.load(URLRequest(url: url))
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        init(_ parent: WebView) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            print("loading error: \(error)")
            parent.isLoading = false
            parent.error = error
        }
    }
}

struct LoadingWebView: View {
    @State private var isLoading = true
    @State private var error: Error? = nil
    
    let url: URL?

    var body: some View {
        ZStack {
            if let error = error {
                Text(error.localizedDescription)
                    .foregroundColor(.pink)
                    .padding()
            } else if let url = url {
                WebView(url: url, isLoading: $isLoading, error: $error)
                     .edgesIgnoringSafeArea(.all)
                if isLoading {
                    ProgressView()
                        .padding()
                }
            } else {
                Text("Sorry, we could not load this url.")
                    .foregroundColor(.pink)
                    .padding()
            }

        }
    }
}
