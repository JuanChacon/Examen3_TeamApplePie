//
//  ViewController.swift
//  2DA_EVA_EXA_PLAT1_PRAC2
//
//  Created by  on 05/04/17.
//
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var row = 0
    var cal = ""
    var indexado:Int = 0
    
    var arreglo: NSMutableArray = []
    
    @IBOutlet weak var miTableView: UITableView!
    
    @IBAction func btnAgregar(sender: UIButton) {
        performSegueWithIdentifier("agregar", sender: self)
    }
    
    var nombreRest = ["Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante","Nombre Restaurante"]
    //Creamos el segundo array para introducir las imagenes asociadas a los datos que se colocaran en cada celda
    var imgFondo = ["ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa","ico-tasa"]
    var imgStar = [["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"],["star-a","star-a","star-a"]]
    
    var descRes = ["Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción","Descripción"]
    var dirTel = ["Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono","Dirección y Teléfono"]
    
    func obtenRuta() -> NSURL {
        let tempDir = NSTemporaryDirectory()
        let tempoDirURL = NSURL(fileURLWithPath: tempDir)
        let tempDirFile = tempoDirURL.URLByAppendingPathComponent("restaurants.plist")
        return tempDirFile
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ruta = obtenRuta()
        if(NSFileManager.defaultManager().fileExistsAtPath(ruta.path!)){
            arreglo = NSMutableArray(contentsOfURL: ruta)!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Se crearan las celdas correspondientes al numero de datos
            return (arreglo.count)/7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCellWithIdentifier("myCell") as! TableViewCellMia
        
        celda.lblNombre.text = arreglo[(indexPath.row)*7] as? String
        celda.lblDesc.text = arreglo[((indexPath.row)*7)+1] as? String
        celda.lblDirTel.text = arreglo[((indexPath.row)*7)+2] as? String
        celda.star1.image = UIImage(named: imgStar[indexPath.row][0])
        celda.star2.image = UIImage(named: imgStar[indexPath.row][1])
        celda.star3.image = UIImage(named: imgStar[indexPath.row][2])
        
        let arregloimagen = arreglo[((indexPath.row)*7)+3] as? String
        let img = UIImage(named: arregloimagen!)
        celda.imgImagen.image = img
        return celda
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let compartirAct = UITableViewRowAction(style: .Default, title: "Compartir", handler: comparteRest)
        let capturarRest = UITableViewRowAction(style: .Default, title: "Eliminar", handler: eliminar)
        let calificarRest = UITableViewRowAction(style: .Default, title: "Calificar", handler: {action in self.performSegueWithIdentifier("calificar", sender: self)})
        
        
        calificarRest.backgroundColor = UIColor.blueColor()
        capturarRest.backgroundColor = UIColor.purpleColor()
        
        row = (indexPath.row)
        
        return [calificarRest,capturarRest,compartirAct]
    }
    
    func comparteRest(action: UITableViewRowAction, indexPath: NSIndexPath) -> Void {
        let miTexto = "Vine a comer en " + (arreglo[(indexPath.row)*7] as! String)
        let miImagen = UIImage(named: (arreglo[((indexPath.row)*7)+3] as? String)!)
        let califica = imgStar[indexPath.row]
        var calif = ""
        if califica == ["star-b","star-a","star-a"] {
            calif = "Malo"
        } else if califica == ["star-b","star-b","star-a"] {
            calif = "Bueno"
        } else if califica == ["star-b","star-b","star-b"]{
            calif = "Muy Bueno"
        } else {
            calif = "Sin Calificar"
        }
        let actController = UIActivityViewController(activityItems: [miTexto, "Calificado como: "+calif, miImagen!], applicationActivities: nil)
        presentViewController(actController, animated: true, completion: nil)
    }
    
    func eliminar(action: UITableViewRowAction, indexPath: NSIndexPath) -> Void{
        
        let ruta = obtenRuta()
        arreglo.removeObjectAtIndex((row*7)+6)
        arreglo.removeObjectAtIndex((row*7)+5)
        arreglo.removeObjectAtIndex((row*7)+4)
        arreglo.removeObjectAtIndex((row*7)+3)
        arreglo.removeObjectAtIndex((row*7)+2)
        arreglo.removeObjectAtIndex((row*7)+1)
        arreglo.removeObjectAtIndex((row*7))
        arreglo.writeToURL(ruta, atomically: true)
        134567
        miTableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "calificar" {
            let miViewController = segue.destinationViewController as! CalificarViewController
                miViewController.nombreRtr = nombreRest[row]
                miViewController.descRtr = descRes[row]
                miViewController.direcTel = dirTel[row]
                miViewController.imagenRtr = imgFondo[row]
                miViewController.rowe = row
        }
        if segue.identifier == "agregar" {
            let miDestinViewController = segue.destinationViewController as! CapturarViewController
            miDestinViewController.row = row
        }
    }
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        let miView = unwindSegue.sourceViewController as! CapturarViewController
        
        let ruta = obtenRuta()
        let sCade0 = miView.Name
        let sCade1 = miView.Des
        let sCade2 = miView.Dirt
        let sCade3 = miView.img
        
        arreglo.addObject(sCade0)
        arreglo.addObject(sCade1)
        arreglo.addObject(sCade2)
        arreglo.addObject(sCade3)
        arreglo.addObject("star-a")
        arreglo.addObject("star-a")
        arreglo.addObject("star-a")
        
        arreglo.writeToURL(ruta, atomically: true)
        miTableView.reloadData()
        
    }
    
    @IBAction func unodfwindForSegue(unwindSegue: UIStoryboardSegue) {
        
        let miViewe = unwindSegue.sourceViewController as! CalificarViewController
        cal = miViewe.calificacion
        indexado = miViewe.rowe
        if cal == "Malo" {
            imgStar[indexado] = ["star-b","star-a","star-a"]
            arreglo.addObject(arreglo)
        } else if cal == "Bueno" {
            imgStar[indexado] = ["star-b","star-b","star-a"]
        } else if cal == "Muy Bueno" {
            imgStar[indexado] = ["star-b","star-b","star-b"]
        }
        miTableView.reloadData()
        
    }
    
}

