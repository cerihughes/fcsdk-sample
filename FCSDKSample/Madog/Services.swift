import Foundation
import Madog

let serviceProviderName = "serviceProviderName"

protocol Services {
    var networkManager: NetworkManager { get }
    var callManager: CallManager { get }
}

class DefaultServices: ServiceProvider, Services {
    let name = serviceProviderName

    let networkManager: NetworkManager
    let callManager: CallManager

    // MARK: ServiceProvider
    required init(context: ServiceProviderCreationContext) {
        networkManager = DefaultNetworkManager()
        callManager = DefaultCallManager(networkManager: networkManager)
    }
}

protocol ServicesProvider {
    var services: Services? { get }
}

extension ServicesProvider {
    var networkManager: NetworkManager? { services?.networkManager }
    var callManager: CallManager? { services?.callManager }
}
