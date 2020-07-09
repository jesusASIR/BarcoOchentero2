//
//  MasaViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 01/07/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MasaViewController: UIViewController {

    @IBOutlet weak var nombreLabel1: UILabel!
    @IBOutlet weak var precioLabel1: UILabel!
    @IBOutlet weak var check1: UISwitch!
    
    @IBOutlet weak var nombreLabel2: UILabel!
    @IBOutlet weak var precioLabel2: UILabel!
    @IBOutlet weak var check2: UISwitch!
    
    @IBOutlet weak var nombreLabel3: UILabel!
    @IBOutlet weak var precioLabel3: UILabel!
    @IBOutlet weak var check3: UISwitch!
    
    private var estado:Bool = false
    private let ref = Database.database().reference()
    
    private var refTam: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Cargar los datos de Firebase
        refTam = ref.child("masas")
        refTam.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
               // self.tamList.removeAllObjects()

                var cont = 0
                for refTams in snapshot.children.allObjects as![DataSnapshot]{
                    let tamObject = refTams.value as? [String: AnyObject]
                   let tamNombre = tamObject?["nombre"] as! String
                    let tamPrecio = tamObject?["precio"] as! Float64
                    
                    
                    if(cont == 0){
                        self.nombreLabel1.text = String(tamNombre)
                        self.precioLabel1.text = String(tamPrecio)
                    }else if(cont == 1) {
                        self.nombreLabel2.text = String(tamNombre)
                        self.precioLabel2.text = String(tamPrecio)
                    }else if(cont == 2) {
                       self.nombreLabel3.text = String(tamNombre)
                        self.precioLabel3.text = String(tamPrecio)
                    }
                    cont += 1
                   
                }
            }
            
        })    }
    
    @IBAction func paso3Action(_ sender: Any) {
        viewCheck()
               if(estado == true){
                   
                   sendInformation()
                   self.performSegue(withIdentifier: "paso3Push", sender: MasaViewController.self)
               }else{
                   self.showToast(message: "Seleccione una opcion", font: .systemFont(ofSize: 12.0))

               }
    }
      // MARK: - Insertar los datos de Firebase
    func sendInformation(){
        if(check1.isOn){
            ref.child("configuracion").child("masa").child("precio").setValue(   precioLabel1.text  )
            ref.child("configuracion").child("masa").child("seleccion").setValue(nombreLabel1.text )
        }
        if(check2.isOn){
            ref.child("configuracion").child("masa").child("precio").setValue(   precioLabel2.text  )
            ref.child("configuracion").child("masa").child("seleccion").setValue(nombreLabel2.text )
        }
        if(check3.isOn){
           ref.child("configuracion").child("masa").child("precio").setValue(   precioLabel3.text  )
            ref.child("configuracion").child("masa").child("seleccion").setValue(nombreLabel3.text )
        }
        
    }
        // MARK: - Comprobar n· de seleccionados
    func viewCheck() {
        var cont = 0
        if(check1.isOn){
            cont += 1
        }
        if(check2.isOn){
            cont += 1
        }
        if(check3.isOn){
            cont += 1
        }
        
        if(cont == 1){
            estado = true
        }else{
            estado = false
            
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
