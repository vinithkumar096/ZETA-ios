//
//  WelcomeScreenVC.swift
//  ZETA

import UIKit

class WelcomeScreenVC: UIViewController {
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnApple: UIButton!
   
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        if sender == btnSignUp {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: CreateAccountVC.self) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if sender == btnLogin {
            if let vc = UIStoryboard.main.instantiateViewController(withClass: LoginVC.self) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
