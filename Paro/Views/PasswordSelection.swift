//
//  PasswordSelection.swift
//  Paro
//
//  Created by Jeremy Ok on 8/7/25.
//

import SwiftUI

struct PasswordSelection: View {
    @Binding var selectedPassword: PasswordDev?
    @State var password: PasswordDev
    var body: some View {
        HStack {
            Text(password.name)
            Spacer()
            if (selectedPassword == password) {
                Icon(iconName: "checkmark.circle", width: 10,  height:10)
            }
        }.contentShape(Rectangle())
        .onTapGesture {
            selectedPassword = password
        }
    }
}

#Preview {
    PasswordSelection(selectedPassword: .constant(nil), password: PasswordDev(name: "test"))
}
