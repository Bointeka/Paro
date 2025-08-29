//
//  ErrorAlert.swift
//  Paro
//
//  Created by Jeremy Ok on 8/28/25.
//

import SwiftUI

struct ErrorAlert: View {
    @Binding var showError: Bool
    @Binding var errorMessage: String
    var body: some View {
        Text(errorMessage)
        Button("OK") {
            showError.toggle()
        }
        Button("Cancel") {
            showError.toggle()
        }
    }
}

#Preview {
    ErrorAlert(showError: .constant(true), errorMessage: .constant("This is an error nessage"))
}
