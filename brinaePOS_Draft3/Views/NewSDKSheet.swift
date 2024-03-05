////
////  SwiftUIView.swift
////  brinaePOS_Draft2
////
////  Created by Brinae Bain on 4/16/23.
////
//
//import SwiftUI
//
//struct NewSDKSheet: View {
//    @State private var newSDKOption = SDKOption.emptySDKOption
//    @Binding var sdkOptions: [SDKOption]
//    @Binding var isPresentingNewSDKView: Bool
//    
//    
//    var body: some View {
//        NavigationStack {
//            SDKOptionsDetailEditView(sdkOption: $newSDKOption)
//                .toolbar {
//                    ToolbarItem(placement: .cancellationAction) {
//                        Button("Dismiss") {
//                            isPresentingNewSDKView = false
//                        }
//                    }
//                    ToolbarItem(placement: .confirmationAction) {
//                        Button("Add") {
//                            sdkOptions.append(newSDKOption)
//                            isPresentingNewSDKView = false
//                        }
//                    }
//                }
//        }
//    }
//}
//
//struct NewSDKSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        NewSDKSheet(sdkOptions: .constant(SDKOption.sampleData), isPresentingNewSDKView: .constant(true))
//    }
//}
