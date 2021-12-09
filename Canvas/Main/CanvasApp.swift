//
//  CanvasApp.swift
//  Canvas
//
//  Created by Alex Nagy on 26.11.2021.
//

import SwiftUI

@main
struct CanvasApp: App {
    let persistenceController = PersistenceController.shared

    // my change
    var body: some Scene {
        WindowGroup {
            CanvasView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
