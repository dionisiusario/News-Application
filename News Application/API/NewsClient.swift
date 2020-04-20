//
//  GetNews.swift
//  News Application
//
//  Created by Dionisius Ario Nugroho on 17/04/20.
//  Copyright © 2020 Dionisius Ario Nugroho. All rights reserved.
//

import Foundation

class API: APIClient{
    static let baseUrl = "https://newsapi.org"
    static let apiKey = "a639bdbe84ff4727ac7ba882ccec1f45"


    func sourceList(with sources: getSource, completion: @escaping (Either<sourceLists>)->Void){
        let request = sources.request
        print(request)
        get(with: request, completion: completion)
    }
    
    func topHeadList(with tophead: getTopHeadList, completion: @escaping (Either<topHeadLists>)->Void){
        let request = tophead.request
        print(request)
        get(with: request, completion: completion)
    }
//
    
}
