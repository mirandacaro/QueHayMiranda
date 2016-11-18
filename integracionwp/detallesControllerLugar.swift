//
//  detallesControllerLugar.swift
//  integracionwp
//
//  Created by Maestro on 15/11/16.
//  Copyright © 2016 miranda. All rights reserved.
//

import Foundation
import UIKit

class DetallesControllerLugar : UIViewController{

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblHorario: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var imgFotoPerfil: UIImageView!
    @IBOutlet weak var imgFoto: UIImageView!
    
    
    var lugar : Lugar?
    
    override func viewDidLoad() {
        
         self.title = lugar?.titulo
        
        lblDireccion.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDireccion.numberOfLines = 0
        lblDireccion.sizeToFit()
        
        lblDescripcion.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDescripcion.numberOfLines = 0
        lblDescripcion.sizeToFit()
        
        if let lugar = self.lugar{
            lblTitulo.text = lugar.titulo
            lblHorario.text = lugar.horario
            lblDescripcion.text = lugar.descripcion
            lblDireccion.text = lugar.direccion
            lblTelefono.text = lugar.telefono
            imgFoto.image = lugar.imgFoto
            imgFotoPerfil.image = lugar.imgFotoPerfil
            
        }
    }

}