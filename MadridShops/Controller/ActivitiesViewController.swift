//  ActivitiesViewController.swift
//  MadridShops

import UIKit

class ActivitiesViewController: UIViewController {

    var activities: Activities?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let downloadActivitiesInteractor: DownloadAllActivitiesInteractor = DownloadAllActivitiesInteractorFakeImplementation()
        
        downloadActivitiesInteractor.execute { (activities: Activities) in
            print("Activity name: " + activities.get(index: 0).name)
        }
        
    }

}
