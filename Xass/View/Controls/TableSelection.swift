//
//  TableSelectionView.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import Foundation
import SwiftUI

struct TableSelection: SelectionViewable {
    static func buildView(title: String? = nil, selections: [Selectable]? = nil, actionOnSelect: OnSelectHandler? = nil) -> Self {
        return TableSelection(title: title ?? "Select", selections: selections, onSelect: actionOnSelect)
    }
    
    var title: String = "Select"
    var selections: [Selectable]?
    var onSelect: OnSelectHandler?
    
    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.headline)
                    .padding(8)
                ForEach(selections ?? [], id: \.selectionTitle) { selection in
                    HStack {
                        Text(selection.selectionTitle)
                        .frame(maxWidth: .infinity, maxHeight: 37, alignment: .leading)
                        
                    }
                    .background(Color.white)
                    .onTapGesture {
                        onSelect?(selection)
                    }
                    .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    .overlay(
                        Underline()
                    )
                    
                }
            }
            .background(Color.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            
        }.background(BackgroundBlurView())
    }
}
