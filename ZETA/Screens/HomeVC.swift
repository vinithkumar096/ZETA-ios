//
//  HomeVC.swift
//  ZETA

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var colCategoryList: UICollectionView!
    @IBOutlet weak var tblTrending: SelfSizedTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colCategoryList.delegate = self
        self.colCategoryList.dataSource = self
        self.tblTrending.delegate = self
        self.tblTrending.dataSource = self
        // Do any additional setup after loading the view.
    }

}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let tap = UITapGestureRecognizer()
        tap.addAction {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: ProductListVC.self){
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        cell.vwMain.isUserInteractionEnabled = true
        cell.vwMain.addGestureRecognizer(tap)
        return cell
    }
    
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        cell.vwMain.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.addAction {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: ProductDetailsVC.self){
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        cell.vwMain.addGestureRecognizer(tap)
        return cell
    }
    
    
}


class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgCategory.layer.cornerRadius = 45
    }
}



class TrendingCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwMain.layer.cornerRadius = 5
    }
}
