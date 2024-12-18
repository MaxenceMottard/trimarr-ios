//___FILEHEADER___

import Routing
import SwiftUI

extension Route {
    typealias ___VARIABLE_screenName:identifier___ = ___VARIABLE_screenName:identifier___Route
}

struct ___VARIABLE_screenName:identifier___Route: Route {
    func viewController(router: Router) -> UIViewController {
        let viewModel = Default___VARIABLE_screenName:identifier___ViewModel(
            dependencies: Default___VARIABLE_screenName:identifier___ViewModel.Dependencies(
                router: router
            )
        )

        let view = ___VARIABLE_screenName:identifier___View(viewModel: viewModel).environmentObject(router)
        let viewController = UIHostingController(rootView: view)
        viewController.title = String(localized: /*@START_MENU_TOKEN@*/"localization_key"/*@END_MENU_TOKEN@*/, bundle: .module)
        viewController.navigationItem.largeTitleDisplayMode = /*@START_MENU_TOKEN@*/.never/*@END_MENU_TOKEN@*/

        return viewController
    }
}
