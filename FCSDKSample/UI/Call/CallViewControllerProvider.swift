//
//  CallViewControllerProvider.swift
//  FCSDKSample
//
//  Created by Awen CS on 26/07/2023.
//

import Madog
import UIKit

class CallViewControllerProvider: SingleViewControllerProvider<Navigation>, ServicesProvider {
    var services: Services?

    // MARK: ViewControllerProvider

    override final func configure(with serviceProviders: [String: ServiceProvider]) {
        services = serviceProviders[serviceProviderName] as? Services
    }

    override func createViewController(token: Navigation, context: Context) -> UIViewController? {
        guard let callManager, token == .call else { return nil }

        let viewModel = CallViewModel(callManager: callManager)
        return CallViewController(viewModel: viewModel)
    }
}
