//  MainViewController.swift
//  MadridShops

import UIKit
import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var customImageLoader: UIImageView!    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    var shops: Shops?
    var activities: Activities?
    let shopsFileToDownloadAndSaveOnce = "ShopsSavedOnce"
    let activitiesFileToDownloadAndSaveOnce = "ActivitiesSavedOnce"
    
    var context: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshingOn()
        
        if CheckAllFilesSavedInteractorImpl().execute(fileNames: [self.shopsFileToDownloadAndSaveOnce, self.activitiesFileToDownloadAndSaveOnce]){
            refreshingOff()
        }
        
        executeOnce ()
       
    }
    

    
    func refreshingOn(){
        activityLoader.isHidden = false
        activityLoader.startAnimating()
        customImageLoader.image = UIImage.animatedImageNamed("sprite_shopping_bags_", duration: 5)
        customImageLoader.isHidden = false
    }
    
    func refreshingOff(){
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
        customImageLoader.image = UIImage.init(named: "Logo")
    }
    
    func executeOnce() {
        
        ExecuteOnceInteractorImpl().execute(item: self.shopsFileToDownloadAndSaveOnce) {
            initializedShopsData()
        }
        ExecuteOnceInteractorImpl().execute(item: self.activitiesFileToDownloadAndSaveOnce) {
            initializedActivitiesData()
        }
        
    }
    
    func initializedShopsData() {
        let downloadShopsInteractor: DownloadAllShopsInteractor = DownloadAllShopsInteractorNSURLSessionImpl()
        
        downloadShopsInteractor.execute { (shops: Shops) in
            self.shops = shops
            
            let cacheInteractor = SaveAllShopsInteractorImpl()
            cacheInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                SetExecutedOnceInteractorImpl().execute(item: self.shopsFileToDownloadAndSaveOnce)
                if CheckAllFilesSavedInteractorImpl().execute(fileNames: [self.shopsFileToDownloadAndSaveOnce, self.activitiesFileToDownloadAndSaveOnce]){
                    self.refreshingOff()
                }
            })
        }
    }
    
    func initializedActivitiesData() {
        let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSURLSessionImpl()
        
        downloadActivitiesInteractor.execute { (activities: Activities) in
            self.activities = activities
            
            let cacheInteractor = SaveAllActivitiesInteractorImpl()
            cacheInteractor.execute(activities: activities, context: self.context, onSuccess: { (activities: Activities) in
                SetExecutedOnceInteractorImpl().execute(item: self.activitiesFileToDownloadAndSaveOnce)
                if CheckAllFilesSavedInteractorImpl().execute(fileNames: [self.shopsFileToDownloadAndSaveOnce, self.activitiesFileToDownloadAndSaveOnce]){
                    self.refreshingOff()
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        //Hay que poner el Segue
        if segue.identifier == "ShowShopsSegue" {
            let vc = segue.destination as! ViewController
            vc.context = self.context
        }

        if segue.identifier == "ShowActivitiesSegue" {
            let vc = segue.destination as! ActivitiesViewController
            vc.context = self.context
        }
        
    }

}
