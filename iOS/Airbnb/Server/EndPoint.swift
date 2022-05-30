import Foundation

enum EndPoint {
    case roomDetail(roomId: UniqueID)
    case list
    
    static let origin: String = "https://68ba057f-eb57-4bad-be9b-d220ac63ca31.mock.pstmn.io"
    var path: String {
        switch self {
        case .roomDetail(let roomId):
            return "\(EndPoint.origin)/airbnb/room/\(roomId)"
        case .list:
            return "\(EndPoint.origin)/airbnb/search/rooms"
        }
    }
}
