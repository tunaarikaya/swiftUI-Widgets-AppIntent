//
//  ToDo.swift
//  To-Do-Widget
//
//  Created by Mehmet Tuna Arıkaya on 11.09.2024.
//

import Foundation



struct ToDo : Identifiable {
    let id : String = UUID().uuidString
    var name : String
    var isDone : Bool = false
}

class SharedDatas {
    static let shared = SharedDatas()
    var toDos : [ToDo] = [
        .init(name: "spora git"),
        .init(name: "kitap oku"),
        .init(name:"westworld izle"),
        
        
    
    ]
        
    
}
