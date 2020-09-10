import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setTab()
    }

    private func setTab() {
        let sampleSearchViewController: UINavigationController = R.storyboard.sampleSearch.instantiateInitialViewController()!

        // 仮ViewController。必要に応じて置き換えてください。
        //let myViewController: UIViewController = R.storyboard.eventList.instantiateInitialViewController()!
        let myViewController2: UIViewController = R.storyboard.mainView.instantiateInitialViewController()!
        
        setViewControllers([sampleSearchViewController, myViewController2], animated: false)
    }
}
