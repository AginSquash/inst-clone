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
    @Published var photos: [picsum_photo] = []
    
    func load() {
        AF.request("https://picsum.photos/v2/list").responseDecodable(of: [PicsumItem].self) { responce in
            switch responce.result {
            case .success(let items):
                self.items = items
            case .failure(let error):
                print(error)
            }
        }
    }
}
