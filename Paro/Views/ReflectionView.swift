//
//  ReflectionView.swift
//  Paro
//
//  Created by Jeremy Ok on 8/11/25.
//

import SwiftUI

struct ReflectionView: View {
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var note: Note
    @Binding var showReflection: Bool
    
    @State var text: String = ""
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Button {
                        showReflection.toggle()
                    } label: {
                        Text("Cancel")
                    }.padding(.horizontal, geo.size.width * 0.05)
                    Spacer()
                    Button {
                        note.addReflection(text, context: context)
                        text = ""
                    } label: {
                        Text("Save")
                    }.padding(.horizontal, geo.size.width * 0.05)
                }
                
                TextEditor(text: $text)
                    .textInputAutocapitalization(.sentences)
                    .frame(minHeight: 150, maxHeight:150)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                Section("Reflections", content: {
                    ScrollView {
                        LazyVStack ( spacing: 30) {
                            ForEach(Array(note.reflections), id: \.self.id) { reflection in
                                if (reflection.isEven()) {
                                    EntryReflection(reflection: reflection, hAlignment: .trailing, alignment: .trailing, ).swipeActions (edge: .trailing){
                                        Button(role: .destructive) {
                                            note.deleteReflection(reflection)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                } else {
                                    EntryReflection(reflection: reflection, hAlignment: .leading, alignment: .leading).swipeActions(edge: .trailing) {
                                        Button(role: .destructive) {
                                            note.deleteReflection(reflection)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                })
                Spacer()
            }
        }
    }
}

#Preview {
    struct ReflectionPreview: View {
        @State var note: Note = Note.notePreviewHelper
        @State var showReflection: Bool = true
        var body: some View {
            ReflectionView(note: note, showReflection: $showReflection)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
    
    return ReflectionPreview()
    
}
