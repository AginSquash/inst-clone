//
//  DetailView.swift
//  inst-clone
//
//  Created by Vlad Vrublevsky on 27.05.2021.
//

import SwiftUI
import Alamofire

struct DetailView: View {
    @State var item: PicsumItem
    
    @State var image: Image? = nil
    
    @State private var scale: CGFloat = 1.0
    @State private var imageTranslation = CGSize.zero
    @State private var lastImageTranslation = CGSize.zero
    
    var body: some View {
        VStack {
            if image != nil {
                    image!
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(scale)
                        .animation(.spring())
                        .offset(x: imageTranslation.width, y: imageTranslation.height)
                        .gesture(DragGesture()
                            .onChanged { value in
                                imageTranslation = CGSize(width: value.translation.width + lastImageTranslation.width, height: value.translation.height + lastImageTranslation.height)
                            }
                            .onEnded { _ in
                                self.lastImageTranslation = imageTranslation
                            }
                        )
                        .gesture(MagnificationGesture()
                            .onChanged { value in
                                self.scale = value.magnitude
                            }
                        )
                        .onTapGesture(count: 2, perform: {
                            self.scale = 1.0
                            self.imageTranslation = .zero
                        })
                
            } else {
                ProgressView("Loading image")
            }
        }
        .navigationTitle(item.author)
        .navigationBarItems(trailing: Button(action: shareButton, label: {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 22))
        }))
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        AF.request(item.download_url).responseData { responce in
            switch responce.result {
            case .success(let data):
                print("image: \(data)")
                
                guard let uiimage = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiimage)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func shareButton() {
        let vc = UIActivityViewController(activityItems: [item.url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: PicsumItem.getExample())
    }
}
