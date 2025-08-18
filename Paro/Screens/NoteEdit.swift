//
//  NoteEdit.swift
//  Paro
//
//  Created by Jeremy Ok on 7/4/25.
//


import SwiftUI

struct NoteEdit: View {
    enum Field {
        case title, text
    }
    @ObservedObject var folder: Folders

    @Environment(\.dismiss) private var dismiss
    
    @FocusState var focused: Field?
    
    @State var showReflections: Bool = false
    
    @ObservedObject var note: Note
    
    @Binding var notes: [Note]
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading){
                    TextField("Title", text: $note.title)
                        .autocorrectionDisabled()
                        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
                        .contentShape(Rectangle())
                        .focused($focused, equals: .title)
                        .onSubmit {
                            focused = .text
                        }
                    
                }.cornerRadius(10)
                   // .background(.grassGreen)
                TextEditor(text: $note.text)
                    .frame(minHeight: UIScreen.main.bounds.height * 0.75,
                           maxHeight: UIScreen.main.bounds.height * 0.75)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .focused($focused, equals: .text)
                    
                
                Button{
                    showReflections.toggle()
                } label: {
                    Text("Reflections")
                }.sheet(isPresented: $showReflections) {
                    ReflectionView(note: note, showReflection: $showReflections)
                }
            }
            
        }.navigationBarBackButtonHidden(true)
         .navigationBarItems(leading: Button {
             do {
                 try folder.addNote(note)
                 notes.append(note)
                 dismiss()
             } catch {
                 //TODO: Add error when saving fails.
             }
            } label: {
                Icon(iconName:"chevron.backward", width: 20, height: 20)
                Text("Save").foregroundColor(.paleAqua)
            }).onAppear {
                if (note.title == "") {
                    focused = .title
                } else {
                    focused = .text
                }
                
         }
        
        
        
    }
}

#Preview {
    NoteEdit(folder: Folders.folderPreviewHelper, note: Note.notePreviewHelper, notes: .constant([]))
}

