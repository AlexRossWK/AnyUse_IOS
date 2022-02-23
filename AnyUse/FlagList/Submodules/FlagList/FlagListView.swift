//
//  FlagListView.swift
//  AnyUse
//
//  Created by Алексей on 19..022022.
//

import SwiftUI

struct FlagListView: View {
    @StateObject var viewModel: FlagListViewModel
    @State var route: FlagListRouteType? = nil
    let router: FlagListRouting
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.flags) { flag in
                    HStack {
                        Button {
                            route = .update(flag)
                        } label: {
                            Text(flag.name)
                                .font(.title3)
                                .foregroundColor(Color(.label))
                        }
                        Spacer()
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteFlag(at: indexSet)
                }
            }
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Error"),
                      message: Text(error.localizedDescription),
                      dismissButton: .cancel())
            }
            .navigationTitle(Text("🏴‍☠️Flags"))
            .toolbar {
                ToolbarItem {
                    Button {
                        route = .add
                    } label: {
                        Label("Add flag", systemImage: "plus")
                    }
                }
            }
        }.navigationViewStyle(.stack)
        .sheet(item: $route, onDismiss: {
            viewModel.fetchFlags()
        }) { modal in
            switch modal {
            case .add:
                router.goToAddUpdate(currentFlag: nil)
            case .update(let flag):
                router.goToAddUpdate(currentFlag: flag)
            }
        }
        .onAppear {
            onAppear()
        }
    }
    
    private func onAppear() {
        viewModel.fetchFlags()
    }
}

struct FlagListView_Previews: PreviewProvider {
    static var previews: some View {
        let flagService = FlagServiceImplementation(httpClient: HttpClient())
        FlagListView(
            viewModel: FlagListViewModel(
                service: flagService
            ),
            router: FlagListRouter(
                addUpdateFlagAssembly: AddUpdateFlagAssembly(
                    service: flagService
                )
            )
        )
    }
}
