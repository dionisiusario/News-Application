//
//  SourceViewController.swift
//  News Application
//
//  Created by Dionisius Ario Nugroho on 17/04/20.
//  Copyright © 2020 Dionisius Ario Nugroho. All rights reserved.
//

import UIKit

class SourceViewController: UIViewController {

    @IBOutlet weak var sourceSearchBar: UISearchBar!
    @IBOutlet weak var sourceCollectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let viewModel = ViewModel(client: API())
    var selectedCategory: String = ""
    var selectedSource: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.showLoading = {
            if self.viewModel.isLoading{
                self.indicator.startAnimating()
                self.sourceCollectionView.alpha = 0.0
                
            }else{
                self.indicator.stopAnimating()
                self.sourceCollectionView.alpha = 1.0
                
            }
        }
        
        viewModel.showError = { erorr in
            print(erorr)
        }
        
        viewModel.reloadData = {
            self.sourceCollectionView.reloadData()
        }
        viewModel.sourceListFetch(kategori: selectedCategory, idSumber: "")
        
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

extension SourceViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourceCell", for: indexPath) as! SourceCell
        
        cell.sourceLbl.text = viewModel.cellViewModels[indexPath.row].name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("ini source \(selectedSource.count)")
            if selectedSource == ""{
               selectedSource.append(viewModel.cellViewModels[indexPath.row].id)
               performSegue(withIdentifier: "article", sender: nil)
           }
           
       }
       
       
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                  let art = segue.destination as! ArticleViewController
                   art.selectedSource = selectedSource
                art.selectedCategory = selectedCategory
           
       }
    
    
}
