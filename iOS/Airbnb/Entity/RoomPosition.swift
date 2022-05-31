import Foundation


struct RoomPosition {
    let address: String
    let placeId: String
    private let category: RoomPositionCategory // 주소가 포함된 시,군,구
    private let latitude: Float // 소수점 14자리
    private let longitude: Float
    
    init(address: String) {
        self.address = address
        self.placeId = ""
        self.category = RoomPositionCategory(categoryLiteral: "서울시")
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(address: String, placeId: String) {
        self.address = address
        self.placeId = placeId
        self.category = RoomPositionCategory(categoryLiteral: "서울시")
        self.latitude = 0.0
        self.longitude = 0.0
    }
}
