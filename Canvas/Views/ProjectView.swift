//
//  ProjectView.swift
//  Canvas
//
//  Created by Alex Nagy on 26.11.2021.
//

import SwiftUI
import CoreData

struct ProjectView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var isSimulatorContainerViewPresented = false
    @State private var isPopoverActive = false
    
    var project: CProject
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    Text("Hello, \(project.name ?? "")!").asPushOutView()
                }
                
                addButton()
            }
            .navigationTitle(project.name ?? "")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        delete()
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    
                    Button {
                        launch()
                    } label: {
                        Image(systemName: "play.fill")
                    }
                }
            }
            .fullScreenCover(isPresented: $isSimulatorContainerViewPresented, onDismiss: nil) {
                SimulatorContainerView()
            }
        }
        
    }
}

extension ProjectView {
    func addButton() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    add()
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
                .popover(isPresented: $isPopoverActive) {
                    ElementsView()
                }
            }
        }
    }
}

extension ProjectView {
    func delete() {
        do {
            try PersistenceController.shared.delete(project)
            dismiss()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func launch() {
        isSimulatorContainerViewPresented.toggle()
    }
    
    func add() {
        isPopoverActive.toggle()
    }
}
