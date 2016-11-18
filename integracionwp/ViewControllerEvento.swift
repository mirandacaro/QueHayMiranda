//
//  ViewControllerEvento.swift
//  integracionwp
//
//  Created by Maestro on 15/11/16.
//  Copyright © 2016 miranda. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ViewControllerEvento : UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tvEventos: UITableView!
    var eventos : [Evento] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Eventos"       
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor(),
             NSFontAttributeName: UIFont(name: "Arciform", size: 20)!]

        
        Alamofire.request(.GET, "https://quehayobson3.azurewebsites.net/api/get_posts/", parameters: ["post_type": "evento"]).responseJSON{ response in
            if let diccionarioRespuesta = response.result.value as? NSDictionary {
                if let posts = diccionarioRespuesta.valueForKey("posts") as? NSArray{
                    for post in posts{
                        if let diccionarioPost = post as? NSDictionary{
                            self.eventos.append(Evento(diccionario: diccionarioPost, callback: self.actualizarTableViewEventos))
                        }
                    }
                    self.tvEventos.reloadData()
                }
            }
        }
    }
    
    func actualizarTableViewEventos(){
        tvEventos.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCellWithIdentifier("celdaEvento") as! EventoCelda
        celda.lblNombreEvento.text = eventos[indexPath.row].titulo
        if let imagen = eventos[indexPath.row].imgFoto {
            celda.imgFondoEvento.image = imagen
        }
        return celda
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetallesEvento"{
            let detallesControllerEvento = segue.destinationViewController as! DetallesControllerEvento
            detallesControllerEvento.evento = eventos[(tvEventos.indexPathForSelectedRow?.row)!]
        }
    }
}