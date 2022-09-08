//
//  SelectionField.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import SwiftUI

protocol SelectionViewable: View {
    typealias OnSelectHandler = (_ selected: Selectable?) -> Void
    
    static func buildView(title: String?, selections: [Selectable]?, actionOnSelect: OnSelectHandler?) -> Self
    var onSelect: OnSelectHandler? { get set }
}

struct SelectionField<T: SelectionViewable>: View {
    typealias OnSelectHandler = (_ selected: Selectable?) -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    var placeholder = ""
    @State var text = ""
    var title = ""
    @State var isSelectionShown = false
    var selections: [Selectable]
    @State var lastSelected: Selectable?
    var onSelect: OnSelectHandler?
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                TextField(placeholder, text: $text)
                    .disabled(true)
                Image(systemName: "chevron.down")
            }
        }
        .onTapGesture {
            isSelectionShown = !isSelectionShown
        }
        .frame(height: 40)
        .overlay(Underline())
        .background(isEnabled ? Color.white : Color.XassBackgroundColor)
        .fullScreenCover(isPresented: $isSelectionShown) {
            if selections.count > 0 {
                T.buildView(title: title, selections: selections, actionOnSelect: { selected in
                    isSelectionShown = false
                    lastSelected = selected
                    text = selected?.selectionTitle ?? ""
                    onSelect?(lastSelected)
                })
            } else {
                Button {
                    isSelectionShown = false
                    lastSelected = nil
                } label: {
                    Text("No Selection Available").foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundBlurView())
            }
        }
    }
}

struct SelectionField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectionField<TableSelection>(selections: ["1","2","3"])
            SelectionField<DateSelection>(selections: [Date]())
        }
        
    }
}
