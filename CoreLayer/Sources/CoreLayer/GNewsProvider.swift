//
//  GNewsProvider.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 07.10.2024.
//

import Foundation

public protocol GNewsProviding {
    func getNews(category: DefaultAPI.Category_topHeadlinesGet, max: Int, page: Int) async throws -> Articles?
}

open class GNewsProvider: GNewsProviding {
    private static let gnewsApikey = "b7cc753d91f6f5e58db24beed93af69e"
//    private static let gnewsApikey = "72dd619cbd513c6ea0661387e389f7c2"
    
    public init() {}
    
    public func getNews(category: DefaultAPI.Category_topHeadlinesGet, max: Int, page: Int) async throws -> Articles? {
        try? await DefaultAPI.topHeadlinesGet(category: category, apikey: GNewsProvider.gnewsApikey, max: max, page: page)
    }
}
