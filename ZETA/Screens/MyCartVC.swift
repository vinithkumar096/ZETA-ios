//
//  MyCartVC.swift


import UIKit

class MyCartVC: UIViewController {

    
    @IBOutlet weak var tblList: SelfSizedTableView!
    @IBOutlet weak var btnPay: UIButton!
    
    @IBAction func btnPayClick(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblList.delegate = self
        self.tblList.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension MyCartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartCell", for: indexPath) as! MyCartCell
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
    
    
}
