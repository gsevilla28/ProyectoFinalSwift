//
//  ViewControllerDetail.swift
//  agendaDummy
//
//  Created by Jerry on 3/25/17.
//  Copyright © 2017 Jerry. All rights reserved.
//

import UIKit

class ViewControllerDetail: UIViewController {
    
    
    var nombreDetalle:String?
    var telefonoDetalle:String?
    var correoDetalle:String?
    
    
    var objectDetail:Agenda?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblNombre.text = "Nombre: \(self.objectDetail!.nombre!)"
        self.lblTelefono.text = "Telefono: \(self.objectDetail!.telefono!)"
        self.lblCorreo.text = "Correo: \(self.objectDetail!.correo!)"
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblCorreo: UILabel!

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
