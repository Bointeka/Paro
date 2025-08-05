//
//  NewFolder.swift
//  Paro
//
//  Created by Jeremy Ok on 8/1/25.
//

import SwiftUI

struct AddFolder: View {
    @State var showCreateAlert = false
    @Binding var isPresented: Bool
    @Binding var folderModel: FolderModel?
    @Binding var folder: FolderDev?
    @State var folderName: String = ""
    var body: some View {
        GeometryReader {geo in
            VStack {
                HStack {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text("Cancel")
                    }.padding(.horizontal, geo.size.width * 0.05)
                    Spacer()
                    Button {
                        if (folderModel != nil) {
                            do {
                                try folderModel?.addFolder(FolderDev(name: folderName))
                                isPresented.toggle()
                            } catch {
                                showCreateAlert.toggle()
                            }
                        } else {
                            do {
                                try folder?.addFolder(FolderDev(name: folderName))
                                isPresented.toggle()
                            } catch {
                                showCreateAlert.toggle()
                            }
                        }
                       
                        
                    } label: {
                        Text("Create")
                    }.padding(.horizontal, geo.size.width * 0.05)
                        .alert("There is already a folder with the same name.", isPresented: $showCreateAlert) {
                        }
                }.padding(.vertical, 10)
                TextField("Folder Name", text: $folderName)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .textInputAutocapitalization(.words)
                    
            }
            
        }.padding(.top, 20)
        Spacer()
       
    }
}

#Preview {
    AddFolder(isPresented: .constant(true as Bool), folderModel: .constant(FolderModel(folders:[])), folder: .constant(nil))
}
