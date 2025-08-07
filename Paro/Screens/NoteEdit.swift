//
//  NoteEdit.swift
//  Paro
//
//  Created by Jeremy Ok on 7/4/25.
//


import SwiftUI

struct NoteEdit: View {
    @Binding var folder: FolderDev?
    @State var note: NoteDev
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            VStack {
                VStack (alignment: .leading){
                    
                    TextField("Title", text: $note.title)
                        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                    
                }.cornerRadius(10)
                    .background(.grassGreen) 
                TextEditor(text: $note.text)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
            }
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button {
                if folder != nil {
                    folder?.addNote(note)
                }
                dismiss()
            } label: {
                Icon(iconName:"chevron.backward", width: 20, height: 20)
                Text("Back").foregroundColor(.paleAqua)
            })
        
        
        
    }
}

#Preview {
    NoteEdit(folder: .constant(NoteEdit.testData()), note: NoteDev(id: 1))
}


extension NoteEdit {
    static func testData() -> FolderDev{
        var password: PasswordDev?
        do {
            password = try PasswordDev(name: "test", password: "test", hint: "test")
        } catch {
            print(error)
            password = nil
        }
        return FolderDev(name: "test", passwordHash: password)
    }
}
