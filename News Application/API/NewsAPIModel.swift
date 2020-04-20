//
//  NewsAPIModel.swift
//  News Application
//
//  Created by Dionisius Ario Nugroho on 17/04/20.
//  Copyright © 2020 Dionisius Ario Nugroho. All rights reserved.
//

import Foundation


typealias sourceLists = SourceList
typealias topHeadLists = TopHeadlineList


struct SourceList: Codable {
    var sources : [items]
    struct items: Codable {
        var id: String
        var name: String
        var category: String
    }
}

struct TopHeadlineList: Codable {
    var articles : [items]
    struct items: Codable {
        var source : sources
        struct sources: Codable {
            var id: String
            var name: String
        }
        var title: String
        var description: String
        var url: URL
    }
}
