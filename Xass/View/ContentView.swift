//
//  ContentView.swift
//  Xass
//
//  Created by Ryan Dale Apo on 9/8/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SelectionField<TableSelection>(selections: ["1","2","3"])
        SelectionField<TableSelection>(selections: ["1","2","3"])
        SelectionField<TableSelection>(selections: ["1","2","3"])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
