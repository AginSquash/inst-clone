//
//  picsum_item.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 26.05.2021.
//

import Foundation
import SwiftUI
import Alamofire

struct PicsumItem: Codable, Hashable, Identifiable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: URL
    let download_url: URL
    
    enum CodingKeys: CodingKey {
        case id
        case author
        case width
        case height
        case url
        case download_url
    }
    
    static func getExample() -> PicsumItem {
        return PicsumItem(id: "0", author: "Alejandro Escamilla", width: 5616, height:3744, url: URL(string: "https://picsum.photos/id/0/info")!, download_url: URL(string: "https://picsum.photos/id/0/5616/3744")!)
    }
}
