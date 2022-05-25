import Foundation


struct RoomPosition {
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
