//
//  CategoryModel.swift


import Foundation
class CategoryModel {
    
    var name:String
    var docId: String
    
    init(docId:String, name:String) {
        self.docId = docId
        self.name = name
    }

}
