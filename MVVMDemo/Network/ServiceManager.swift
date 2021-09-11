//
//  ServiceManager.swift
//  MVVMDemo
//
//  Created by MANOJ SOLANKI on 10/09/21.
//

import Foundation

enum ServiceResponse<T,error : Error> {
    case success(T)
    case failure(error)
}

enum HTTPError : Error {
    case requestTimedOut
    case networkError
    case jsonError
}

class ServiceManager {
    
    private var dataTask : URLSessionDataTask?
    
    func requestServer(
        _ strUrl: String,
        withParams params: [AnyHashable: Any]?,
        andCompletion completionBlock: @escaping (_ serviceResponse: ServiceResponse<Data,HTTPError>) -> Void){
        
        let request = NSMutableURLRequest(url: NSURL(string: strUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared        
        dataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { [weak self] (data, response, error) -> Void in
                
            if (error != nil) {
                completionBlock(.failure(.networkError))
            } else {
                if data != nil{
                    completionBlock(.success(data! as Data))
                }else{
                    completionBlock(.failure(.jsonError))
                }
            }
            self?.dataTask = nil
        })
        dataTask!.resume()
    }
}
