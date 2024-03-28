//
//  ContentView.swift
//  SwipeTask
//
//  Created by Nils on 3/28/24.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: SwipeTaskDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(SwipeTaskDocument()))
}
