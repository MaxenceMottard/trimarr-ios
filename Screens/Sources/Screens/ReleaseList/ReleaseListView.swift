//
//  ReleaseListView.swift
//  Trimarr
//
//  Created by Maxence Mottard on 24/11/2024.
//

import SwiftUI
import Routing
import Workers
import Utils
import DesignSystem

struct ReleaseListView: View {
    @State var viewModel: ReleaseListViewModeling

    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.title)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    VStack(spacing: 12) {
                        ForEach(viewModel.results, id: \.title) { release in
                            ReleaseItemView(
                                release: release,
                                openInBrowser: { viewModel.openInBrowser(release: release) },
                                downloadRelease: { await viewModel.download(release: release) }
                            )
                        }
                    }

                    Spacer()
                }
            }
            .padding()
        }
        .task { await viewModel.release() }
    }
}

#Preview {
    let viewModel: ReleaseListViewModeling = {
        let viewModel = ReleaseListViewModelingMock()
        viewModel.isLoading = false
        viewModel.results = .preview
        viewModel.title = "Serie name - 2x12 - Episode name"

        return viewModel
    }()

    ReleaseListView(viewModel: viewModel)
}

#Preview("ReleaseListView Loading") {
    let viewModel: ReleaseListViewModeling = {
        let viewModel = ReleaseListViewModelingMock()
        viewModel.isLoading = true

        return viewModel
    }()

    ReleaseListView(viewModel: viewModel)
}
