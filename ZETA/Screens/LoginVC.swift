//
//  LoginVC.swift
//  ZETA


import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var flag: Bool = true
    var socialData: SocialLoginDataModel!
    
    @IBAction func btnClick(_ sender: UIButton) {
        self.flag = false
        if sender == btnLogin {
            let error = self.validation()
            if error == "" {
                self.loginUser(email: self.txtEmail.text ?? "", password: self.txtPassword.text ?? "")
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
        self.txtEmail.text = "Test@grr.la"
        self.txtPassword.text = "Test@1234"
        if socialData != nil {
            self.txtEmail.text = socialData.email.description
            self.txtEmail.isUserInteractionEnabled = false
        }
        self.btnLogin.layer.cornerRadius = 10
    }
}


//MARK:- Extension for Login Function
extension LoginVC {
    
    
    func loginUser(email:String,password:String) {
        
        _ = AppDelegate.shared.db.collection(zUser).whereField(zEmail, isEqualTo: email).whereField(zPassword, isEqualTo: password).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            if snapshot.documents.count != 0 {
                let data1 = snapshot.documents[0].data()
                let docId = snapshot.documents[0].documentID
                if let name: String = data1[zName] as? String, let phone: String = data1[zPhone] as? String, let email: String = data1[zEmail] as? String, let password: String = data1[zPassword] as? String {
                    GFunction.user = UserModel(docId: docId, name: name, email: email, phone: phone, password: password)
                }
                GFunction.shared.firebaseRegister(data: email)
//                if let vc = UIStoryboard.main.instantiateViewController(withClass: AddDataVC.self){
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
                UIApplication.shared.setTab()
                
            }else{
                if !self.flag {
                    Alert.shared.showAlert(message: "Please check your credentials !!!", completion: nil)
                    self.flag = true
                }
            }
        }
        
    }
}
