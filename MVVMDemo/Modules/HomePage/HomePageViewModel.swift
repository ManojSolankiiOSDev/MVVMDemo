//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by MANOJ SOLANKI on 15/03/21.
//

import Foundation

protocol HomePageViewModelDelegate {
    func fetchingDidStart()
    func fetchingFinished()
}

class HomePageViewModel : ServiceManager{
    // MARK: Class variables
    var delegate : HomePageViewModelDelegate!
    var arrAPI : [APIModel] = []
    
    // MARK: Initilizer
    init(delegate:HomePageViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: Class Methods
    func getAPIList() -> Void {
        delegate.fetchingDidStart()
        self.requestServer(BASE_URL+ENTRIES, withParams: nil, andCompletion: { [self]response in
            
            switch response{
                case .success(let dict):
                    guard let modelAPIsList = try? JSONDecoder().decode(APIsList.self,from:dict) else{
                        return
                    }
                    self.arrAPI = modelAPIsList.apiModels
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            self.delegate.fetchingFinished()
        })
    }
}
