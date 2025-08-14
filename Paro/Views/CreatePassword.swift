//
//  CreatePassword.swift
//  Paro
//
//  Created by Jeremy Ok on 8/7/25.
//

import SwiftUI

struct CreatePassword: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var passwords: PasswordModel
    @Binding var createPasswordIsPresent: Bool
    
    @State var name: String = ""
    @State var password: String = ""
    @State var hint: String = ""
    @State var presentAlert: Bool = false
    @State var alertMessage: String = ""
    var body: some View {
        GeometryReader { geo in
            VStack {
                TextField("Name", text: $name)
                    .frame(maxWidth: geo.size.width, maxHeight:50)
                    .padding(.horizontal, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                TextField("Password", text: $password)
                    .frame(maxWidth: geo.size.width, maxHeight:50)
                    .padding(.horizontal, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .padding(.vertical, 10)
                TextField("Hint", text: $hint)
                    .frame(maxWidth: geo.size.width, maxHeight:50)
                    .padding(.horizontal, 10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                HStack {
                    Button {
                        do {
                            try passwords.addPassword(name: name, password: password, hint: hint, context: managedObjectContext)
                            createPasswordIsPresent.toggle()
                        } catch {
                            alertMessage = error.localizedDescription
                            presentAlert.toggle()
                        }
                    } label: {
                        Text("Create")
                    }.alert("Unable to create password", isPresented: $presentAlert) {}
                    Button {
                        createPasswordIsPresent.toggle()
                    } label: {
                        Text ("Cancel")
                    }
                }
                
                
            }
        }
        
    }
}

#Preview {
    CreatePassword(passwords: .constant(PasswordModel(passwords: [])), createPasswordIsPresent: .constant(true))
}
