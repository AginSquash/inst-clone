//
//  picsum_item.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 26.05.2021.
//

import Foundation
import SwiftUI
import Alamofire

struct picsum_item: Codable, Hashable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let download_url: URL
    
    enum CodingKeys: CodingKey {
        case id
        case author
        case width
        case height
        case download_url
    }
    
    static func getExample() -> picsum_item {
        return picsum_item(id: "0", author: "Alejandro Escamilla", width: 5616, height:3744, download_url: URL(string: "https://picsum.photos/id/0/5616/3744")!)
    }
}

struct picsum_photo: Identifiable {
    let id: String
    let author: String
    var image: Image?
}
