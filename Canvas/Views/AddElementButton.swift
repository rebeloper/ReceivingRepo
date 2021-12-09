//
//  AddElementButton.swift
//  Canvas
//
//  Created by Alex Nagy on 28.11.2021.
//

import SwiftUI

struct AddElementButton: View {
    var action: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    action()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.systemWhite)
                }
                .padding()
                .background(
                    Circle()
                        .foregroundColor(Color.systemMint)
                )
                .padding()
            }
        }
    }
}

