//
//  UserModel.swift
//  SliceOfSpice
//
//  Created by 2022M3 on 05/05/22.
//

import Foundation
class UserModel {
    
    var name:String
    var phone:String
    var email:String?
    var password:String
    var docId: String
    
    init(docId:String, name:String, email:String, phone:String, password:String) {
        self.docId = docId
        self.name = name
        self.password = password
        self.phone = phone
        self.email = email
    }

}
