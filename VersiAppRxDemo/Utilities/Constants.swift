//
//  Constants.swift
//  VersiAppRxDemo
//
//  Created by Asis on 3/21/21.
//

import Foundation


enum MyCustomError: Error{
    case decodingError
    case serverError
    case clientError
    case noInternetError
}

enum Constants{
    static let readMeSegment = "/blob/master/README.md"
}
