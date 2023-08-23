import Foundation
import Madog

let serviceProviderName = "serviceProviderName"

protocol Services {
    var networkManager: NetworkManager { get }
    var callManager: CallManager { get }
}

class DefaultServices: ServiceProvider, Services {

    let networkManager: NetworkManager
    let callManager: CallManager

    // MARK: ServiceProvider
    override init(context: ServiceProviderCreationContext) {
        networkManager = DefaultNetworkManager()
        callManager = DefaultCallManager(networkManager: networkManager)
        super.init(context: context)
        name = serviceProviderName
    }
}

protocol ServicesProvider {
    var services: Services? { get }
}

extension ServicesProvider {
    var networkManager: NetworkManager? { services?.networkManager }
    var callManager: CallManager? { services?.callManager }
}
