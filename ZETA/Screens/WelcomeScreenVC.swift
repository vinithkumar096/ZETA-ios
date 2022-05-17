//
//  WelcomeScreenVC.swift
//  ZETA

import UIKit

class WelcomeScreenVC: UIViewController {
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnApple: UIButton!
   
    private let socialLoginManager: SocialLoginManager = SocialLoginManager()
    
    @IBAction func btnClick(_ sender: UIButton) {
        if sender == btnSignUp {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: CreateAccountVC.self) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if sender == btnLogin {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: LoginVC.self) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if sender == btnApple {
            self.socialLoginManager.performAppleLogin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.socialLoginManager.delegate = self
        self.btnLogin.layer.cornerRadius = 10
        self.btnSignUp.layer.cornerRadius = 10
        self.btnApple.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
}


extension WelcomeScreenVC: SocialLoginDelegate {

    func socialLoginData(data: SocialLoginDataModel) {
        print("Social Id==>", data.socialId ?? "")
        print("First Name==>", data.firstName ?? "")
        print("Last Name==>", data.lastName ?? "")
        print("Email==>", data.email ?? "")
        print("Login type==>", data.loginType ?? "")
        self.loginUser(email: data.email, password: data.socialId,data: data)
    }

    func loginUser(email:String,password:String,data: SocialLoginDataModel) {
        
        _ = AppDelegate.shared.db.collection(zUser).whereField(zEmail, isEqualTo: email).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            if snapshot.documents.count != 0 {
                if let vc = UIStoryboard.main.instantiateViewController(withClass:  LoginVC.self) {
                    vc.socialData = data
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                if let vc = UIStoryboard.main.instantiateViewController(withClass:  CreateAccountVC.self) {
                    vc.socialData = data
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
