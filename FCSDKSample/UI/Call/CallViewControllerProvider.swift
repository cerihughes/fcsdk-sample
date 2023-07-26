//
//  CallViewControllerProvider.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import Madog
import UIKit

class CallViewControllerProvider: ViewControllerProvider, ServicesProvider {
    var services: Services?

    // MARK: ViewControllerProvider

    final func configure(with serviceProviders: [String: ServiceProvider]) {
        services = serviceProviders[serviceProviderName] as? Services
    }

    func createViewController(token: Navigation, context: AnyContext<Navigation>) -> ViewController? {
        guard let callManager, token == .call else { return nil }

        let viewModel = CallViewModel(callManager: callManager)
        return CallViewController(viewModel: viewModel)
    }
}

