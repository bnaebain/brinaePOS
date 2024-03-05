//
//  brinaePOS_Draft2App.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import SwiftUI

@main
struct brinaePOS_Draft3App: App {
    @StateObject private var store = TerminalStore()

    
    @State private var errorWrapper: ErrorWrapper?
    
    @State private var terminals = Terminal.sampleData
    var body: some Scene {
        WindowGroup {
            TerminalsView(terminals: $store.terminals) {
                Task {
                    do {
                        try await store.save(terminals: store.terminals)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "brinaePOS will load sample data and continue.")
                }
                
            }
            .sheet(item: $errorWrapper) {
                store.terminals = Terminal.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
            
        }
    }
}
