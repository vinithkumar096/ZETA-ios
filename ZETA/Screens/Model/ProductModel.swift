//
//  ProductModel.swift


import Foundation
class ProductModel {
    
    var name:String
    var description: String
    var docId: String
    var price: String
    var categoryName: String
    var categoryID: String
    
    init(docId:String, name:String, description:String,price:String,categoryID:String,categoryName:String) {
        self.docId = docId
        self.name = name
        self.description = description
        self.price = price
        self.categoryName = categoryName
        self.categoryID = categoryID
    }

}
