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
    @Published var items: [picsum_item] = []
    @Published var photos: [picsum_photo] = []
    
    func load() {
        AF.request("https://picsum.photos/v2/list").responseDecodable(of: [picsum_item].self) { responce in
            switch responce.result {
            case .success(let items):
                self.items = items
                
                print(items)
                /*
                for item in items {
                    AF.request(item.download_url).responseData { responce in
                        switch responce.result {
                        case .success(let imageData):
                            let image = UIImage(data: imageData)
                            self.photos.append(picsum_photo(id: item.id, author: item.author, image: Image(uiImage: image!)))
                        case .failure(let error):
                            print(error)
                        }
                    }
                } */
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

func test() {
    AF.request("https://picsum.photos/v2/list").responseDecodable(of: [picsum_item].self) { responce in
        
        switch responce.result {
        case .success(let items):
            print(items)
        case .failure(let error):
            print(error)
        }
       
    }
}
