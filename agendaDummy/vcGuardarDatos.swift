//
//  vcGuardarDatos.swift
//  agendaDummy
//
//  Created by Jerry on 3/18/17.
//  Copyright © 2017 Jerry. All rights reserved.
//

import UIKit
import CoreData

class vcGuardarDatos: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtConfirmarTelefono: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    
    
    
    
    @IBAction func btnGuardarDatos(sender: AnyObject) {
        
        var msj=""
        
        if txtNombre.text == "" {
            msj = "El nombre del contacto es forzoso"
        }
        else if txtTelefono.text == "" {
            msj = "El numero de telefono es fozoso"
        }
        else if txtConfirmarTelefono.text == "" {
            msj = "La confirmacion del numero de telefono es querida"
        }
        
        if msj != "" {
            let alert = UIAlertController(title: "Atencion", message: msj, preferredStyle: .Alert)
            let ac = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(ac)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            //inicia validacion particular del largo del telefono
            var msjTel = ""
            if(!validarLengthTelfono()){
                msjTel = "El telefono debe contener 10 digitos"
                
                let alert = UIAlertController(title: "Atencion", message: msjTel, preferredStyle: .Alert)
                let ac = UIAlertAction(title: "OK", style: .Default, handler: nil)
                
                alert.addAction(ac)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else{
                
                //inicia validacion de la confirmacion del telefono
                if !validarConfirmacionTelefono() {
                    
                    msjTel = "El telefono y su confirmacion no coinciden"
                    
                    let alert = UIAlertController(title: "Atencion", message: msjTel, preferredStyle: .Alert)
                    let ac = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    alert.addAction(ac)
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else{
                    //inicia validacion del correo electronico
                    
                    if txtCorreo.text?.characters.count > 0 {
                        if !validaCorreo(){
                            msjTel = "si se indica un correo debe tener el siguiente formato: nombre@dominio.com"
                            
                            let alert = UIAlertController(title: "Atencion", message: msjTel, preferredStyle: .Alert)
                            let ac = UIAlertAction(title: "OK", style: .Default, handler: nil)
                            
                            alert.addAction(ac)
                            
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                        else{
                            //todos los campos estan correcto
                            print("TODO ESTUVO CORRECTO")
                            guardarDatos()
                        }
                    }else{
                        // todos los campos estuvieron correctos y no se indico un correo
                        print("TODO ESTUVO CORRECTO  PERO SIN CORREO")
                        guardarDatos()
                    }
                    
                    
                }
                
            }
            
            
            
            
        }
        
    
    }
    
    func validaCorreo() -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            
         return emailTest.evaluateWithObject(txtCorreo?.text)
        
    }
    
    func validarLengthTelfono() -> Bool {
        if txtTelefono.text?.characters.count != 10{
            return false
        }
        
        return true
    }
    
    func validarConfirmacionTelefono() -> Bool {
        
        if txtTelefono.text! == txtConfirmarTelefono.text! {
            return true
        }
        
        
        return false
        
    }
    
    func guardarDatos(){
        
        let entityInfo = NSEntityDescription.entityForName("Agenda", inManagedObjectContext: DBManager.instance.managedObjectContext!)
        
        let newContacto = NSManagedObject.init(entity: entityInfo!, insertIntoManagedObjectContext: DBManager.instance.managedObjectContext) as! Agenda
        
        newContacto.nombre = txtNombre.text
        newContacto.telefono = txtTelefono.text
        newContacto.correo = txtCorreo.text
        
        do{
            try DBManager.instance.managedObjectContext!.save()
            //self.navigationController?.popViewControllerAnimated(true)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        catch{
            print("Error al salvar en DB")
        }
        
        
        
    }
    
    
    
    
    
    
    
    @IBAction func touchPrincipal(sender: AnyObject) {
        self.view.endEditing(true)
    }
   
    @IBAction func btnCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
/*func RegistrarNotificacionTeclado(){
    //print("Add NotificationCenter"
    
    NotificationCenter.default.addObserver(self, selector: #selector(vcGurdarDatos.TecladoAparece), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(VC_PropiedadTag.TecladoDesaparece), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
}*/
