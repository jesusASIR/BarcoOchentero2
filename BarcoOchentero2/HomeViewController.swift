//
//  HomeViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 10/06/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

enum ProviderTYpe: String {
    case basic
    case google
}
class HomeViewController: UIViewController {

    
    @IBOutlet weak var cerrarSession: UIButton!
  
    
    private var email: String
    private var provider: ProviderTYpe
    
    init(email: String, provider: ProviderTYpe){
        self.email = email
        self.provider = provider
        super.init(nibName: "HomeViewController", bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) No fue inplementado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Menu"
        navigationItem.setHidesBackButton(true, animated: false)
        // Do any additional setup after loading the view.
        
        // Guardar datos de los usuios
        
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        
        
    }
    
    
  
    @IBAction func cerrarSessionAction(_ sender: Any) {
    
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        switch provider {
        case .basic:
           firebaseLogOut()
        case  .google:
            GIDSignIn.sharedInstance()?.signOut()
           firebaseLogOut()
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    private func firebaseLogOut(){
        do{
                try
                    Auth.auth().signOut()
                }catch{
                    
                       let alertController = UIAlertController(title: "Error",message: "Se produjo un error",preferredStyle: .alert)
                                          alertController.addAction(UIAlertAction(title: "Aceptar",style: .default))
                                          self.present(alertController, animated: true, completion : nil)
                   }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
