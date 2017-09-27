//  MainViewController.swift
//  MadridShops

import UIKit
import CoreData

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var customImageLoader: UIImageView!    
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var viewActivitiesButton: UIButton!
    @IBOutlet weak var viewShopsButton: UIButton!
    
    // MARK: - Variables
    var shops: Shops?
    var activities: Activities?
    let shopsFileToDownloadAndSaveOnce = "ShopsSavedOnce"
    let activitiesFileToDownloadAndSaveOnce = "ActivitiesSavedOnce"
    var allFilesToDownloadAndSaveOnce: [String] = []
    
    var context: NSManagedObjectContext!

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allFilesToDownloadAndSaveOnce = [shopsFileToDownloadAndSaveOnce, activitiesFileToDownloadAndSaveOnce]
        
        setupUI()
        checkData()
       
    }
    
    // MARK: - Setting Up Interface
    func setupUI(){
        viewActivitiesButton.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        viewActivitiesButton.layer.borderWidth = 2
        viewActivitiesButton.layer.cornerRadius = 5
        viewShopsButton.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        viewShopsButton.layer.borderWidth = 2
        viewShopsButton.layer.cornerRadius = 5
    }
    
    func checkData() {
        refreshingOn()
        checkingDownloadedData()
        executeOnce ()
    }
    
    func refreshingOn(){
        customImageLoader.image = UIImage.animatedImageNamed("sprite_shopping_bags_", duration: 5)
        customImageLoader.isHidden = false
        
        activityLoader.isHidden = false
        activityLoader.startAnimating()
        
        viewActivitiesButton.isHidden = true
        viewShopsButton.isHidden = true
    }
    
    func refreshingOff(){
        customImageLoader.image = UIImage.init(named: "Logo")
        
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
        
        viewActivitiesButton.isHidden = false
        viewShopsButton.isHidden = false
    }
    
    func checkingDownloadedData() {
        if CheckAllFilesSavedInteractorImpl().execute(fileNames: allFilesToDownloadAndSaveOnce){
            refreshingOff()
        }
    }
    
    // MARK: - Downloading data
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
                self.checkingDownloadedData()
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
                self.checkingDownloadedData()
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
