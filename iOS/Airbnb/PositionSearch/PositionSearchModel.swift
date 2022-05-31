import Foundation
import GooglePlaces

class PositionSearchModel {

    private let token = GMSAutocompleteSessionToken()
    private let client = GMSPlacesClient()

    private (set) var isSearching = Observable<Bool>(false)
    private  (set) var filteredSamples = [RoomPosition]()
    private let categories: [RoomPositionCategory]
    private let samples: [RoomPosition]
    
    init(_ mockFactory: PositionSearchFactory) {
        self.categories = mockFactory.categories
        self.samples = mockFactory.dataList
    }

    func rowsCount() -> Int {
        return isSearching.value ? filteredSamples.count : categories.count
    }
    
    func titleText(in rowIndex: Int) -> String {
        return isSearching.value ? filteredSamples[rowIndex].address : categories[rowIndex].categoryLiteral
    }

    func setIsSearching(_ isSearching: Bool) {
        self.isSearching.value = isSearching
    }

    func updateSearchResults(predictions: [String:String]) {
        if predictions.isEmpty {
            self.isSearching.value = false
            return
        }
        
        self.filteredSamples = predictions.map { return RoomPosition(address: $0.key, placeId: $0.value) }
        self.isSearching.value = true
    }
    
    func fetchPredctionList(searchText: String) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        var predictions: [String:String] = [:]
        client.findAutocompletePredictions(fromQuery: searchText,
                                           filter: nil,
                                           sessionToken: token) { results, error in
            if error != nil { return }
            results?.forEach { predictions[$0.attributedPrimaryText.string] = $0.placeID }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.updateSearchResults(predictions: predictions)
        }
    }
    
    func searchPositionInfo(index: Int, completion: @escaping (SearchCondition) -> Void) {
        let positionTitle = self.filteredSamples[index].address
        let placeId = self.filteredSamples[index].placeId
        client.lookUpPlaceID(placeId) { result,error in
            if error != nil { return }
            if let coordinate = result?.coordinate {
                let searchCondition = SearchCondition(positionTitle: positionTitle, logntitude: coordinate.longitude.magnitude, latitude: coordinate.latitude.magnitude)
                completion(searchCondition)
            }
        }
    }
}
