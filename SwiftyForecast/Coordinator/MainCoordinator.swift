import UIKit
import SafariServices

final class MainCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    @MainActor
    func start() {
        let viewController = UIViewController.make(MainViewController.self, from: .main)
        viewController.viewModel = MainViewController.ViewModel(service: WeatherService())
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    @MainActor
    func openWeatherAPISoruceWebPage(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController.present(safariViewController, animated: true)
    }

    @MainActor
    func openLocationListViewController() {
        let viewController = LocationSearchViewController()

        if let visibleViewController = navigationController
            .viewControllers.first(where: { $0 is LocationSearchViewControllerDelegate }) {
            viewController.delegate = visibleViewController as? LocationSearchViewControllerDelegate
        }
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: true)
    }

    @MainActor
    func dismissViewController() {
        navigationController.dismiss(animated: true)
    }

    @MainActor
    func popTopViewController() {
        navigationController.popViewController(animated: true)
    }
}
