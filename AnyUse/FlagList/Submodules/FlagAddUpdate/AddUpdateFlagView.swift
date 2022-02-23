//
//  AddUpdateFlagView.swift
//  AnyUse
//
//  Created by Алексей on 20..022022.
//

import SwiftUI

struct AddUpdateFlagView: View {
    @ObservedObject var viewModel: AddUpdateFlagViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Flag name", text: $viewModel.flagName)
                .textFieldStyle(.roundedBorder)
                .padding()
            TextField("Flag description", text: $viewModel.flagDescription)
                .textFieldStyle(.roundedBorder)
                .padding()
            Toggle("Feature is enabled", isOn: $viewModel.flagValue)
                .padding()
            Button {
                viewModel.addUpdateFlag { isSucceed in
                    if isSucceed {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error"),
                  message: Text(error.localizedDescription),
                  dismissButton: .cancel())
        }
    }
    
}

struct AddUpdateFlag_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateFlagView(viewModel: AddUpdateFlagViewModel(service: FlagServiceImplementation(httpClient: HttpClient())))
    }
}
