//
//  TasbihApp.swift
//  Tasbih
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import SwiftUI
import SwiftData
import CounterKit

@main
struct TasbihApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([Counter.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do { return try ModelContainer(for: schema, configurations: [modelConfiguration]) }
        catch { fatalError("Could not create ModelContainer: \(error)") }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
