//
//  EntryReflection.swift
//  Paro
//
//  Created by Jeremy Ok on 8/11/25.
//

import SwiftUI

struct EntryReflection: View {
    @State var reflection: Reflection
    @State var hAlignment: HorizontalAlignment = .leading
    @State var alignment: Alignment = .leading
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: hAlignment) {
                HStack {
                    if hAlignment == .trailing {
                        Spacer()
                    }
                    Text(reflection.getTimestamp()).font(.footnote)
                        .padding(.horizontal, 10)
                    if hAlignment == .leading {
                        Spacer()
                    }
                }
                
                HStack {
                    if hAlignment == .trailing {
                        Spacer()
                    }
                    Text(reflection.text)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: geo.size.width * 0.75, alignment: alignment)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.secondary))
                    if hAlignment == .leading {
                        Spacer()
                    }
                }
               
                
            }
            .padding(.horizontal, 5)
            .padding(.vertical, 5)
            if hAlignment == .trailing {
                Spacer()
            }
        }
        
    }
}

#Preview {
    
    struct Preview: View {
        var reflection: Reflection = Reflection.reflectionPreview
        var body: some View {
            EntryReflection(reflection: reflection)
        }
    }
    
    return Preview()
    
}
