//
//  IngredientesViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 01/07/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import FirebaseDatabase


class IngredientesViewController: UIViewController {

    
    @IBOutlet weak var nombreLabel1: UILabel!
    @IBOutlet weak var precioLabel1: UILabel!
    @IBOutlet weak var check1: UISwitch!
    
    @IBOutlet weak var nombreLabel2: UILabel!
    @IBOutlet weak var precioLabel2: UILabel!
    @IBOutlet weak var check2: UISwitch!
    
    @IBOutlet weak var nombreLabel3: UILabel!
    @IBOutlet weak var check3: UISwitch!
    @IBOutlet weak var precioLabel3: UILabel!
    
    @IBOutlet weak var nombreLabel4: UILabel!
    @IBOutlet weak var precioLabel4: UILabel!
    @IBOutlet weak var check4: UISwitch!
    
    @IBOutlet weak var nombreLabel5: UILabel!
    @IBOutlet weak var precioLabel5: UILabel!
    @IBOutlet weak var check5: UISwitch!
    
    @IBOutlet weak var nombreLabel6: UILabel!
    @IBOutlet weak var precioLabel6: UILabel!
    @IBOutlet weak var check6: UISwitch!
    
    @IBOutlet weak var nombreLabel7: UILabel!
    @IBOutlet weak var precioLabel7: UILabel!
    @IBOutlet weak var check7: UISwitch!
    
    @IBOutlet weak var nombreLabel8: UILabel!
    @IBOutlet weak var precioLabel8: UILabel!
    @IBOutlet weak var check8: UISwitch!
    
    @IBOutlet weak var nombreLabel9: UILabel!
    @IBOutlet weak var precioLabel9: UILabel!
    @IBOutlet weak var check9: UISwitch!
    
    private var estado:Bool = false
    private let ref = Database.database().reference()
      
    private var refTam: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Cargar los datos de Firebase
               refTam = ref.child("ingredientes")
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
                           }else if(cont == 3) {
                              self.nombreLabel4.text = String(tamNombre)
                               self.precioLabel4.text = String(tamPrecio)
                           }else if(cont == 4) {
                               self.nombreLabel5.text = String(tamNombre)
                               self.precioLabel5.text = String(tamPrecio)
                           }else if(cont == 5) {
                              self.nombreLabel6.text = String(tamNombre)
                               self.precioLabel6.text = String(tamPrecio)
                           }else if(cont == 6) {
                              self.nombreLabel7.text = String(tamNombre)
                               self.precioLabel7.text = String(tamPrecio)
                           }else if(cont == 7) {
                              self.nombreLabel8.text = String(tamNombre)
                               self.precioLabel8.text = String(tamPrecio)
                           }else if(cont == 8) {
                              self.nombreLabel9.text = String(tamNombre)
                               self.precioLabel9.text = String(tamPrecio)
                           }
                        
                           cont += 1
                          
                       }
                   }
                   
               })
    }
    
    @IBAction func finalAction(_ sender: Any) {
        viewCheck()
        if(estado == true){
            
            sendInformation()
            self.performSegue(withIdentifier: "pasoFinalPush", sender: IngredientesViewController.self)
        }else{
            self.showToast(message: "Seleccione de 1 a 5 opciones", font: .systemFont(ofSize: 12.0))

        }
    }
    
    
    // MARK: - Insertar los datos de Firebase
    func sendInformation(){
        var precio:Float64 = 0
        var seleccion:String = ""
        
        if(check1.isOn){
            precio += Float64(precioLabel1.text!)!
           seleccion = seleccion + nombreLabel1.text!
          
        }
        if(check2.isOn){
            precio += Float64(precioLabel2.text!)!
            seleccion = seleccion + ", " + nombreLabel2.text!
        }
        if(check3.isOn){
            precio += Float64(precioLabel3.text!)!
            seleccion = seleccion + ", " + nombreLabel3.text!
        }
        if(check4.isOn){
            precio += Float64(precioLabel4.text!)!
            seleccion = seleccion + ", " + nombreLabel4.text!
        }
        if(check5.isOn){
            precio += Float64(precioLabel5.text!)!
            seleccion = seleccion + ", " + nombreLabel5.text!
        }
        if(check6.isOn){
            precio += Float64(precioLabel6.text!)!
            seleccion = seleccion + ", " + nombreLabel6.text!
        }
        if(check7.isOn){
            precio += Float64(precioLabel7.text!)!
            seleccion = seleccion + ", " + nombreLabel7.text!
        }
        if(check8.isOn){
            precio += Float64(precioLabel8.text!)!
            seleccion = seleccion + ", " + nombreLabel8.text!
        }
        if(check9.isOn){
            precio += Float64(precioLabel9.text!)!
            seleccion = seleccion + ", " + nombreLabel9.text!
        }
        ref.child("configuracion").child("ingredientes").child("precio").setValue(   String(precio)  )
        ref.child("configuracion").child("ingredientes").child("seleccion").setValue(seleccion )
        
        
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
        if(check4.isOn){
            cont += 1
        }
        if(check5.isOn){
            cont += 1
        }
        if(check6.isOn){
            cont += 1
        }
        if(check7.isOn){
            cont += 1
        }
        if(check8.isOn){
            cont += 1
        }
        if(check9.isOn){
            cont += 1
        }
        
        if(cont > 0 && cont < 6 ){
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
