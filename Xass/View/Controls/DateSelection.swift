//
//  DateSelection.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import Foundation
import SwiftUI

struct DateSelection: SelectionViewable {
    static func buildView(title: String? = nil, selections: [Selectable]? = nil, actionOnSelect: OnSelectHandler? = nil) -> Self {
        return DateSelection(title: title ?? "Select", selections: selections, onSelect: actionOnSelect)
    }
    
    var title: String = "Select"
    var selections: [Selectable]? {
        didSet {
            if let castedDate = selections?.first as? Date {
                date = castedDate
            }
        }
    }
    var onSelect: OnSelectHandler?
    @State private var date = Date()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.0).edgesIgnoringSafeArea(.all)
            VStack(spacing: 8){
                DatePicker("Select Date", selection: $date, displayedComponents: [.date])
                    .padding(8)
                HStack {
                    Button {
                        onSelect?(nil)
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(Color.red)
                    .cornerRadius(5)
                    Button {
                        onSelect?(date)
                    } label: {
                        Text("Done")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(Color.green)
                    .cornerRadius(5)
                }
            }
            .background(Color.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        }.background(BackgroundBlurView())
    }
}
