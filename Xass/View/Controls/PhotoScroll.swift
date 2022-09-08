//
//  PhotoCarousel.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import SwiftUI

protocol PhotoScrollItemable: Hashable {
    var image: UIImage? { get set }
}

struct PhotoScroll<T: PhotoScrollItemable>: View {
    @Binding var items: [T]
    
    var onDelete: ((T) -> Void?)?
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    ZStack {
                        Image(uiImage: item.image ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80, alignment: .center)
                        HStack {
                            Spacer()
                            VStack {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .onTapGesture {
                                        onDelete?(item)
                                        items.removeAll { current in current == item }
                                    }
                                Spacer()
                            }
                        }.frame(width: 80, height: 80)
                        .zIndex(2)
                    }
                }
            }
        }
    }
}

//struct PhotoCarousel_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoScroll(items: [PhotoScrollItem(image: UIImage(named: "gir1")),PhotoScrollItem(image: UIImage(named: "gir2")),PhotoScrollItem(image: UIImage(named: "gir1")),PhotoScrollItem(image: UIImage(named: "gir2")),PhotoScrollItem(image: UIImage(named: "gir1")),PhotoScrollItem(image: UIImage(named: "gir2")),PhotoScrollItem(image: UIImage(named: "gir1")),PhotoScrollItem(image: UIImage(named: "gir2"))])
//    }
//}
