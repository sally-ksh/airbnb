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
        self.view = tableView
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "숙소 찾기"
        self.navigationItem.searchController = searchContoller
    }
}


extension PositionSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredSamples.count : categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = isSearching ? filteredSamples[indexPath.row].address : categories[indexPath.row].categoryLiteral
        return cell
    }
}

extension PositionSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        
        if searchBarText.count <= 0 {
            self.isSearching = false
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
