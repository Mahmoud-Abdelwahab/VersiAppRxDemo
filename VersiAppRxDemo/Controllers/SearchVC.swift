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
    @IBOutlet weak var tableView: UITableView!
    
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
        setupTableView()
    }
    
    func bindingSearchAction(){
        searchTF.rx.text.orEmpty
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] in
                guard let self = self else{return}
                if !$0.isEmpty { self.searchOperation(searchKey: $0)}
                else{
                    self.dataSource.onNext([])
                }
            }).disposed(by: disposeBag)
    }
    
   func searchOperation(searchKey: String){
        appService.request(.searchForRepos(searchKey)) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                
                if response.statusCode == 200 {
                    do {
                        let repos = try JSONDecoder().decode(Repos.self, from: response.data)
                        self.dataSource.onNext(repos.items ?? [])
                    } catch {
                        print(" *****$$$$ response decoding error: \(error) $$$$$*******")
                        self.dataSource.onError(MyCustomError.decodingError)
                    }
                } else if response.statusCode == 400 {
                    print(" *****$$$$ Sign up Error $$$$$*******")
                    self.dataSource.onError(MyCustomError.clientError)
                    
                } else if response.statusCode == 500{
                    print(" *****$$$$ Server Error $$$$$*******")
                    self.dataSource.onError(MyCustomError.serverError)
                }
            case .failure(let error):
                //  self.errorMessage.onNext(error.localizedDescription)
                print(error)
                self.dataSource.onError(MyCustomError.noInternetError)
            }
        }
    }
    
    func  setupTableView(){
        dataSource.bind(to: tableView.rx.items(cellIdentifier: SearchRepoCell.identifier)){(row, item: Item, cell: SearchRepoCell) in
            cell.configureCell(item: item)
        }.disposed(by: disposeBag)
    }

}
