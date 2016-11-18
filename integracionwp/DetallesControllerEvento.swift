
//
//  DetallesControllerEvento.swift
//  integracionwp
//
//  Created by Maestro on 15/11/16.
//  Copyright © 2016 miranda. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class DetallesControllerEvento : UIViewController {
    
    var evento : Evento?

    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var imgFotoPerfil: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lbldireccion: UILabel!
    @IBOutlet weak var lblHorario: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    
    /*func maskImage(image:UIImage, mask:(UIImage))->UIImage{
        
        let imageReference = image.CGImage
        let maskReference = mask.CGImage
        
        let imageMask = CGImageMaskCreate(CGImageGetWidth(maskReference), CGImageGetHeight(maskReference), CGImageGetBitsPerComponent(maskReference), CGImageGetBitsPerPixel(maskReference), CGImageGetBytesPerRow(maskReference), CGImageGetDataProvider(maskReference), nil, true)
        
        let maskedReference = CGImageCreateWithMask(imageReference, imageMask)
        
        let maskedImage = UIImage(CGImage:maskedReference!)
        
        return maskedImage
    }*/
    
    override func viewDidLoad() {
        
        self.title = evento?.titulo
        
        lbldireccion.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lbldireccion.numberOfLines = 0
        lbldireccion.sizeToFit()
        
        lblDescripcion.lineBreakMode = NSLineBreakMode.ByWordWrapping
        lblDescripcion.numberOfLines = 0
        lblDescripcion.sizeToFit()
      
        //let maskingImage = UIImage(named: "mask4")
        
        if let evento = self.evento{
            lblTitulo.text = evento.titulo
            lblFecha.text = evento.fecha
            lblPrecio.text = evento.precio
            lbldireccion.text = evento.direccion
            lblDescripcion.text = evento.descripcion
            imgFoto.image = evento.imgFoto
            imgFotoPerfil.image = evento.imgFotoPerfil
            lblHorario.text = evento.horario
            //imgFotoPerfil.image = maskImage(evento.imgFotoPerfil!, mask: maskingImage!)
        }
    }
    
    
}