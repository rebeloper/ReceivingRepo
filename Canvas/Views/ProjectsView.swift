//
//  ProjectsView.swift
//  Canvas
//
//  Created by Alex Nagy on 26.11.2021.
//

import SwiftUI
import Dot

struct ProjectsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(key: "timestamp", ascending: false)],
        animation: .default)
    private var projects: FetchedResults<CProject>
    
    @State private var isNewProjectViewActive = false
    @State private var isProjectViewActive = false
    @State private var indexTapped = 0
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 9) {
                        ForEach(0..<projects.count, id:\.self) { index in
                            projectCellView(at: index, proxy: proxy)
                        }
                    }
                }
                
                if let firstProject = projects.first {
                    NavigationLink(isActive: $isNewProjectViewActive) {
                        ProjectView(project: firstProject)
                    } label: {
                        EmptyView()
                    }
                }
                
                if projects.count > indexTapped {
                    NavigationLink(isActive: $isProjectViewActive) {
                        ProjectView(project: projects[indexTapped])
                    } label: {
                        EmptyView()
                    }
                }
                
            }
            .padding(.horizontal)
            .navigationTitle("Projects")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        createNewProject()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
        
    }
}

extension ProjectsView {
    
    func projectCellView(at index: Int, proxy: GeometryProxy) -> some View {
        let project = projects[index]
        
        return VStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("\(project.name ?? "")")
                    Spacer()
                }
                Spacer()
            }
            .frame(height: proxy.size.width / 3)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(Color.gray.opacity(0.1))
            )
            .onTapGesture {
                indexTapped = index
                isProjectViewActive.toggle()
            }
        }
        
    }
}

extension ProjectsView {
    private func createNewProject() {
        
        let noticeOptions = NoticeOptions(NoticeOptionsValue(title: "New Project", message: nil))
        
        var textFields: [NoticeTextField] = []
        textFields.append(NoticeTextField(title: "Project Name", autoCapitalizationType: .words))
        
        var buttons: [NoticeButton] = []
        buttons.append(NoticeButton(title: "Submit", action: {
            let newProjectName = noticeOptions.textFields?[0].text ?? ""
            guard !newProjectName.isEmpty else {
                return
            }
            let newProject = CProject(context: viewContext)
            newProject.creationDate = Date()
            newProject.name = newProjectName

            do {
                try PersistenceController.shared.save(newProject)
                isNewProjectViewActive.toggle()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }))
        buttons.append(NoticeButton(.cancel, style: .cancel))
        
        Notice.present(noticeOptions, textFields: textFields, buttons: buttons)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
