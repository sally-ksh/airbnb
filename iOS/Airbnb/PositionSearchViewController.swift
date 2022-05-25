import UIKit

class PositionSearchViewController: UIViewController {
    
    private let samples: [String] = ["양재", "서울특별시 서초구 양재동", "양재 시민의 숲", "양재IC"]
    private var filteredSamples = [String]()
    private var isSearching = false
    
    
    private lazy var searchContoller: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setSearchBarLayout()
    }
    
    private func setSearchBarLayout() {
        self.navigationItem.title = "search"
        self.navigationItem.searchController = searchContoller
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}


extension PositionSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isSearching {
            return samples.count
            
        }
        return filteredSamples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if !isSearching {
            cell.textLabel?.text = samples[indexPath.row]
            return cell
            
        }
        cell.textLabel?.text = filteredSamples[indexPath.row]
        return cell
    }
}

extension PositionSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        self.filteredSamples = []
        for sample in samples {
            if sample.contains(searchBarText) {
                self.filteredSamples.append(sample)
            }
        }
        self.isSearching = true
        tableView.reloadData()
    }
}
