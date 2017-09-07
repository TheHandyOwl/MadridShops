//  ViewController.swift
//  MadridShops

import UIKit

class ViewController: UIViewController {
    
    // Lo ponemos opcional porque se queja
    var shops: Shops?

    @IBOutlet weak var shopsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Este es el comodín que cambiaremos cuando lo hagamos de verdad
        let downloadShopsInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorFakeImplementation()
        /*
         downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
         // todo Ok
         }) { (error: Error) in
         // error
         }
         
         downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
         // todo Ok
         })
         */
        // Esto le manda un bloque que ejecutará más tarde en el execute
        downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
            // todo Ok
            print(shops.get(index: 0).name)
            self.shops = shops
            
            // Esto se activa aquí para tener alguna tienda
            // Si lo vinculamos antes no tendremos tiendas y no se mostrará nada
            self.shopsCollectionView.delegate = self
            self.shopsCollectionView.dataSource = self
            
        })
    }


}

