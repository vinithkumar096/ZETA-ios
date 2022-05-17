//
//  HomeVC.swift
//  ZETA

import UIKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var colCategoryList: UICollectionView!
    @IBOutlet weak var tblTrending: SelfSizedTableView!
    
    var array = [CategoryModel]()
    var arrayT = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblTrending.delegate = self
        self.tblTrending.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
        self.getProductData()
    }

}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let data = self.array[indexPath.row]
        cell.configCell(data: data)
        let tap = UITapGestureRecognizer()
        tap.addAction {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: ProductListVC.self){
                vc.data = data
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
        self.arrayT.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        cell.vwMain.isUserInteractionEnabled = true
        let data = self.arrayT[indexPath.row]
        cell.configCell(data: data)
        let tap = UITapGestureRecognizer()
        tap.addAction {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: ProductDetailsVC.self){
                vc.data = data
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
    
    func configCell(data: CategoryModel){
        self.lblName.text = data.name
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
    
    func configCell(data: ProductModel){
        self.lblName.text = data.name.description
        self.lblPrice.text = "$ \(data.price.description)"
        self.lblDes.text = data.description.description
        self.lblType.text = "Category: \(data.categoryName.description)"
    }
}

//MARK:- API
extension HomeVC {
    func getData(){
        _ = AppDelegate.shared.db.collection(zCategory).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[zName] as? String {
                        self.array.append(CategoryModel(docId: data.documentID, name: name))
                    }
                }
                print("Category Data Count : \(self.array.count)")
                self.colCategoryList.delegate = self
                self.colCategoryList.dataSource = self
                self.colCategoryList.reloadData()
            }else{
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
}


extension HomeVC{
    func getProductData(){
        _ = AppDelegate.shared.db.collection(zProductList).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.arrayT.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[zName] as? String, let description: String = data1[zDescription] as? String, let price:String = data1[zPrice] as? String, let categoryName:String = data1[zCategoryName] as? String, let categoryID:String = data1[zCategoryID] as? String {
                        print("Data Count : \(self.array.count)")
                        self.arrayT.append(ProductModel(docId: data.documentID, name: name, description: description, price: price,categoryID: categoryID,categoryName: categoryName))
                    }
                }
                self.tblTrending.delegate = self
                self.tblTrending.dataSource = self
                self.tblTrending.reloadData()
            }else{
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
}
