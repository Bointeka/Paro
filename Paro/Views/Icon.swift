//
//  Icon.swift
//  Paro
//
//  Created by Jeremy Ok on 7/4/25.
//

import SwiftUI

import SwiftUI

struct Icon: View {
    let iconName: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Image(systemName: iconName)
            .symbolRenderingMode(.multicolor)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.paleAqua)
            .backgroundStyle(.grassGreen)
            .frame(width: width, height: height)
    }
}

#Preview {
    Icon(iconName: "square.and.pencil", width: 50, height: 50)
}
