//
//  TrendingVC.swift
//  VersiAppRxDemo
//
//  Created by Mahmoud Abdul-Wahab on 20/03/2021.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class TrendingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var appService: MoyaProvider<AppService> = {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        return MoyaProvider<AppService>(plugins: [networkLogger])
    }()
    
    let disposeBag = DisposeBag()
    let dataSource = PublishSubject<[Item]>()
    let refreshControl = UIRefreshControl()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
}



extension TrendingVC {
    
    
    func configureViewController(){
        setupTableView()
        fetchRepose()
        setupRefreshControl()
    }
    
    
    @objc func fetchRepose(){
        
        appService.request(.getSwiftRepos) { [weak self] (result) in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
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
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "TrendingRepoCell")){(row, item: Item, cell: TrendingRepoCell) in
            cell.configureCell(item: item)
        }.disposed(by: disposeBag)
    }
    
    func setupRefreshControl(){
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos 🔥", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) , NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!
        ])
        
        refreshControl.addTarget(self, action: #selector(fetchRepose), for: .valueChanged)
    }
}
