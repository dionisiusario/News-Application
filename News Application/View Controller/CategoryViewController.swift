//
//  CategoryViewController.swift
//  News Application
//
//  Created by Dionisius Ario Nugroho on 17/04/20.
//  Copyright © 2020 Dionisius Ario Nugroho. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let viewModel = ViewModel(client: API())
    var selectedCategory: String = ""

    var categoryArray: Array = [""]
    var categorySet:Set = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.showLoading = {
            if self.viewModel.isLoading{
                self.indicator.startAnimating()
                self.categoryCollectionView.alpha = 0.0
                
            }else{
                self.indicator.stopAnimating()
                self.categoryCollectionView.alpha = 1.0
                
            }
        }
        
        viewModel.showError = { erorr in
            print(erorr)
        }
        
        viewModel.reloadData = {
            self.categoryCollectionView.reloadData()
        }
        viewModel.sourceListFetch(kategori: "", idSumber: "")
        // Do any additional setup after loading the view.
    }
    
    func changeCategorySet(){
        for i in 0...viewModel.cellViewModels.capacity{
            categorySet.insert(viewModel.cellViewModels[i].category)
        }
        categoryArray = Array(categorySet)
       
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

extension CategoryViewController:  UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryLbl.text = viewModel.cellViewModels[indexPath.row].category
       // cell.categoryLbl.text = categoryArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCategory == ""{
            selectedCategory.append(viewModel.cellViewModels[indexPath.row].category)
            performSegue(withIdentifier: "source", sender: nil)
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               let scr = segue.destination as! SourceViewController
                scr.selectedCategory = selectedCategory
        
    }
}
