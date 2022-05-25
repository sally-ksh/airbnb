import UIKit


struct Position {
    let address: String
    private let category: String // 주소가 포함된 시,군,구
    private let latitude: Float // 소수점 14자리
    private let longitude: Float
    
    init(address: String) {
        self.address = address
        self.category = "서울시"
        self.latitude = 0.0
        self.longitude = 0.0
    }
}


class PositionSearchViewController: UIViewController {
    
    private let samples: [Position] = [
        .init(address: "양재"),
        .init(address: "서울특별시 서초구 양재동"),
        .init(address: "양재 시민의 숲"),
        .init(address: "양재IC")
    ]
    private var filteredSamples = [Position]()
    private var isSearching: Bool = false {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var searchContoller: UISearchController = {
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.delegate = self
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
            cell.textLabel?.text = samples[indexPath.row].address
            return cell
            
        }
        cell.textLabel?.text = filteredSamples[indexPath.row].address
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
            if sample.address.contains(searchBarText) {
                self.filteredSamples.append(sample)
            }
        }
        self.isSearching = true
    }
}

extension PositionSearchViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        self.isSearching = false
    }
}
