//
//  AddNewCardVC.swift


import UIKit

class AddNewCardVC: UIViewController {
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var txtCardName: UITextField!
    @IBOutlet weak var txtExpiryDate: UITextField!
    @IBOutlet weak var vwName: UIView!
    @IBOutlet weak var vwCredentials: UIView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    
    private func setUpView() {
        self.applyStyle()
    }
    
    
    private func applyStyle(){
        
        self.btnAdd.layer.cornerRadius = 7.0
        
        self.vwName.layer.cornerRadius = 12.0
        self.vwName.layer.borderColor = UIColor.colorLine.cgColor
        self.vwName.layer.borderWidth = 1.0
        
        
        self.vwCredentials.layer.cornerRadius = 12.0
        self.vwCredentials.layer.borderColor = UIColor.colorLine.cgColor
        self.vwCredentials.layer.borderWidth = 1.0
        
        self.txtCVV.textAlignment = .center
        self.txtCVV.delegate = self
        self.txtExpiryDate.delegate = self
        self.txtCardNumber.delegate = self
        self.txtCardName.delegate = self
        
    }
    
    @IBAction func btnSaveClick(_ sender: Any){
        let error = self.validation()
        if error == "" {
            Alert.shared.showAlert(message: "Your Payment has been Done !!!") { (true) in
                UIApplication.shared.setTab()
            }
        }else{
            Alert.shared.showAlert(message: error, completion:  nil)
        }
        
//        self.navigationController?.popViewController(animated: true)
    }
    
    
    func validation() -> String {
        if self.txtCardNumber.text?.trim() == "" {
            return "Please enter card number"
        }else if self.txtCardNumber.text?.count != 12 {
            return "Please enter valid card number"
        }else if self.txtCardName.text?.trim() == "" {
            return "Please enter card holder name"
        }else if self.txtExpiryDate.text?.trim() == "" {
            return "Please enter expiry date"
        }else if self.txtExpiryDate.text?.count != 7 {
            return "Please enter valid exp date"
        }else if self.txtCVV.text?.trim() == "" {
            return "Please enter cvv"
        }else if self.txtCVV.text?.count != 3 {
            return "Please enter valid cvv"
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.txtCVV.layer.cornerRadius = 7.0
        }
        self.setUpView()
        // Do any additional setup after loading the view.
    }

}

extension AddNewCardVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        //TxtMobileNumber allowed only Digits, - and maximum 12 Digits allowed
        if textField == txtCardNumber {
            if ((string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil) && textField.text!.count < 12) || string.isEmpty{
                return true
            }
        }

        if textField == txtCardName {
            if ((string.rangeOfCharacter(from: CharacterSet.letters) != nil || string.rangeOfCharacter(from: CharacterSet.whitespaces) != nil) || string.isEmpty) {
                return true
            }
        }

        //TxtDate allowed only Digits, / and maximum 6 Digits allowed
        if textField == txtExpiryDate {
            if ((string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil) && textField.text!.count < 7) || string.isEmpty{
                if (textField.text?.count == 2) && !string.isEmpty {
                    textField.text?.append(" / ")
                }
                return true
            }
//            self.setPicker()
        }

        //TxtCVV allowed only 3 Digits
        if textField == txtCVV {
            textField.textAlignment = .center
            if ((string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil) && textField.text!.count < 3) || string.isEmpty{
                return true
            }
        }
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
         } else {
            textField.resignFirstResponder()
         }
         return false
      }
}
