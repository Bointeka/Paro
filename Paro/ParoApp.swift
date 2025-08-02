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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            windowScene?.windows.first?.backgroundColor = .grassGreen
            windowScene?.windows.first?.overrideUserInterfaceStyle = .dark
        }
        return true;
    }
}
