//
//  FavouriteVC.swift
//  ZETA


import UIKit

class FavouriteVC: UIViewController {

    
    @IBOutlet weak var tblList: SelfSizedTableView!
    
    
    var array = [ProductModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = GFunction.user.email {
            self.getFavData(email: email)
        }
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
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
        cell.btnFav.addAction(for: .touchUpInside) {
            if let email = GFunction.user.email {
                self.removeFromFav(data: data, email: email)
            }
        }
        cell.vwMain.addGestureRecognizer(tap)
        return cell
    }
}




class FavouriteCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwMain.layer.cornerRadius = 5
        self.lblType.isHidden = true
    }
    
    func configCell(data: ProductModel){
        self.lblPrice.text = "Price: $\(data.price)"
        self.lblName.text = "$\(data.name)"
        self.lblDes.text = "\(data.description)"
        self.lblType.text = "Category: \(data.categoryName)"
    }
}


//MARK:- API
extension  FavouriteVC {
    func getFavData(email:String){
        _ = AppDelegate.shared.db.collection(zFavourite).whereField(zEmail, isEqualTo: email).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[zName] as? String, let description: String = data1[zDescription] as? String, let price:String = data1[zPrice] as? String,let categoryID:String = data1[zProductID] as? String {
                        print("Favourite Data Count : \(self.array.count)")
                        self.array.append(ProductModel(docId: data.documentID, name: name, description: description, price: price,categoryID: categoryID,categoryName: ""))
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
    
    func removeFromFav(data: ProductModel,email:String){
        let ref = AppDelegate.shared.db.collection(zFavourite).document(data.docId)
        ref.delete(){ err in
            if let err = err {
                print("Error updating document: \(err)")
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Document successfully deleted")
                Alert.shared.showAlert(message: "Product has been removed from favourite list") { (true) in
                    UIApplication.shared.setTab()
                }
            }
        }
    }
}
