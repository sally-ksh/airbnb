import UIKit

class PositionSearchViewController: UIViewController {
    
    private let categories: [RoomPositionCategory] = [
        .init(categoryLiteral: "서울시"),
        .init(categoryLiteral: "부산시"),
        .init(categoryLiteral: "제주도")
    ]
    
    private let samples: [RoomPosition] = [
        .init(address: "양재"),
        .init(address: "서울특별시 서초구 양재동"),
        .init(address: "양재 시민의 숲"),
        .init(address: "양재IC")
    ]
    private var filteredSamples = [RoomPosition]()
    private var isSearching: Bool = false {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private lazy var searchContoller: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "어디로 여행가세요?"
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
            return categories.count
            
        }
        return filteredSamples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if !isSearching {
            cell.textLabel?.text = categories[indexPath.row].categoryLiteral
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
