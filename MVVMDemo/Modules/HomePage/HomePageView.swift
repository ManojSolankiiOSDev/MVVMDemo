//
//  ViewController.swift
//  MVVMDemo
//
//  Created by MANOJ SOLANKI on 15/03/21.
//

import UIKit

class HomePageView: UIViewController,HomePageViewModelDelegate {
    
    // MARK: IBOutlets
    @IBOutlet weak var tblAPIList: UITableView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    // MARK: class variables
    lazy var homePageViewModel : HomePageViewModel = HomePageViewModel(delegate: self)
    
    // MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblAPIList.dataSource = self
        tblAPIList.delegate = self
        homePageViewModel.getAPIList()
    }
    
    // MARK: View Model Delegate Methods
    func fetchingDidStart() {
        print("Fetching started")
    }
    func fetchingFinished() {
        print("Fetching finished")
        DispatchQueue.main.async {
            self.tblAPIList.reloadData()
            self.tblAPIList.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
}

extension HomePageView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePageViewModel.arrAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiListCell")
        cell?.textLabel?.text = homePageViewModel.arrAPI[indexPath.row].apiName
        return cell!
    }
}
