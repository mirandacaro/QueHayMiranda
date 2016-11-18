//
//  Evento.swift
//  integracionwp
//
//  Created by Maestro on 15/11/16.
//  Copyright © 2016 miranda. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Evento {
    
    
    var titulo : String
    var fecha : String
    var horario : String
    var direccion : String
    var precio : String?
    var descripcion : String 
     
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
     fecha=""
     horario=""
     direccion=""
     precio=""
     descripcion=""
    }
    
    init(diccionario : NSDictionary, callback: (() -> Void)?){
        
        titulo=""
        fecha=""
        horario=""
        direccion=""
        precio=""
        descripcion=""
        
        if let titulo = diccionario.valueForKey("title_plain") as? String {
            self.titulo = titulo
        }
        
        if let customFields = diccionario.valueForKey("custom_fields") as? NSDictionary {
            
            if let fecha = customFields.valueForKey("fecha") as? NSArray{
                if let valorDescripcion = fecha[0] as? String{
                    self.fecha = valorDescripcion
                }
            }
            
            if let horario = customFields.valueForKey("horario") as? NSArray{
                if let valorDescripcion = horario[0] as? String{
                    self.horario = valorDescripcion
                }
            }
            
            if let precio = customFields.valueForKey("precio") as? NSArray{
                if let valorDescripcion = precio[0] as? String{
                    self.precio = valorDescripcion
                }
            }
            
            if let direccion = customFields.valueForKey("direccion") as? NSArray{
                if let valorDireccion = direccion[0] as? String{
                    self.direccion = valorDireccion
                }
            }
            
            if let descripcion = customFields.valueForKey("descripcion") as? NSArray{
                if let valorDescripcion = descripcion[0] as? String{
                    self.descripcion = valorDescripcion
                }
            }
            
        }
        
        if let attachments = diccionario.valueForKey("attachments") as? NSArray{
            if attachments.count > 0 {
                //Imagen Fondo
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
                //Imagen Perfil
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
        //poner imagen e imagen generica en foto perfil
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
