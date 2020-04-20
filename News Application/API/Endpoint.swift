//
//  EndPoint.swift
//  News Application
//
//  Created by Dionisius Ario Nugroho on 17/04/20.
//  Copyright © 2020 Dionisius Ario Nugroho. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var urlParameters: [URLQueryItem] { get }
}

extension Endpoint{
    
    var urlComponent: URLComponents {
        var urlComponent = URLComponents(string: baseUrl)
        urlComponent?.path = path
        urlComponent?.queryItems = urlParameters

        return urlComponent!
    }
    
    var request: URLRequest{
        return URLRequest(url: urlComponent.url!)
    }
}

enum getSource: Endpoint{
    case sourcesList(apikey: String, kategori:String, idSumber: String)

    var baseUrl: String{
        return API.baseUrl
    }

    var path: String{
        switch self {
        case .sourcesList :
            return "/v2/sources"
        }
    }

    var urlParameters: [URLQueryItem] {
        switch self {
        case .sourcesList(let apikey, let kategori, let idSumber):
            return [
               
                URLQueryItem(name: "apiKey", value: apikey),
                URLQueryItem(name: "category", value: kategori),
                URLQueryItem(name: "sources", value: idSumber)
            ]
        }
    }
}

enum getTopHeadList: Endpoint{
    case articleList(apikey: String, kategori:String)
    
    var baseUrl: String{
        return API.baseUrl
    }
    
    var path: String{
        switch self {
        case .articleList:
            return "/v2/top-headlines"
        }
    }
    
    var urlParameters: [URLQueryItem] {
        switch self {
        case .articleList(let apikey, let kategori):
            return [
                URLQueryItem(name: "apiKey", value: apikey),
                URLQueryItem(name: "category", value: kategori)
            ]
        }
    }
}

//
