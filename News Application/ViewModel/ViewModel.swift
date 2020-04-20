//
//  ViewModel.swift
//  News Application
//
//  Created by Dionisius Ario Nugroho on 17/04/20.
//  Copyright © 2020 Dionisius Ario Nugroho. All rights reserved.
//

import Foundation
import UIKit

struct CellViewModel {
    var id: String
    var name: String
    var category: String

}

struct TopHeadlineModel {
    var id: String
    var name: String
    var title: String
    var description: String
    var url: URL
}


class ViewModel{
    init(client: APIClient) {
        self.client = client
    }
    
    private let client: APIClient
    var cellViewModels: [CellViewModel] = []
    var topHeadlineModels: [TopHeadlineModel] = []
    
    private var listSources: sourceLists!{
           didSet {
               self.sourcesListFetchs()
           }
    }
    
    private var listTopHead: topHeadLists!{
           didSet {
               self.topHeadListFetchs()
           }
    }
   
    
   
    
    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?
    
    
    
    
    func sourceListFetch(kategori: String, idSumber: String) {
        
        if let client = client as? API {
            self.isLoading = true
            let listSource = getSource.sourcesList(apikey: API.apiKey, kategori: kategori, idSumber: idSumber)
            client.sourceList (with: listSource) { (either) in
                switch either{
                case .success(let list):
                    self.listSources = list
                case .error(let error):
                    self.showError?(error)
                }
            }
        }
    }
    
   
    private func sourcesListFetchs() {
        let group = DispatchGroup()
        self.listSources.sources.forEach{(sources) in
            DispatchQueue.global(qos: .background).async(group: group) {
                group.enter()
                
                let id = sources.id
                let category = sources.category
                let name = sources.name

                
               DispatchQueue.global(qos: .background).sync {
                self.cellViewModels.append(CellViewModel(id: id , name: name, category: category))
                print(self.cellViewModels.count)
                }
               
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.isLoading = false
            self.reloadData?()
        }
    }
    
    
    func topHeadListFetch(kategori: String) {
           
           if let client = client as? API {
               self.isLoading = true
            let listTophead = getTopHeadList.articleList(apikey: API.apiKey, kategori: kategori)
            client.topHeadList (with: listTophead) { (either) in
                   switch either{
                   case .success(let list):
                       self.listTopHead = list
                   case .error(let error):
                       self.showError?(error)
                   }
               }
           }
       }
       
      
       private func topHeadListFetchs() {
           let group = DispatchGroup()
        self.listTopHead.articles.forEach{(tophead) in
               DispatchQueue.global(qos: .background).async(group: group) {
                   group.enter()
                
                    let id = tophead.source.id
                    let name = tophead.source.name
                    let title = tophead.title
                    let description = tophead.description
                    let url = tophead.url

                   
                  DispatchQueue.global(qos: .background).sync {
                    
                    self.topHeadlineModels.append(TopHeadlineModel(id: id, name: name, title: title, description: description, url: url))
                   }
                  
                   group.leave()
               }
           }
           group.notify(queue: .main) {
               self.isLoading = false
               self.reloadData?()
           }
       }
}
