//
//  NoteEdit.swift
//  Paro
//
//  Created by Jeremy Ok on 7/4/25.
//


import SwiftUI

struct NoteEdit: View {
    @Binding var folder: FolderDev

    @Environment(\.dismiss) private var dismiss

    @FocusState var focused: Bool
    
    @State var note: NoteDev
    @State var showReflections: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading){
                    TextField("Title", text: $note.title)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                        .contentShape(Rectangle())
                        .focused($focused)
                    
                }.cornerRadius(10)
                   // .background(.grassGreen)
                TextEditor(text: $note.text)
                    .frame(minHeight: UIScreen.main.bounds.height * 0.75,
                           maxHeight: UIScreen.main.bounds.height * 0.75)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                
                Button{
                    showReflections.toggle()
                } label: {
                    Text("Reflections")
                }.sheet(isPresented: $showReflections) {
                    ReflectionView(note: $note, showReflection: $showReflections)
                }
            }
            
        }.navigationBarBackButtonHidden(true)
         .navigationBarItems(leading: Button {
                folder.addNote(note)
                dismiss()
            } label: {
                Icon(iconName:"chevron.backward", width: 20, height: 20)
                Text("Back").foregroundColor(.paleAqua)
            }).onAppear {
             focused = true
         }
        
        
        
    }
}

#Preview {
    NoteEdit(folder: .constant(NoteEdit.testData()), note: NoteDev(id: 1))
}


extension NoteEdit {
    static func testData() -> FolderDev{
        let context = PersistenceController.preview.container.viewContext
        var password: Password?
        do {
            password = try Password(name: "test", password: "test", hint: "test", context: context)
        } catch {
            print(error)
            password = nil
        }
        return FolderDev(name: "test", passwordHash: password)
    }
}
