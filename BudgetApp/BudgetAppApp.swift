//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Lakshan Sivakumar on 12/1/24.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
