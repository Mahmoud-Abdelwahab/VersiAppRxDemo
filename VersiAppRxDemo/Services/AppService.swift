//
//  AppService.swift
//  VersiAppRxDemo
//
//  Created by Asis on 3/21/21.
//

import Foundation
import Moya


enum AppService {
    case getSwiftRepos
    case searchForRepos(_ searchKey: String)
}

extension AppService : TargetType{
    var baseURL: URL {
        return URL(string: "https://api.github.com/search")!
    }
    //https://api.github.com/search/repositories?q=Swift&sort=stars&order=desc
    
    var path: String {
        switch self {
        
        case .getSwiftRepos , .searchForRepos(_):
            return "/repositories"
        }
    }
    
    
    var method: Moya.Method {
        
        switch self {
        
        case .getSwiftRepos, .searchForRepos(_):
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        
        case .getSwiftRepos:
            return .requestParameters(parameters: ["q":"Swif","sort":"stars","order":"desc"], encoding: URLEncoding.default)
            
        case .searchForRepos(let searchKey):
            return .requestParameters(parameters: ["q":searchKey,"sort":"stars","order":"desc"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        
        default:
            return ["Content-type" : "application/json"]
        }
    }
    
}
