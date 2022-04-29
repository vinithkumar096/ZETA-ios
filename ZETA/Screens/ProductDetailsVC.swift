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
    
    var count = 2
    
    @IBAction func btnAddToCartClick(_ sender: UIButton) {
        if let vc = UIStoryboard.main.instantiateViewController(withClass: AddNewCardVC.self){
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        Alert.shared.showAlert(message: "Product has been added in favourite list", completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}
