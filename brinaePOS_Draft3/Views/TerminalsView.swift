//
//  TerminalsView.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import SwiftUI
import AdyenPOS

struct TerminalsView: View {
    @Binding var terminals: [Terminal]
    //@Binding var sdkOptions: [SDKOption]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewTerminalView = false
    @State private var isPresentingNewSDKView = false
    let saveAction: ()->Void
    
    @State private var showingDeviceManagement = false
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            NavigationStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                Spacer()
                List($terminals) { $terminal in
                    NavigationLink(destination: TerminalDetailsView(terminal: $terminal)) {
                        CardView(terminal: terminal)
                        
                    }
                    .listRowBackground(terminal.theme.mainColor)
                    
                }
                VStack {
                    /// Add Tap to Pay button if you are using Tap to Pay on iPhone functionality of the SDK
                    Button("Tap to Pay") {
                        Task {
                            await viewModel.initializeTransaction(
                                paymentInterface: .tapToPay,
                                presentationMode: .viewModifier
                            )
                        }
                    }
                    
                    /// Add Card Reader button if you are using NYC1 card reader functionality of the SDK
                    Button("Card Reader") {
                        Task {
                            await viewModel.initializeTransaction(
                                paymentInterface: .cardReader,
                                presentationMode: .viewModifier
                            )
                        }
                        
                    }
                    
                    /// The device management screen is only needed if you're using the SDK for NYC1 card readers
                    Button("Device Management") {
                        showingDeviceManagement.toggle()
                    }
                }
                .buttonStyle(.borderedProminent)
                /// If you want your logo to appear in transaction flows you can pass it in .transactionModal ViewModifier
                /// If you use TransactionPresentationMode.viewModifier, apply it on your SwiftUI view as follows:
                .transactionModal(with: viewModel.paymentService, logo: nil)
                /// Initialize the POS SDK before the view appears
                .task(viewModel.initializePOSSDK)
                /// To add the DeviceManagementView to the body property of our View, you can use a .sheet:
                .sheet(isPresented: $showingDeviceManagement) {
                    NavigationView {
                        DeviceManagementView(paymentService: viewModel.paymentService)
                    }
                }
                
                Spacer()

            }

                HStack {
//                    Button(action: {
//                        SDKRequest().didSelectManageDevices()
//                    }) {
//                        Label("Add NYC1 Device", systemImage: "creditcard")
//                    }
                    Spacer()
                    Button(action: {
                        isPresentingNewTerminalView = true
                    }) {
                        Label("Add Terminal", systemImage: "plus.circle.fill")
                            .labelStyle(.trailingIcon)
                    }
                }
            }
            .sheet(isPresented: $isPresentingNewTerminalView) {
                NewTerminalSheet(terminals: $terminals, isPresentingNewTerminalView: $isPresentingNewTerminalView)
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
            .padding()
    }
}

struct TerminalsView_Previews: PreviewProvider {
    static var previews: some View {
        TerminalsView(terminals: .constant(Terminal.sampleData),saveAction: {}
//                      , viewModel: .init()
        )
    }
}
