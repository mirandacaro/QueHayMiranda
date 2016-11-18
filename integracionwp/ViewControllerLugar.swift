//
//  ViewController.swift
//  integracionwp
//
//  Created by Maestro on 03/11/16.
//  Copyright © 2016 miranda. All rights reserved.
//

import UIKit
import Alamofire


class ViewControllerLugar : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvLugares: UITableView!
    var lugares : [Lugar] = []
  
    //http://quehayobson3.azurewebsites.net/api/get_posts/?post_type=lugar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Lugares"
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor(),
             NSFontAttributeName: UIFont(name: "Arciform", size: 20)!]
        
        //imprimir la direccion del primer lugar
        Alamofire.request(.GET,
            "https://quehayobson3.azurewebsites.net/api/get_posts/",
            parameters: ["post_type": "lugar"])
            .responseJSON { response in
            /*    print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
            */
                
                if let diccionarioRespuesta = response.result.value as? NSDictionary {
                    //self.lblDireccion.text = String(diccionarioRespuesta.valueForKey("count_total") as! Int)
                    if let posts = diccionarioRespuesta.valueForKey("posts") as?NSArray {
                        for post in posts {
                            if let diccionarioPost = post as? NSDictionary{
                                self.lugares.append(Lugar(diccionario: diccionarioPost, callback: self.actualizarTableViewLugares))
                            }
                        }
                        
                        self.tvLugares.reloadData()
                        
                    }
                }
            }
    
    }
    
    func actualizarTableViewLugares(){
        tvLugares.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lugares.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCellWithIdentifier("celdaLugar") as! LugarCelda
        celda.lblNombre.text = lugares[indexPath.row].titulo
        if let imagen = lugares[indexPath.row].imgFoto {
            celda.imgFondo.image = imagen
        }
        return celda
    
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToDetalles"{
            let detallesControllerLugar = segue.destinationViewController as! DetallesControllerLugar
            detallesControllerLugar.lugar = lugares[(tvLugares.indexPathForSelectedRow?.row)!]
        }
    }

}

