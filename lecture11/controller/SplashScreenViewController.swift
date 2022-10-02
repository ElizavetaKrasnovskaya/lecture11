import UIKit

class SplashScreenViewController: UIViewController {
    
    @IBOutlet weak var ivSnake: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        ivSnake.alpha = 0
        UIView.animate(withDuration: 2.0) {
            self.ivSnake.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(4)) {
            self.navigateToNextScreen()
        }
    }
    
    private func navigateToNextScreen() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = sb.instantiateViewController(withIdentifier: "GreetingViewController") as? GreetingViewController,
              let navController = self.navigationController
        else { return }
        
        navController.pushViewController(destination, animated: true)
    }
}

