//
//  SwiftUIView.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import SwiftUI

struct NewTerminalSheet: View {
    @State private var newTerminal = Terminal.emptyTerminal
    @Binding var terminals: [Terminal]
    @Binding var isPresentingNewTerminalView: Bool
    
    
    var body: some View {
        NavigationStack {
            DetailEditView(terminal: $newTerminal)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewTerminalView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            terminals.append(newTerminal)
                            isPresentingNewTerminalView = false
                        }
                    }
                }
        }
    }
}

struct NewTerminalSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTerminalSheet(terminals: .constant(Terminal.sampleData), isPresentingNewTerminalView: .constant(true))
    }
}
