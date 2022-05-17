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
    
    var flag: Bool = true
    var socialData: SocialLoginDataModel!
    
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        if sender == btnLogin {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: CreateAccountVC.self) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if sender == btnSignUP {
            let error = self.validation()
            if error == ""{
                self.getExistingUser(email: self.txtEmail.text ?? "", phone: self.txtPhoneNumber.text ?? "", name: self.txtName.text ?? "", password: self.txtPassword.text ?? "")
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
        if socialData != nil {
            self.txtName.text = socialData.firstName
            self.txtEmail.text = socialData.email
            self.txtEmail.isUserInteractionEnabled = false
        }
        self.btnSignUP.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

}


//MARK:- Extension for Login Function
extension CreateAccountVC {

    func createAccount(email: String, phone:String, name:String, password:String) {
        var ref : DocumentReference? = nil
        ref = AppDelegate.shared.db.collection(zUser).addDocument(data:
            [
              zPhone: phone,
              zEmail: email,
              zName: name,
              zPassword : password,
            ])
        {  err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                GFunction.shared.firebaseRegister(data: email)
                
                GFunction.user = UserModel(docId: (ref?.documentID.description)!, name: name, email: email, phone: phone, password: password)
                
                UIApplication.shared.setTab()
                self.flag = true
            }
        }
    }

    func getExistingUser(email: String, phone:String, name:String, password:String) {

        _ = AppDelegate.shared.db.collection(zUser).whereField(zEmail, isEqualTo: email).addSnapshotListener{ querySnapshot, error in

            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }

            if snapshot.documents.count == 0 {
                self.createAccount(email: email, phone:phone, name:name, password:password)
                self.flag = true
            }else{
                if !self.flag {
                    Alert.shared.showAlert(message: "Email is already exist !!!", completion: nil)
                    self.flag = true
                }
            }
        }
    }
}



