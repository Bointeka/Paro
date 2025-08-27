//
//  UnlockFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/26/25.
//

import SwiftUI



struct UnlockFolder: View {
    @Binding var passwords: PasswordModel
    @Binding var selectedFolder: Folders?
    @Binding var unlock: Bool
    @Binding var path: NavigationPath
    
    @State var password: String = ""
    @State var errorMessage: String? = nil
    @State var retryCount: Int = 0

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { unlock = false }
            VStack {
                Text("Unlock Folder").font(.headline)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0))
                SecureField("Password", text: $password).textInputAutocapitalization(.never).frame(width: 200, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .textFieldStyle(.roundedBorder)
                    if let errorMessage {
                        if retryCount < 3 {
                            Text(errorMessage)
                                .font(.footnote)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                        } else {
                            Text(selectedFolder!.passwordHash!.hint)
                                .font(.footnote)
                                .padding(.horizontal)
                        }
                }
                Divider().background(Color.gray.opacity(1))
                HStack {
                    Spacer()
                    Button ("Unlock"){
                        if (selectedFolder!.passwordHash != nil && selectedFolder!.passwordHash!.unlock(password)) {
                            passwords.locked = false
                            unlock.toggle()
                            path.append(selectedFolder!)
                            selectedFolder = nil
                            errorMessage = nil
                            retryCount = 0
                        } else {
                            errorMessage = "Incorrect Password"
                            retryCount += 1
                        }
                        password = ""
                    }
                    Spacer()
                    Divider().background(Color.gray.opacity(1))
                    Spacer()
                    Button ("Cancel"){
                        unlock.toggle()
                        selectedFolder = nil
                        errorMessage = nil
                    }
                    Spacer()
                }
            }.frame(width: 250, height: 160)
                .background(Color.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    
    struct UnlockFolderPreview: View {
        @State var passwords: PasswordModel = Password.createPasswordModelHelper
        @State var path: NavigationPath = NavigationPath()
        @State var selectedFolder: Folders? = Folders.folderPreviewHelper
        @State var unlock: Bool = true
        
        var body: some View {
            UnlockFolder(passwords: $passwords, selectedFolder: $selectedFolder, unlock: $unlock, path: $path)
        }
    }
    
    return UnlockFolderPreview()
    
}
