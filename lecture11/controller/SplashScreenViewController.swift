import UIKit
import FirebaseAuth

class SplashScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ivSnake: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // MARK: - Private methods
    private func initView() {
        ivSnake.alpha = 0
        UIView.animate(withDuration: 2.0) {
            self.ivSnake.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            if self.checkIfUserExist() {
                self.navigateToMainScreen()
            } else {
                self.showButtons()
            }
        }
    }
    
    private func checkIfUserExist() -> Bool {
        var result = false
        if Auth.auth().currentUser?.uid != nil {
            result = true
        }
        return result
    }
    
    private func showButtons() {
        Utilities.styleFilledButton(self.btnSignUp)
        Utilities.styleHollowButton(self.btnLogin)
        self.btnSignUp.alpha = 1
        self.btnLogin.alpha = 1
    }
    
    private func navigateToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}

