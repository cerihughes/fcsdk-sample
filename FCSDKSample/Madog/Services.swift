import Foundation
import Madog

let serviceProviderName = "serviceProviderName"

protocol Services {
    var callManager: CallManager { get }
}

class DefaultServices: ServiceProvider, Services {
    let name = serviceProviderName

    let callManager: CallManager

    // MARK: ServiceProvider
    required init(context: ServiceProviderCreationContext) {
        callManager = DefaultCallManager()
    }
}

protocol ServicesProvider {
    var services: Services? { get }
}

extension ServicesProvider {
    var callManager: CallManager? { services?.callManager }
}
