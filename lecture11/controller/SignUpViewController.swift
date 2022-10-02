import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    @IBOutlet weak var tvError: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        Utilities.styleTextField(etEmail)
        Utilities.styleTextField(etPassword)
        Utilities.styleFilledButton(btnSignUp)
    }
    
    private func showError(_  message: String) {
        tvError.text = message
        tvError.alpha = 1
    }
    
    private func createUser() {
        Auth.auth().createUser(
            withEmail: etEmail.text!,
            password: etPassword.text!
        ) { (result, err) in
            if err != nil {
                self.showError("Error creating user")
            } else {
                self.navigateToHome()
            }
        }
    }
    
    private func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let error = Utilities.validateFields(
            email: etEmail.text ?? "",
            password: etPassword.text ?? ""
        )
        if error != nil {
            showError(error!)
        } else {
            createUser()
        }
    }
}
