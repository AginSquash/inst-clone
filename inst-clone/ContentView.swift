//
//  ContentView.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 26.05.2021.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @ObservedObject var instcore = InstCore()
    
    @State var image: Image?
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(instcore.items, id: \.self) { item in
                ImageView(item: item)
            }
        }
        .padding()
        .onAppear(perform: instcore.load)
    }
    

    func updateImage(from data: Data) {
        guard let uiimage = UIImage(data: data) else {
            return
        }
        self.image = Image(uiImage: uiimage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
