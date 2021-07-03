//
//  SearchResultsViewController.swift
//  StockAPP
//
//  Created by Kenny on 2021/7/2.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidSelected(searchResult: SearchResult)
}

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let tableView: UITableView = {
       let table = UITableView()
        table.register(SearchResultTableViewCell.self,
                       forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    private var results: [SearchResult] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    // MARK: - Methods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func update(with results: [SearchResult]) {
        self.results = results
        self.tableView.isHidden = results.isEmpty
        self.tableView.reloadData()
    }
}
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        
        let result = results[indexPath.row]
        
        cell.textLabel?.text = result.displaySymbol
        cell.detailTextLabel?.text = result.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let result = results[indexPath.row]
        delegate?.searchResultsViewControllerDidSelected(searchResult: result)
    }
    
}
