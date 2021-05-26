//
//  ContentView.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 26.05.2021.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @EnvironmentObject var instcore: InstCore
    
    @State var image: Image?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack {
                    ForEach(instcore.items, id: \.self) { item in
                        NavigationLink(
                            destination: DetailView(item: item),
                            label: {
                                ImageView(item: item)
                            })
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle("Not-a-gram")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
    static var instaCore = InstCore()
    static var previews: some View {
        ContentView()
            .environmentObject( instaCore )
    }
}
