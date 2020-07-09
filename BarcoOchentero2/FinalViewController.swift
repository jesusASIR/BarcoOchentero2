//
//  FinalViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 30/06/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FinalViewController: UIViewController {

    @IBOutlet weak var tamañoLabel: UILabel!
    @IBOutlet weak var tamLabel: UILabel!
    @IBOutlet weak var precioTamLabel: UILabel!
    
    @IBOutlet weak var masaLabel: UILabel!
    @IBOutlet weak var precioMasLabel: UILabel!
    
    @IBOutlet weak var quesoLabel: UILabel!
    @IBOutlet weak var precioQueLable: UILabel!
    
    @IBOutlet weak var ingredientesLabel: UILabel!
    @IBOutlet weak var precioIngLabel: UILabel!
    
    @IBOutlet weak var precioTotalLabel: UILabel!
    
    private let ref = Database.database().reference()
    private var refAll: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         // MARK: - Obtener datos de Firebase
        refAll = ref.child("configuracion")
        refAll.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
               // self.tamList.removeAllObjects()

                var total = 0.0
                var cont = 0
                for refAlls in snapshot.children.allObjects as![DataSnapshot]{
                    let tamObject = refAlls.value as? [String: AnyObject]
                    let precio = tamObject?["precio"] as! String
                    let seleccion = tamObject?["seleccion"] as! String
                    
                    
                    if(cont == 0){
                        self.ingredientesLabel.text = String(seleccion)
                        self.precioIngLabel.text = String(precio) + " €"
                    }else if(cont == 1) {
                        self.masaLabel.text = String(seleccion)
                        self.precioMasLabel.text = String(precio) + " €"
                    }else if(cont == 2) {
                       self.quesoLabel.text = String(seleccion)
                        self.precioQueLable.text = String(precio) + " €"
                    }else if(cont == 3) {
                        self.tamLabel.text = String(seleccion)
                        self.precioTamLabel.text = String(precio) + " €"
                     
                    }
                    cont += 1
                    total += Float64(precio)!
                   
                }
           
                self.precioTotalLabel.text = String(total) + " €"
                
            }
            
        })
    }
    // MARK: - Volvr a configuracion
    @IBAction func paso1ActionButton(_ sender: Any) {
        self.performSegue(withIdentifier: "paso1", sender: FinalViewController.self)
        
        
    }
    
    @IBAction func paso2ActionButton(_ sender: Any) {
         self.performSegue(withIdentifier: "paso2", sender: FinalViewController.self)
    }
    
    @IBAction func paso3ActionButton(_ sender: Any) {
         self.performSegue(withIdentifier: "paso3", sender: FinalViewController.self)
    }
    
    
    @IBAction func paso4ActionButton(_ sender: Any) {
         self.performSegue(withIdentifier: "paso4", sender: FinalViewController.self)
    }
    // MARK: - Insercion del pedido final en Firebase
    @IBAction func compraButton(_ sender: Any) {
        
        
        ref.child("codigos").child("cod2").child("tamaño").setValue( tamañoLabel.text  )
        ref.child("codigos").child("cod2").child("masa").setValue(  masaLabel.text  )
        ref.child("codigos").child("cod2").child("queso").setValue(   quesoLabel.text )
        ref.child("codigos").child("cod2").child("ingredientes").setValue(   ingredientesLabel.text  )
        ref.child("codigos").child("cod2").child("precioTotal").setValue(  precioTotalLabel.text)
        
        self.performSegue(withIdentifier: "volverPush", sender: TamanyoViewController.self)
             
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
