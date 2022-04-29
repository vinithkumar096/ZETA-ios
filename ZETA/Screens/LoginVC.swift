//
//  LoginVC.swift
//  ZETA


import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        if sender == btnLogin {
            let error = self.validation()
            if error == "" {
                UIApplication.shared.setTab()
            }else{
                Alert.shared.showAlert(message: error, completion: nil)
            }
        } else if sender == btnSignUp {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: CreateAccountVC.self) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    func validation() -> String {
        if self.txtEmail.text?.trim() == "" {
            return "Pleasee enter email"
        }else if self.txtPassword.text?.trim() == "" {
            return "Please enter password"
        }
        return ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLogin.layer.cornerRadius = 10
    }
}
