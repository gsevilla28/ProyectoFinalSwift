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
    
    var estaArriba:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.registrarNotificacionTeclado()
        registrarTextCorreo()
        
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: txtCorreo)
        
        print("Quit all notifications")
        
        
    }
    func registrarNotificacionTeclado(){
        print("Add NotificationCenter")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(vcGuardarDatos.tecladoAparece), name: UIKeyboardDidShowNotification, object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(vcGuardarDatos.teclaBaja(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func registrarTextCorreo() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.formatoCorreo), name: UITextFieldTextDidChangeNotification, object: txtCorreo)
        
        
    }
    func formatoCorreo() {
        if txtCorreo.text?.characters.count>0{
            outletbtnGuardar.enabled = false
            
            if  validaCorreo(){
                outletbtnGuardar.enabled = true
            }
            else{
                outletbtnGuardar.enabled = false

            }
        }
        else{
            outletbtnGuardar.enabled = true
        }
        
        
    }
    
    func tecladoAparece(notification:NSNotification) {
        
        if estaArriba {
            return
        }
        
        let info: NSDictionary = (notification.userInfo! as NSDictionary)
        
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue() //obtener el tamaño del teclado
        
        print("el teclado APARECE")
        print("keyboardSize \(keyboardSize.height)" )
        
        
        
        var contentSize:CGSize = self.view.bounds.size
        contentSize.height = (self.view.bounds.size.height + (keyboardSize.height - 40))
        
        self.elScrollView.contentSize = contentSize
        print("contentSize: \(contentSize)" )
        
        estaArriba = true

    }
    func teclaBaja(notification: NSNotification){
        
        print("el teclado se va a ocultar")
        let info: NSDictionary = (notification.userInfo! as NSDictionary)
        
        let sizeKeyBoard = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        
        print("el teclado DESPARECE")
        print("keyboardSize \(sizeKeyBoard)" )
        
        
        var contentSize:CGSize = elScrollView.contentSize
        
        //var contentSize:CGSize = self.view.bounds.size
        
        contentSize.height = (elScrollView.contentSize.height - (sizeKeyBoard.height + 50))
        
        self.elScrollView.contentSize = contentSize
        print("contentSize: \(contentSize)" )
	
        self.estaArriba = false
    }
    
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtConfirmarTelefono: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var elScrollView: UIScrollView!
    
    @IBOutlet weak var elNavigationView: UINavigationItem!
    
    @IBOutlet weak var outletbtnGuardar: UIButton!
    
    
    @IBAction func btnGuardarDatos(sender: AnyObject) {
        
        var msj=""
        
        if txtNombre.text == "" {
            msj = "El nombre del contacto es forzoso"
        }
        else if txtTelefono.text == "" {
            msj = "El numero de telefono es fozoso"
        }
        else if txtConfirmarTelefono.text == "" {
            msj = "La confirmacion del numero de telefono es requerida"
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
    //valida correo con expresion regular
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
