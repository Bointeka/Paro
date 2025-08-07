//
//  Search.swift
//  Paro
//
//  Created by Jeremy Ok on 8/2/25.
//

import SwiftUI

struct Search: View {
    @Environment(\.dismiss) var dismiss
    @State var searchString: String = ""
    var body: some View {
        NavigationView {
            
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    TextField("Search",text: $searchString)
                .frame(width: 300, height: 50)
                                , trailing:
                                    Button {
                dismiss()
            } label: {
                Text("Cancel")
            })
    }
}

#Preview {
    Search()
}
