//
//  DetailEditView.swift
//  brinaePOS_Draft2
//
//  Created by Brinae Bain on 4/16/23.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var terminal: Terminal
    
    var body: some View {
        Form {
            Section(header: Text("Terminal Info")){
                TextField("Name (ie. V400)", text: $terminal.name)
                TextField("POI ID", text: $terminal.poiID)
                ThemePicker(selection: $terminal.theme)
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(terminal: .constant(Terminal.sampleData[0]))
    }
}
