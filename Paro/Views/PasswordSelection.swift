//
//  PasswordSelection.swift
//  Paro
//
//  Created by Jeremy Ok on 8/7/25.
//

import SwiftUI

struct PasswordSelection: View {
    @Binding var selectedPassword: Password?
    @State var password: Password
    var body: some View {
        HStack {
            Text(password.name)
            Spacer()
            if (selectedPassword == password) {
                Icon(iconName: "checkmark.circle", width: 15,  height:15)
            }
        }.contentShape(Rectangle())
        .onTapGesture {
            selectedPassword = password
        }
    }
}

#Preview {
    PasswordSelection(selectedPassword: .constant(Password.passwordSelectionHelper), password: Password.passwordSelectionHelper)
}

extension Password {
    // MARK: preview helpers
    static var passwordSelectionHelper: Password {
        let context = PersistenceController.preview.container.viewContext
        return try! Password(name: "Test", salt: String.randomString(length: 10), password: "Test", hint: "Test", context: context)
    }
}
