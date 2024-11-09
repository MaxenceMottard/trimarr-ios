//
//  NewInstanceView.swift
//  Deluge
//
//  Created by Maxence Mottard on 28/10/2024.
//

import SwiftUI
import Routing
import Workers
import Utils

struct NewInstanceView: View {
    private enum Field: Hashable {
        case name
        case url
        case apiKey
    }

    @State var viewModel: NewInstanceViewModel
    @FocusState private var focused: Field?

    var body: some View {
        VStack {
            Form {
                Section {
                    Picker("Type", selection: $viewModel.type) {
                        ForEach(Instance.InstanceType.allCases) {
                            Text(String(describing: $0).capitalized)
                        }
                    }
                    .disabled(true)
                }

                Section(
                    content: {
                        TextField("Name", text: $viewModel.name)
                            .autocorrectionDisabled()
                            .focused($focused, equals: .name)
                            .onSubmit { focused = .url }

                        TextField("URL", text: $viewModel.url)
                            .textContentType(.URL)
                            .keyboardType(.URL)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .focused($focused, equals: .url)
                            .onSubmit { focused = .apiKey }
                    },
                    header: {
                        Text("Instance")
                    },
                    footer: {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Please enter the url with format")
                            Text("https://ecorp.com:8989")
                                .tint(.white)
                                .disabled(true)
                        }
                        .font(.footnote)
                    }
                )

                Section {
                    TextField("Api Key", text: $viewModel.apiKey)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .focused($focused, equals: .apiKey)
                        .onSubmit { submitForm() }
                } footer: {
                    Text("You can find your API key under Settings -> General in the web interface.")
                        .font(.footnote)
                }
            }
            Spacer()

            Button("Connect".uppercased()) {
                submitForm()
            }
            .disabled(!viewModel.isFormValid)
            .buttonStyle(.basic)
            .padding()
        }
    }

    private func submitForm() {
        focused = nil
        Task { await viewModel.login() }
    }
}

#Preview {
    NewInstanceView(
        viewModel: NewInstanceViewModel(
            dependencies: NewInstanceViewModel.Dependencies(
                checkConfigurationWebWorker: CheckConfigurationWebWorkingMock(),
                instanceWorker: InstanceWorkingMock(),
                router: Router()
            )
        )
    )
}