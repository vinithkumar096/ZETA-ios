//
//  ProductDetailsVC.swift
//  ZETA


import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    
    @IBOutlet weak var btnAddToCart: UIButton!
    
    var data: ProductModel!
    var count = 2
    var isFav: Bool = true
    var isCart: Bool = true
    
    @IBAction func btnAddToCartClick(_ sender: UIButton) {
        self.isCart = false
        if let email = GFunction.user.email {
            self.checkCart(data: self.data, email: email, quantity: count.description)
        }
//        if let vc = UIStoryboard.main.instantiateViewController(withClass: AddNewCardVC.self){
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    @IBAction func btnCounterClick(_ sender: UIButton) {
        if sender == btnMinus {
            if count != 1{
                count = (count - 1)
            }
            if self.count == 1{
                self.btnMinus.isSelected = true
                self.btnMinus.isUserInteractionEnabled = false
            }
        }else{
            self.btnMinus.isSelected = false
            self.btnMinus.isUserInteractionEnabled = true
            count = (count + 1)
        }
        self.lblCount.text = count.description
    }
    
    @IBAction func btnFavClick(_ sender: Any) {
        self.isFav = false
        if let userEmail = GFunction.user.email{
            self.checkAddToFav(data: self.data, email: userEmail)
        }
    }
    
    func setUpData(){
        if self.data != nil{
            self.lblName.text = data.name
            self.lblPrice.text = "Price: $\(data.price)"
            self.lblCategory.text = data.categoryName
            self.lblDescription.text = data.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}


extension ProductDetailsVC {
        func addToFav(data: ProductModel,email:String){
            var ref : DocumentReference? = nil
            ref = AppDelegate.shared.db.collection(zFavourite).addDocument(data:
                [
                    zName: data.name,
                    zDescription : data.description,
                    zPrice: data.price,
                    zEmail: email,
                    zProductID: data.docId
                ])
            {  err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    Alert.shared.showAlert(message: "Product has been added in favourite list") { (true) in
                        UIApplication.shared.setTab()
                    }
                }
            }
        }
    
        func checkAddToFav(data: ProductModel, email:String) {
            _ = AppDelegate.shared.db.collection(zFavourite).whereField(zEmail, isEqualTo: email).whereField(zProductID, isEqualTo: data.docId).addSnapshotListener{ querySnapshot, error in
    
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                if snapshot.documents.count == 0 {
                    self.isFav = true
                    self.addToFav(data: data, email: email)
                }else{
                    if !self.isFav {
                        Alert.shared.showAlert(message: "Item has been already existing into Favourite!!!", completion: nil)
                    }
    
                }
            }
        }
    
    func addToCart(data:ProductModel, email:String,quantity: String){
        var ref : DocumentReference? = nil
        ref = AppDelegate.shared.db.collection(zCart).addDocument(data:
            [
                zName: data.name,
                zDescription : data.description,
                zPrice: data.price,
                zEmail: email,
                zProductID: data.docId,
                zQuantity: quantity
            ])
        {  err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                Alert.shared.showAlert(message: "Item has been added into cart!!!") { (true) in
                    UIApplication.shared.setTab()
                }
            }
        }
    }
    
    func checkCart(data: ProductModel,email:String,quantity: String){
        _ = AppDelegate.shared.db.collection(zCart).whereField(zEmail, isEqualTo: email).whereField(zProductID, isEqualTo: data.docId).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            if snapshot.documents.count == 0 {
                self.isCart = true
                self.addToCart(data: data, email: email, quantity: quantity)
            }else{
                if !self.isCart{
                    Alert.shared.showAlert(message: "Item has been already existing into Cart!!!", completion: nil)
                    
                }
            }
        }
    }
}
