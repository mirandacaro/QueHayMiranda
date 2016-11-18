//
//  File.swift
//  integracionwp
//
//  Created by Maestro on 04/11/16.
//  Copyright © 2016 miranda. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Lugar{

    var titulo : String
    var descripcion : String
    var direccion : String
    var telefono : String
    var horario : String
    
    var urlFoto : String?
    var imgFoto : UIImage?
    
    var urlThumbnail : String?
    var imgThumbnail: UIImage?
    
    var urlFotoPerfil : String?
    var imgFotoPerfil : UIImage?
    
    var urlThumbnailPerfil : String?
    var imgThumbnailPerfil: UIImage?
    
    init(){
        titulo=""
        descripcion=""
        direccion=""
        telefono=""
        horario=""
        
        
    }
    
    init(diccionario : NSDictionary, callback: (() -> Void)?){
        
        titulo=""
        descripcion=""
        direccion=""
        telefono=""
        horario=""
        
        if let titulo = diccionario.valueForKey("title_plain") as? String {
            self.titulo = titulo
        }
        
        if let customFields = diccionario.valueForKey("custom_fields") as? NSDictionary {
            
            if let descripcion = customFields.valueForKey("descripcion") as? NSArray{
                if let valorDescripcion = descripcion[0] as? String{
                    self.descripcion = valorDescripcion
                }
            }
            
            if let direccion = customFields.valueForKey("direccion") as? NSArray{
                if let valorDireccion = direccion[0] as? String{
                    self.direccion = valorDireccion
                }
            }
            
            if let telefono = customFields.valueForKey("telefono") as? NSArray{
                if let valorTelefono = telefono[0] as? String{
                    self.telefono = valorTelefono
                }
            }
            
            if let horario = customFields.valueForKey("horario") as? NSArray{
                if let valorHorario = horario[0] as? String{
                    self.horario = valorHorario
                }
            }
            
        }
        
        if let attachments = diccionario.valueForKey("attachments") as? NSArray{
            if attachments.count > 0 {
                if let imagen = attachments[0] as? NSDictionary {
                    if let urlImagen = imagen.valueForKey("url") as? String{
                        self.urlFoto = urlImagen
                        
                    }
                    if let images = imagen.valueForKey("images") as? NSDictionary{
                        if let thumbnail = images.valueForKey("thumbnail") as? NSDictionary{
                            if let urlImgThumbnail = thumbnail.valueForKey("url") as? String{
                                self.urlThumbnail = urlImgThumbnail
                            }
                        }
                    }
                }
                
                if let imagen = attachments[1] as? NSDictionary {
                    if let urlImagen = imagen.valueForKey("url") as? String{
                        self.urlFotoPerfil = urlImagen
                    }
                    if let images = imagen.valueForKey("images") as? NSDictionary{
                        if let thumbnail = images.valueForKey("thumbnail") as? NSDictionary{
                            if let urlImgThumbnailPerfil = thumbnail.valueForKey("url") as? String{
                                self.urlThumbnailPerfil = urlImgThumbnailPerfil
                            }
                        }
                    }
                }
            }
        }
        //poner imagen de fondo
        if let urlFoto = self.urlFoto{
            Alamofire.request(.GET, urlFoto, parameters: [:]).responseData(completionHandler: {
                response in
                if let data = response.data{
                    self.imgFoto = UIImage(data: data)
                    if let funcionCallback = callback{
                        funcionCallback()
                    }
                }
            })
        } else{
          self.imgFoto = UIImage(named: "sonora")
        }
        //poner imagen de perfil
        if let urlFotoPerfil = self.urlFotoPerfil{
            Alamofire.request(.GET, urlFotoPerfil, parameters: [:]).responseData(completionHandler: {
                response in
                if let data = response.data{
                    self.imgFotoPerfil = UIImage(data: data)
                    if let funcionCallback = callback{
                        funcionCallback()
                    }
                }
            })
        } else{
            self.imgFotoPerfil = UIImage(named: "sonora")
        }
        
    }


}

   //constructor: metodo que inicializa, I N I T es la respuesta
    //el signo de interrogacion en una variable "?" es que el dato es opcional