////
////  Terminal.swift
////  brinaePOS_Draft2
////
////  Created by Brinae Bain on 4/16/23.
////
//
//import Foundation
//
//
//struct SDKOption: Identifiable, Codable {
//
//    let id: UUID
//    var name: String
//    var serial: String
//    var theme: Theme
//
//    init(id: UUID = UUID(), name: String, serial: String, theme: Theme) {
//        self.id = id
//        self.name = name
//        self.serial = serial
//        self.theme = theme
//    }
//}
//
//
//extension SDKOption {
//    static let sampleData: [SDKOption] =
//
//    [
//        SDKOption(name: "NYC1",
//                 serial: "3823000709",
//                 theme: .bubblegum),
//
//        SDKOption(name: "T2P",
//                 serial: "112233",
//                 theme: .oxblood)
//    ]
//
//}
//
//extension SDKOption {
//    static var emptySDKOption: SDKOption {
//        SDKOption(name: "", serial: "", theme: .orange)
//    }
//}
