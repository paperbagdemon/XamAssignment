//
//  CheckBox.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import SwiftUI

struct CheckBox: View {
    @Binding var isChecked: Bool
    
    var onValueChanged: ((Bool) -> Void)?
    
    var body: some View {
        VStack {
            if isChecked {
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.green)
            } else {
                Image(systemName: "checkmark.square")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            }
        }.onTapGesture {
            isChecked = !isChecked
            onValueChanged?(isChecked)
        }
    }
}
//
//struct CheckBox_Previews: PreviewProvider {
//
//    static var previews: some View {
//        CheckBox(isChecked: false)
//    }
//}
