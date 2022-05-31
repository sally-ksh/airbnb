import Foundation

class RoomDetailUseCase {
    
    private let repository: RoomDetailRepository
    private let roomId: UniqueID
    private (set)var roomDetail: Observable<RoomDetail> = Observable<RoomDetail>(RoomDetail())
    
    private (set)var image: Observable<Data> = Observable<Data>(Data())
    
    init(roomId: UniqueID, repository: RoomDetailRepository) {
        self.repository = repository
        self.roomId = roomId
    }
  
    func initialize() {
        repository.fetch(roomId: roomId) { [weak self] responseData in
            self?.roomDetail.value = responseData
            
            self?.repository.fetchImage { [weak self] responseImage in
                self?.image.value = responseImage
            }
        }
    }
}
