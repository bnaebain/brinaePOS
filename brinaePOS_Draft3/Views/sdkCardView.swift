////
////  CardView.swift
////  brinaePOS_Draft2
////
////  Created by Brinae Bain on 4/16/23.
////
//
//import SwiftUI
//
//struct sdkCardView: View {
//    
//    let sdkOption: SDKOption
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(sdkOption.name)
//                .font(.headline)
//            Spacer()
//            HStack {
//                Text("\(sdkOption.serial)")
//                Spacer()
//                Label("", systemImage: "arrow.right.circle.fill")
//                    .labelStyle(.trailingIcon)
//            }
//            .font(.caption)
//
//        }
//        .padding()
//        .foregroundColor(sdkOption.theme.accentColor)
//    }
//}
//
//struct sdkCardView_Previews: PreviewProvider {
//    
//    static var sdkOption = SDKOption.sampleData[0]
//    static var previews: some View {
//        sdkCardView(sdkOption: sdkOption)
//            .background(sdkOption.theme.mainColor)
//            .previewLayout(.fixed(width: 400, height: 60))
//    }
//}
