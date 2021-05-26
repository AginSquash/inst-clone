//
//  ImageView.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 26.05.2021.
//

import SwiftUI
import Alamofire

struct ImageView: View {
    @EnvironmentObject var instcore: InstCore
    
    @State var item: PicsumItem
    @State var image: Image? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.white)
                .shadow(radius: 10)
            VStack(spacing: 10) {
                HStack {
                    Image(systemName: "person.circle")
                        .font(.system(size: 30))
                    Text(item.author)
                    Spacer()
                }
                .foregroundColor(.black)
                
                if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
                        .transition(.opacity)
                } else {
                   Rectangle()
                    .foregroundColor(.gray)
                    .transition(.opacity)
                }
                HStack {
                    Image(systemName: "suit.heart")
                    Image(systemName: "paperplane")
                    Image(systemName: "message")
                    Spacer()
                }
                .font(.system(size: 22))
                .foregroundColor(.black)
            }
            .padding()
            
        }
        .frame(height: 460, alignment: .center)
        .padding([.horizontal])
        .padding(.top)
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        
        print("LOADING IMG: \(item.id)")
        
        if item.id == instcore.idForUpdate {
            instcore.loadNewImages()
        }
        
        guard let previewImage =  URL(string: "https://picsum.photos/id/\(item.id)/400") else {
            fatalError("item.id error")
        }
        print("previewImage: \(previewImage)")
        AF.request(previewImage).responseData { responce in
            switch responce.result {
            case .success(let data):
                print("image: \(data)")
                
                self.updateImage(from: data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateImage(from data: Data) {
        print("start updating")
        guard let uiimage = UIImage(data: data) else {
            return
        }
        print("updating")
        
        DispatchQueue.main.async {
            withAnimation {
                self.image = Image(uiImage: uiimage)
            }
        }
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var instaCore = InstCore()
    static var previews: some View {
        ImageView(item: PicsumItem.getExample())
            .environmentObject( instaCore )
    }
}
