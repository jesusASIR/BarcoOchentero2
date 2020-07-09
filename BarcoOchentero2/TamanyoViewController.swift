//
//  TamanyoViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 29/06/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TamanyoViewController: UIViewController {
    
    @IBOutlet weak var nombreLabel1: UILabel!
    @IBOutlet weak var imagen1: UIImageView!
    @IBOutlet weak var precioLabel1: UILabel!
    @IBOutlet weak var check1: UISwitch!
    
    @IBOutlet weak var nombreLabel2: UILabel!
    @IBOutlet weak var imagen2: UIImageView!
    @IBOutlet weak var check2: UISwitch!
    @IBOutlet weak var precioLabel2: UILabel!
    
    @IBOutlet weak var nombreLable3: UILabel!
    @IBOutlet weak var imagen3: UIImageView!
    @IBOutlet weak var check3: UISwitch!
    @IBOutlet weak var precioLabel3: UILabel!
    
    private var estado:Bool = false
    private let ref = Database.database().reference()
    
    private var refTam: DatabaseReference!
    private var tamList: NSHashTable<AnyObject>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Cargar los datos de Firebase
        refTam = ref.child("tamaños")
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
                       self.nombreLable3.text = String(tamNombre)
                        self.precioLabel3.text = String(tamPrecio)
                    }
                    cont += 1
                   
                }
            }
            
        })
    }
   
    
    @IBAction func paso2Action(_ sender: Any) {
        viewCheck()
        if(estado == true){
            
            sendInformation()            
            self.performSegue(withIdentifier: "push", sender: TamanyoViewController.self)
        }else{
            self.showToast(message: "Seleccione una opcion", font: .systemFont(ofSize: 12.0))

        }
        
    }
      // MARK: - Insertar los datos de Firebase
    func sendInformation(){
        if(check1.isOn){
            ref.child("configuracion").child("tamaño").child("precio").setValue(   precioLabel1.text  )
            ref.child("configuracion").child("tamaño").child("seleccion").setValue(nombreLabel1.text )
        }
        if(check2.isOn){
            ref.child("configuracion").child("tamaño").child("precio").setValue(   precioLabel2.text  )
            ref.child("configuracion").child("tamaño").child("seleccion").setValue(nombreLabel2.text )
        }
        if(check3.isOn){
           ref.child("configuracion").child("tamaño").child("precio").setValue(   precioLabel3.text  )
            ref.child("configuracion").child("tamaño").child("seleccion").setValue(nombreLable3.text )
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
 // MARK: - Funcion para hacer Toast
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
