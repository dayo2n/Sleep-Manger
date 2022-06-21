//
//  ModalView.swift
//  RoutineManger
//
//  Created by 문다 on 2022/04/17.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        Group {
            Text("Modal view")
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
            Text("Dismiss")
            }
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
