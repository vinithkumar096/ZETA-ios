//
//  AddDataVC.swift
//  ZETA


import UIKit

class AddDataVC: UIViewController {

    @IBOutlet weak var txtname: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    var picker = UIPickerView()
    var array = [CategoryModel]()
    var data : CategoryModel!
    
    
    @IBAction func btnAddClick(_ sender: UIButton) {
        let error = self.validation()
        if error == "" {
            self.addData(name: self.txtname.text ?? "", description: self.txtDescription.text ?? "", price: self.txtPrice.text ?? "",data: self.data)
        }else{
            Alert.shared.showAlert(message: error, completion: nil)
        }
        
    }
    
    func validation() -> String {
        if self.txtname.text?.trim() == ""{
            return "Please enter name"
        }else if self.txtPrice.text?.trim() == "" {
            return "Please enter price"
        }else if self.txtDescription.text?.trim() == "" {
            return "Please enter description"
        }
        
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        self.txtCategory.inputView = picker
        // Do any additional setup after loading the view.
    }

}

extension AddDataVC {
    func addData(name: String, description:String,price: String,data: CategoryModel) {
        var ref : DocumentReference? = nil
        ref = AppDelegate.shared.db.collection(zProductList).addDocument(data:
            [
              zName: name,
              zDescription : description,
              zPrice: price,
              zCategoryID: data.docId,
              zCategoryName: data.name
            ])
        {  err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                Alert.shared.showAlert(message: "Your food has been added Successfully !!!") { (true) in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func getData() {
        _ = AppDelegate.shared.db.collection(zCategory).addSnapshotListener{ querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            self.array.removeAll()
            if snapshot.documents.count != 0 {
                for data in snapshot.documents {
                    let data1 = data.data()
                    if let name: String = data1[zName] as? String {
                        print("Data Count : \(self.array.count)")
                        self.array.append(CategoryModel(docId: data.documentID, name: name))
                    }
                }
                self.data = self.array[0]
                self.picker.delegate = self
                self.picker.dataSource = self
                self.picker.reloadAllComponents()
            } else {
                Alert.shared.showAlert(message: "No Data Found !!!", completion: nil)
            }
        }
    }
}


extension AddDataVC: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.array[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.data = self.array[row]
        self.txtCategory.text = self.array[row].name
//        self.data = self.array[row]
    }
}
