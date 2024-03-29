//
//  testCore.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 26.05.2021.
//

import Foundation
import Alamofire
import SwiftUI
import UIKit

class InstCore: ObservableObject {
    @Published var items: [PicsumItem] = []
    
    var currentPage: Int = 1
    var idForUpdate: String = ""
    
    func load() {
        let cacher = ResponseCacher(behavior: .cache)
        AF.request("https://picsum.photos/v2/list")
            .cacheResponse(using: cacher)
            .responseDecodable(of: [PicsumItem].self) { responce in
            switch responce.result {
            case .success(let items):
                self.items = items
                self.idForUpdate = items[items.count-5].id
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadNewImages() {
        currentPage += 1
        let parameters: [String: Int]
        parameters = [ "page": currentPage ]
        
        AF.request("https://picsum.photos/v2/list", parameters: parameters).responseDecodable(of: [PicsumItem].self) { responce in
            switch responce.result {
            case .success(let items):
                self.items.append(contentsOf: items)
                self.idForUpdate = items[items.count-5].id
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
