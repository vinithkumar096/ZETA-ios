//
//  ProductListVC.swift
//  ZETA


import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tblList: SelfSizedTableView!
    var data: CategoryModel!
    var array = [ProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tblList.delegate = self
//        self.tblList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as! TrendingCell
        cell.vwMain.isUserInteractionEnabled = true
        let data = self.array[indexPath.row]
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


extension ProductListVC {
    func getData(){
        _ = AppDelegate.shared.db.collection(zProductList).whereField(zCategoryName, isEqualTo: self.data.name).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[zName] as? String, let description: String = data1[zDescription] as? String, let price:String = data1[zPrice] as? String, let categoryName:String = data1[zCategoryName] as? String, let categoryID:String = data1[zCategoryID] as? String {
                        print("Data Count : \(self.array.count)")
                        self.array.append(ProductModel(docId: data.documentID, name: name, description: description, price: price,categoryID: categoryID,categoryName: categoryName))
                    }
                }
                self.tblList.delegate = self
                self.tblList.dataSource = self
                self.tblList.reloadData()
            }else{
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
}
