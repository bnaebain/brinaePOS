////
////  ContentView.swift
////  brinaePOS_Draft2
////
////  Created by Brinae Bain on 4/16/23.
////
//
//import SwiftUI
//
//struct SDKOptionsDetailsView: View {
//    @Binding var sdkOption: SDKOption
//
//    
//    @State private var editingSDKOption = SDKOption.emptySDKOption
//    @State private var isPresentingEditView = false
//
//    
//    var body: some View {
//        List {
//            Section(header: Text("SDKOption Info")) {
//                Text("Name:    \(sdkOption.name)")
//                Text("Serial:   \(sdkOption.serial)")
//            }
//            Section(header: Text("Payment Info")) {
//                Label("$75.00 USD", systemImage: "creditcard")
//                NavigationLink(destination: PaymentView()
//                    .onAppear{
//                        ViewController().didSelectNYC1()
//                    }
//                ){
//                    Label("Initiate Payment", systemImage: "cart")
//                }
//            }
//        }
//        .navigationTitle(sdkOption.name)
//        .toolbar {
//            Button("Edit") {
//                isPresentingEditView = true
//                editingSDKOption = sdkOption
//            }
//        }
//        .sheet(isPresented: $isPresentingEditView) {
//            NavigationStack {
//                SDKOptionsDetailEditView(sdkOption: $editingSDKOption)
//                    .navigationTitle(sdkOption.name)
//                    .toolbar {
//                        ToolbarItem(placement: .cancellationAction) {
//                            Button("Cancel") {
//                                isPresentingEditView = false
//                            }
//                        }
//                        ToolbarItem(placement: .confirmationAction) {
//                            Button("Done") {
//                                isPresentingEditView = false
//                                sdkOption = editingSDKOption
//                            }
//                        }
//                    }
//            }
//        }
//        
//    }
//}
//
//struct SDKOptionDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SDKOptionsDetailsView(sdkOption: .constant(SDKOption.sampleData[0]))
//        }
//    }
//}
