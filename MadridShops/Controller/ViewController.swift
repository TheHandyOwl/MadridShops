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
        //let downloadShopsInteractor : DownloadAllShopsInteractor = DownloadAllShopsInteractorFakeImplementation()
        //let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSOpImpl()
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
        /*
         downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
         // todo OK
         }) { (error: Error) in
         // error
         }
         
         downloadShopsInteractor.execute(onSuccess: { (shops: Shops) in
         // todo OK
         })
         */
        
        downloadShopsInteractor.execute { (shops: Shops) in
            // todo OK
            print("Name: " + shops.get(index: 0).name)
            self.shops = shops
            
            // Esto se activa aquí para tener alguna tienda
            // Si lo vinculamos antes no tendremos tiendas y no se mostrará nada
            self.shopsCollectionView.delegate = self
            self.shopsCollectionView.dataSource = self
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let shop = self.shops?.get(index: indexPath.row)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController // Es un IUVC
            // HAcemos casting minuto 90 aprox
            
            // let indexPath = self.shopsCollectionView.indexPathsForSelectedItems![0]
            // let shop = self.shops?.get(index: indexPath.row)
            //vc.shop = shop
            vc.shop = sender as! Shop
            
        }
    }
    
}
