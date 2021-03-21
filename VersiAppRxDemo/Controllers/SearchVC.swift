//
//  SearchVC.swift
//  VersiAppRxDemo
//
//  Created by Mahmoud Abdul-Wahab on 20/03/2021.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class SearchVC: UIViewController {
   
    @IBOutlet weak var searchTF: RounderTextField!
    
    lazy var appService: MoyaProvider<AppService> = {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        return MoyaProvider<AppService>(plugins: [networkLogger])
    }()
    
    let disposeBag = DisposeBag()
    let dataSource = PublishSubject<[Item]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

}



extension SearchVC {
    
    func configureViewController(){
        bindingSearchAction()
    }
    
    func bindingSearchAction(){
        searchTF.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                if !$0.isEmpty { self.searchOperation(searchKey: $0)}
            }).disposed(by: disposeBag)
    }
    
    func searchOperation(searchKey: String){
        
    }
    
}
