//
//  Route+NewInstance.swift
//  Screens
//
//  Created by Maxence Mottard on 28/10/2024.
//

import Routing
import Workers
import SwiftUI
import Utils

extension Route {
    typealias NewInstance = NewInstanceRoute
}

struct NewInstanceRoute: Route {
    @MainActor
    func viewController(router: Router) -> UIViewController {
        let viewModel = NewInstanceViewModel(
            dependencies: NewInstanceViewModel.Dependencies(
                checkConfigurationWebWorker: Dependency.resolve(CheckConfigurationWebWorking.self)!,
                instanceWorker: Dependency.resolve(InstanceWorking.self)!,
                router: router
            )
        )
        let view = NewInstanceView(viewModel: viewModel).environmentObject(router)
        let viewController = view.viewController(
            title: "New instance",
            largeTitleDisplayMode: .always
        )

        return viewController
    }
}