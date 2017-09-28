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
    @IBOutlet weak var connectionAlertLabel: UILabel!
    
    
    // MARK: - Variables
    var shops: Shops?
    var activities: Activities?
    let shopsFileToDownloadAndSaveOnce = "ShopsSavedOnce"
    let activitiesFileToDownloadAndSaveOnce = "ActivitiesSavedOnce"
    var allFilesToDownloadAndSaveOnce: [String] = []
    
    var context: NSManagedObjectContext!
    
    var reachability: Reachability?
    let hostNames = ["madrid-shops.com"]
    var hostIndex = 0
    
    
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
        
        connectionAlertLabel.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        connectionAlertLabel.layer.borderWidth = 2
        connectionAlertLabel.layer.cornerRadius = 5
        connectionAlertLabel.layer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        connectionAlertLabel.isHidden = true
    }
    
    func checkData() {
        loadingActivityOn()
        checkingDownloadedData()
        executeOnce ()
    }
    
    func loadingActivityOn() {
        customImageLoader.image = UIImage.animatedImageNamed("sprite_shopping_bags_", duration: 5)
        customImageLoader.isHidden = false
        
        activityLoader.isHidden = false
        activityLoader.startAnimating()
        
        buttonsOff()
    }
    
    func buttonsOff(){
        viewActivitiesButton.isHidden = true
        viewShopsButton.isHidden = true
    }
    
    func loadingActivityOff() {
        customImageLoader.image = UIImage.init(named: "Logo")
        
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
        
        buttonsOn()
        
        stopNotifier()
    }
    
    func buttonsOn() {
        viewActivitiesButton.isHidden = false
        viewShopsButton.isHidden = false
    }
    
    func checkingDownloadedData() {
        if CheckAllFilesSavedInteractorImpl().execute(fileNames: allFilesToDownloadAndSaveOnce){
            loadingActivityOff()
        } else {
            if !CheckGenericOnceInteractorImpl().execute(item: "startNetworkChecker"){
                SetGenericOnceInteractorImpl().execute(item: "startNetworkChecker")
                startNetworkChecker(at: 0)
            }
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
    
    
    // MARK: - Reachability
    func startNetworkChecker(at index: Int) {
        stopNotifier()
        setupReachability(hostNames[index], useClosures: true)
        startNotifier()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.startNetworkChecker(at: (index + 1) % 1)
        }
    }
    
    func setupReachability(_ hostName: String?, useClosures: Bool) {
        let reachability: Reachability?
        if let hostName = hostName {
            reachability = Reachability(hostname: hostName)
        } else {
            reachability = Reachability()
        }
        self.reachability = reachability
        
        if useClosures {
            reachability?.whenReachable = { reachability in
                self.updateLabelColourWhenReachable(reachability)
            }
            reachability?.whenUnreachable = { reachability in
                self.updateLabelColourWhenNotReachable(reachability)
            }
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
        }
    }
    
    func startNotifier() {
        do {
            try reachability?.startNotifier()
        } catch {
            return
        }
    }
    
    func stopNotifier() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability = nil
    }
    
    func updateLabelColourWhenReachable(_ reachability: Reachability) {
        connectionAlertLabel.isHidden = true
        checkData()
    }
    
    func updateLabelColourWhenNotReachable(_ reachability: Reachability) {
        self.connectionAlertLabel.isHidden = false
        self.stopNotifier()
        self.reachability = nil
        
        if !CheckGenericOnceInteractorImpl().execute(item: "alert") {
            SetGenericOnceInteractorImpl().execute(item: "alert")
            
            let alert = UIAlertController(title: "No data connection available", message: "Click Ok to reload", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default){
                UIAlertAction in
                RemoveGenericOnceInteractorImpl().execute(item: "alert")
            }
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    @objc func reachabilityChanged(_ note: Notification) {
        let reachability = note.object as! Reachability
        
        if reachability.connection != .none {
            updateLabelColourWhenReachable(reachability)
        } else {
            updateLabelColourWhenNotReachable(reachability)
        }
    }
    
    deinit {
        stopNotifier()
    }
    
    
    // MARK: - Segue
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
    
    
    // MARK: - IBActions

}
