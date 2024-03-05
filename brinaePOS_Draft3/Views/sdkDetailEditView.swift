////
////  DetailEditView.swift
////  brinaePOS_Draft2
////
////  Created by Brinae Bain on 4/16/23.
////
//
//import SwiftUI
//
//struct sdkDetailEditView: View {
//    @Binding var sdkOption: SDKOption
//
//    var body: some View {
//        Form {
//            Section(header: Text("Terminal Info")){
//                TextField("Name (ie. NYC1)", text: $sdkOption.name)
//                TextField("Serial", text: $sdkOption.serial)
//                ThemePicker(selection: $sdkOption.theme)
//            }
//        }
//    }
//}
//
//struct sdkDetailEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        sdkDetailEditView(sdkOption: .constant(SDKOption.sampleData[0]))
//    }
//}
