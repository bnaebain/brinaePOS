//
//  Terminal.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import Foundation


struct Terminal: Identifiable, Codable {
    
    let id: UUID
    var name: String
    var poiID: String
    var theme: Theme
    
    init(id: UUID = UUID(), name: String, poiID: String, theme: Theme) {
        self.id = id
        self.name = name
        self.poiID = poiID
        self.theme = theme
    }
}


extension Terminal {
    static let sampleData: [Terminal] =
    
    [
        Terminal(name: "V400m",
                 poiID: "v400m-123-456",
                 theme: .navy),
        
        Terminal(name: "S1F2",
                 poiID: "s1f2-123-623",
                 theme: .teal),
        
        Terminal(name: "NYC1",
                 poiID: "NYC1-3823000709",
                 theme: .indigo)
    ]
    
}

extension Terminal {
    static var emptyTerminal: Terminal {
        Terminal(name: "", poiID: "", theme: .lavender)
    }
}
