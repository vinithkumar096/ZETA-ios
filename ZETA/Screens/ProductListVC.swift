//
//  ProductListVC.swift
//  ZETA


import UIKit

class ProductListVC: UIViewController {

    @IBOutlet weak var tblList: SelfSizedTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblList.delegate = self
        self.tblList.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension ProductListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
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
