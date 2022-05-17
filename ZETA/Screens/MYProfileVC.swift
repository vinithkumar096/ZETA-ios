//
//  MYProfileVC.swift


import UIKit

class MYProfileVC: UIViewController {

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var btnUPdate: UIButton!
    @IBOutlet weak var PaymentInfoClick: UIButton!
    
    let user = GFunction.user
    
    
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
            self.updateProfile(docID: user?.docId.description ?? "", name: self.txtName.text ?? "", phoneNumber: self.txtPhone.text ?? "")
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
    
    func setUpData(){
        if self.user != nil {
            self.txtName.text = self.user?.name.description
            self.txtEmail.text = self.user?.email?.description
            self.txtPhone.text = self.user?.phone.description
            self.txtEmail.isUserInteractionEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
        // Do any additional setup after loading the view.
    }
}


extension MYProfileVC {
    func updateProfile(docID: String,name:String,phoneNumber:String) {
        let ref = AppDelegate.shared.db.collection(zUser).document(docID)
        ref.updateData([
            zName : name,
            zPhone : phoneNumber,
        ]){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                Alert.shared.showAlert(message: "Your Profile has been Updated !!!", completion: nil)
            }
        }
    }
}
