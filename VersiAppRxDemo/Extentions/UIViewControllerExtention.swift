//
//  UIViewControllerExtention.swift
//  VersiAppRxDemo
//
//  Created by Asis on 3/21/21.
//

import UIKit
import SafariServices

extension UIViewController{
    
    func showSafariVC(url: String){
        let readMeUrl = URL(string: url)
        let safariVC = SFSafariViewController(url: readMeUrl!)
        present(safariVC, animated: true, completion: nil)
    }
}


