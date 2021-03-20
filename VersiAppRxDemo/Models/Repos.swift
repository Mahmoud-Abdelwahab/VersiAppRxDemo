//
//  Repos.swift
//  VersiAppRxDemo
//
//  Created by Mahmoud Abdul-Wahab on 20/03/2021.
//

import UIKit

class Repos {
    // public variable but private setter only u can't set it outside this class but u can access it's value outside it
    public private(set) var name: String
    public private(set) var image: UIImage
    public private(set) var Description: String
    public private(set) var numberOfForks: Int
    public private(set) var numberOfContributors: Int
    public private(set) var language: String
    public private(set) var repoUrl: String
    
    internal init(name: String, image: UIImage, Description: String, numberOfForks: Int, numberOfContributors: Int, language: String, repoUrl: String) {
        self.name = name
        self.image = image
        self.Description = Description
        self.numberOfForks = numberOfForks
        self.numberOfContributors = numberOfContributors
        self.language = language
        self.repoUrl = repoUrl
    }
    
    
}
