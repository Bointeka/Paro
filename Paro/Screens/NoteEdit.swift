//
//  NoteEdit.swift
//  Paro
//
//  Created by Jeremy Ok on 7/4/25.
//


import SwiftUI

struct NoteEdit: View {
    @State var note: Note
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
                dismiss()
            } label: {
                Icon(iconName:"chevron.backward", width: 20, height: 20)
                Text("Back").foregroundColor(.paleAqua)
            })
        
        
        
    }
}

#Preview {
    NoteEdit(note: Note(title: "123", text: "Hello World", timestamp: Date()))
}
