//
//  CreateAccountVC.swift
//  ZETA


import UIKit

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUP: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        if sender == btnLogin {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: CreateAccountVC.self) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if sender == btnSignUP {
            let error = self.validation()
            if error == ""{
                UIApplication.shared.setTab()
            }else{
                Alert.shared.showAlert(message: error, completion: nil)
            }
        }
    }
    
    
    func validation() -> String {
        if self.txtName.text?.trim() == "" {
            return "Please enter name"
        }else if self.txtEmail.text?.trim() == "" {
            return "Pleasee enter email"
        }else if self.txtPhoneNumber.text?.trim() == "" {
            return "Please enter phone number"
        }else if self.txtPhoneNumber.text?.trim().count != 10 {
            return "Please enter valid phone number"
        }else if self.txtPassword.text?.trim() == "" {
            return "Please enter password"
        }else if (self.txtPassword.text?.trim().count)! < 8 {
            return "Please enter minimum 8 character for password"
        }else if self.txtConfirmPassword.text?.trim() == "" {
            return "Please enter confirm password"
        }else if self.txtPassword.text != self.txtConfirmPassword.text {
            return "Password mismatch"
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.btnSignUP.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

}
