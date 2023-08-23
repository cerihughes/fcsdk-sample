import Madog

class DefaultResolver: Resolver<Navigation> {
    override func serviceProviderFunctions() -> [(ServiceProviderCreationContext) -> ServiceProvider] {
        [DefaultServices.init(context:)]
    }

    override func viewControllerProviderFunctions() -> [() -> ViewControllerProvider<Navigation>] {
        [CallViewControllerProvider.init]
    }
}
