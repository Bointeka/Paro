//
//  ParoApp.swift
//  Paro
//
//  Created by Jeremy Ok on 7/3/25.
//

import SwiftUI

@main
struct ParoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
