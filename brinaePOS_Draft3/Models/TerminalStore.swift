//
//  TerminalStore.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import SwiftUI


@MainActor

class TerminalStore: ObservableObject {
    @Published var terminals: [Terminal] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("terminals.data")
    }
    
    func load() async throws {
        let task = Task<[Terminal], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let storedTerminals = try JSONDecoder().decode([Terminal].self, from: data)
            return storedTerminals
            
        }
        
        let terminals = try await task.value
        self.terminals = terminals
    }
    
    
    func save(terminals: [Terminal]
    ) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(terminals)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
}




