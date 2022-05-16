//
//  CartModel.swift
//  ZETA
//
//  Created by 2022M3 on 14/05/22.
//

import Foundation
class CartModel {
    
    var name:String
    var description: String
    var docId: String
    var price: String
    var email: String
    var productID: String
    var quantity: String
    
    init(docId:String, name:String, description:String,price:String,productID:String,email:String,quantity:String) {
        self.docId = docId
        self.name = name
        self.description = description
        self.price = price
        self.email = email
        self.productID = productID
        self.quantity = quantity
    }

}
