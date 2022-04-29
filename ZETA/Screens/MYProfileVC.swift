//
//  MYProfileVC.swift


import UIKit

class MYProfileVC: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnUPdate: UIButton!
    @IBOutlet weak var PaymentInfoClick: UIButton!
    
    @IBAction func btnSignoutClick(_ sender: UIButton) {
        UIApplication.shared.setStart()
    }
    
    @IBAction func PaymentInfoClick(_ sender: UIButton) {
        if let vc = UIStoryboard.main.instantiateViewController(withClass: PaymentListVC.self) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func updateProfileClick(_ sender: UIButton) {
        let error = self.validation()
        if error == "" {
            Alert.shared.showAlert(message: "Your Profile has been Updated !!!", completion: nil)
        }else{
            Alert.shared.showAlert(message: error, completion: nil)
        }
    }
    
    func validation() -> String {
        if self.txtName.text?.trim() == "" {
            return "Please enter name"
        }else if self.txtEmail.text?.trim() == "" {
            return "Pleasee enter email"
        }else if self.txtPhone.text?.trim() == "" {
            return "Please enter phone number"
        }else if self.txtPhone.text?.trim().count != 10 {
            return "Please enter valid phone number"
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
