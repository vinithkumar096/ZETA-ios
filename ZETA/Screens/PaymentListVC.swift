//
//  PaymentListVC.swift
//  ZETA

import UIKit

class PaymentListVC: UIViewController {

    @IBOutlet weak var tblList: SelfSizedTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblList.delegate = self
        self.tblList.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension PaymentListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        
        cell.vwCell.layer.cornerRadius = 10
        cell.btnSelected.isHidden = true
        if indexPath.row == 0 {
            cell.btnSelected.isHidden = false
        }
        return cell
    }
}

class CardCell: UITableViewCell {
    @IBOutlet weak var lblCardName: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var vwCell: UIView!
    @IBOutlet weak var btnSelected: UIButton!
    
    var btnFavAct: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
//            self.vwCell.backgroundColor = UIColor.hexStringToUIColor(hex: "#6043F5")
            self.btnSelected.layer.cornerRadius = 5
            self.vwCell.layer.cornerRadius = 12.0
        }
    }
}
