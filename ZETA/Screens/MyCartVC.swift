//
//  MyCartVC.swift


import UIKit

class MyCartVC: UIViewController {

    
    @IBOutlet weak var tblList: SelfSizedTableView!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    var array = [CartModel]()
    var TotalAmount: Float = 0.0
    
    @IBAction func btnPayClick(_ sender: UIButton) {
        self.calculateAmount()
        if let vc = UIStoryboard.main.instantiateViewController(withClass: AddNewCardVC.self) {
            vc.data = self.array
            vc.totalAmount = self.TotalAmount
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func calculateAmount(){
        for data in array {
            self.TotalAmount += (Float(data.price) ?? 0.0) * (Float(data.quantity) ?? 0.0)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let email = GFunction.user.email{
            self.getCartData(email: email)
        }
        // Do any additional setup after loading the view.
    }
}

extension MyCartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.lblTitle.text = "You have \(self.array.count) items in cart."
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartCell", for: indexPath) as! MyCartCell
        cell.configCell(data: self.array[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}






class MyCartCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var vwCell: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    
    func configCell(data: CartModel){
        self.lblName.text = data.name
        self.lblType.text = data.description
        self.lblPrice.text = "Price Range: $\(data.price)"
        self.lblCount.text = "QTY: \(data.quantity)"
    }
    
}



//MARK:- API
extension MyCartVC {
    func getCartData(email:String){
        _ = AppDelegate.shared.db.collection(zCart).whereField(zEmail, isEqualTo: email).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[zName] as? String, let description: String = data1[zDescription] as? String, let price:String = data1[zPrice] as? String,let productID:String = data1[zProductID] as? String, let qty: String = data1[zQuantity] as? String {
                        print("cart Data Count : \(self.array.count)")
                        self.array.append(CartModel(docId: data.documentID, name: name, description: description, price: price, productID: productID, email: email, quantity: qty))
                    }
                }
                self.tblList.delegate = self
                self.tblList.dataSource = self
                self.tblList.reloadData()
            }else{
                self.lblTitle.text = "You have 0 items in cart."
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
    
    func removeItem(docID:String){
        let ref = AppDelegate.shared.db.collection(zCart).document(docID)
        ref.delete(){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                if let email = GFunction.user.email {
                    self.getCartData(email: email)
                }
                print("Document successfully deleted")
            }
        }
    }
}
