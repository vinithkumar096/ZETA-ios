//
//  FavouriteVC.swift
//  ZETA


import UIKit

class FavouriteVC: UIViewController {

    
    @IBOutlet weak var tblList: SelfSizedTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblList.delegate = self
        self.tblList.dataSource = self
        // Do any additional setup after loading the view.
    }

}


extension FavouriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
        cell.vwMain.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.addAction {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: ProductDetailsVC.self){
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        cell.btnFav.addAction(for: .touchUpInside) {
            Alert.shared.showAlert(message: "Product has been removed from favourite list", completion: nil)
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
    }
}
