//
//  ContentView.swift
//  Paro
//
//  Created by Jeremy Ok on 7/3/25.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var text: String = "testing"
    @State var folderModel: FolderModel = FolderModel(folders: [])
    @State var isVisible: Bool = false
    
    @State var searchBar: Bool = false;
    @State var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            
            List(folderModel.folders) {folder in
                EntryFolder(folder: folder)
            }.navigationTitle("Folders")
                .toolbar(content: {
                    ToolbarItem (placement: .topBarTrailing){
                        NavigationLink(destination: Search()) {
                            Icon(iconName: "magnifyingglass", width: 30, height: 30)
                                    .padding(.trailing, 30)
                        }
                    }
                })
            HStack {
                Button {
                    isVisible.toggle()
                } label: {
                    Icon(iconName: "folder.fill.badge.plus", width: 50, height: 50)
                }.padding(.leading, 30)
                Spacer()
            }
        }.sheet(isPresented: $isVisible) {
            AddFolder(isPresented: $isVisible, folderModel: $folderModel)
        }
    }
}


#Preview {
    MenuView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
