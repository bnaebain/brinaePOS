//
//  CardView.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import SwiftUI

struct CardView: View {
    
    let terminal: Terminal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(terminal.name)
                .font(.headline)
            Spacer()
            HStack {
                Text("\(terminal.poiID)")
                Spacer()
                Label("", systemImage: "arrow.right.circle.fill")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)

        }
        .padding()
        .foregroundColor(terminal.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var terminal = Terminal.sampleData[0]
    static var previews: some View {
        CardView(terminal: terminal)
            .background(terminal.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
