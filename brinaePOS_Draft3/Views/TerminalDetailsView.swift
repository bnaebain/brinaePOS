//
//  ContentView.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import SwiftUI
import AdyenPOS
import TerminalAPIKit

struct TerminalDetailsView: View {
    @Binding var terminal: Terminal

    
    @State private var editingTerminal = Terminal.emptyTerminal
    @State private var isPresentingEditView = false


    
    var body: some View {
        List {
            Section(header: Text("Terminal Info")) {
                Text("Name:    \(terminal.name)")
                Text("POI ID:   \(terminal.poiID)")
            }
            Section(header: Text("Payment Info")) {
                Label("$75.00 USD", systemImage: "creditcard")
                NavigationLink(destination: PaymentView()
                    .onAppear{
                        if (terminal.name == "NYC1") {
                            SDKRequest().createNYC1Request()
//                        } else if (terminal.name == "T2P") {
//                            ViewController().didSelectTapToPay()
                        } else {
                            TAPIrequest().createNexoRequest(amount: 75.00, terminal: terminal)
                        }
                    }
                ){
                    Label("Initiate Payment", systemImage: "cart")
                }
            }
        }
        .navigationTitle(terminal.name)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                editingTerminal = terminal
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(terminal: $editingTerminal)
                    .navigationTitle(terminal.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                terminal = editingTerminal
                            }
                        }
                    }
            }
        }
        Image("\(terminal.name)")
            .resizable()
            .scaledToFit()
            .padding()
        
    }
}

struct TerminalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TerminalDetailsView(terminal: .constant(Terminal.sampleData[0]))
        }
    }
}
