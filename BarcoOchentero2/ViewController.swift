//
//  ViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 09/06/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {

    
    
    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Autenticacion"
        
        //Comprobamos la sesion del usuairo
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String ,
            let provider = defaults.value(forKey: "provider") as? String{
            authStackView.isHidden = true
            
          //  navigationController?.pushViewController(HomeViewController(email: email, provider: ProviderTYpe.init(rawValue: provider)!), animated: false)
        }
        
        //Google auth
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
      
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authStackView.isHidden = false
    }

    @IBAction func singUpButtonAction(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passTextField.text {
            
            Auth.auth().createUser(withEmail: email, password: password){
                (result,error) in
             self.showHome(result: result, error: error, provider: .basic)

            }
            
        }
        
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
       
            
            if let email = emailTextField.text, let password = passTextField.text {
                       
                       Auth.auth().signIn(withEmail: email, password: password){
                           (result,error) in
                        self.showHome(result: result, error: error, provider: .basic)
                       }
                       
                   }
                   
    }
    private func showHome(result: AuthDataResult?, error:Error?, provider: ProviderTYpe){
                                if let result = result, error == nil{
                                    
                                    // self.navigationController?.pushViewController(HomeViewController(email: result.user.email!, provider: provider), animated: false)
                                //   self.performSegue(withIdentifier: "logOk", sender: TamanyoViewController.self)
                                    //self.navigationController?.view(HomeViewController(email: result.user.email!, provider: provider))
                                    
                                    self.performSegue(withIdentifier: "logOk", sender: ViewController.self)

                                } else if provider == .basic{
                                      let alertController = UIAlertController(title: "Error",message: "Tiene que introducir bien el correo o contraseña",preferredStyle: .alert)
                                      alertController.addAction(UIAlertAction(title: "Aceptar",style: .default))
                                      self.present(alertController, animated: true, completion : nil)
                                  }
    }
    
    @IBAction func googleButtonAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
}

extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil && user.authentication != nil{
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken, accessToken: user.authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ (result, error) in
               
            self.showHome(result: result, error: error, provider: .google)
            }
        }
    }
    
    
}
