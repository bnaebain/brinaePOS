////
////  SDKOptionsDetailEditView.swift
////  brinaePOS_Draft2
////
////  Created by Brinae Bain on 5/16/23.
////
//
//import SwiftUI
//
//struct SDKOptionsDetailEditView: View {
//    @Binding var sdkOption: SDKOption
//    
//    var body: some View {
//        Form {
//            Section(header: Text("SDKOption Info")){
//                TextField("Name (ie. NYC1)", text: $sdkOption.name)
//                TextField("Serial", text: $sdkOption.serial)
//                ThemePicker(selection: $sdkOption.theme)
//            }
//        }
//    }
//}
//
//struct SDKOptionsDetailEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        SDKOptionsDetailEditView(sdkOption: .constant(SDKOption.sampleData[0]))
//    }
//}
