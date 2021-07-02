//
//  ViewController.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/2.
//

import UIKit

class WatchListViewController: UIViewController {
    
    // MARK: - Properties
    private var searchTime: Timer?
    
    private var result: [SearchResult] = []
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupSeachController()
        setupTitleView()
    }
    
    // MARK: - Methods
    private func setupTitleView() {
        let titleView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: view.width,
                                             height: navigationController?.navigationBar.height ?? 100))
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width-20, height: titleView.height))
        label.text = "Stocks"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        titleView.addSubview(label)
        navigationItem.titleView = titleView
    }
    private func setupSeachController() {
        let resultVC = SearchResultsViewController()
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        resultVC.delegate = self
        navigationItem.searchController = searchVC
    }
}

extension WatchListViewController: UISearchResultsUpdating  {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultVC = searchController.searchResultsController as? SearchResultsViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        // Reset Timer
        searchTime?.invalidate()
        
        // Kick off new timer
        // Optimize to reduce number of searches for when user stops typing
        
        // Call API to Search
        searchTime = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
            APICaller.shared.search(query: query) { (result) in
                // Update results Controller
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        resultVC.update(with: response.result)
                        
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        resultVC.update(with: [])
                    }
                    print(query)
                }
            }
        })
       
    }
}
extension WatchListViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewControllerDidSelected(searchResult: SearchResult) {
        navigationItem.searchController?.searchBar.resignFirstResponder()
        let vc = StockDetailViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = searchResult.description
        present(navVC, animated: true, completion: nil)
    }
}
