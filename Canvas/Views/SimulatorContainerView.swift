//
//  SimulatorContainerView.swift
//  Canvas
//
//  Created by Alex Nagy on 27.11.2021.
//

import SwiftUI

struct SimulatorContainerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
                Spacer()
            }
            
            SimulatorView()
        }
    }
}

struct SimulatorContainerView_Previews: PreviewProvider {
    static var previews: some View {
        SimulatorContainerView()
    }
}
