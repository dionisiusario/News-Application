//
//  ArticleViewController.swift
//  News Application
//
//  Created by Dionisius Ario Nugroho on 17/04/20.
//  Copyright © 2020 Dionisius Ario Nugroho. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var ArticleSearchBar: UISearchBar!
    @IBOutlet weak var articleCollectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
     let viewModel = ViewModel(client: API())
    
    
      var selectedSource: String = ""
    var selectedCategory: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewModel.showLoading = {
            if self.viewModel.isLoading{
                self.indicator.startAnimating()
                self.articleCollectionView.alpha = 0.0
                
            }else{
                self.indicator.stopAnimating()
                self.articleCollectionView.alpha = 1.0
                
            }
        }
        
        viewModel.showError = { erorr in
            print(erorr)
        }
        
        viewModel.reloadData = {
            self.articleCollectionView.reloadData()
        }
        viewModel.topHeadListFetch(kategori: selectedCategory)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ArticleViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.topHeadlineModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.articleTitle.text = viewModel.topHeadlineModels[indexPath.row].title
        cell.articleDesc.text = viewModel.topHeadlineModels[indexPath.row].description
        
        
        return cell
    }
    
    
}
