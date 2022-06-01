import Foundation

enum EndPoint {
    case roomDetail(roomId: UniqueID)
    case list
    case randomImage
    
    static let origin: String = "https://68ba057f-eb57-4bad-be9b-d220ac63ca31.mock.pstmn.io"
    var path: String {
        switch self {
        case .roomDetail(let roomId):
            return "\(EndPoint.origin)/airbnb/room/\(roomId)"
        case .list:
            return "\(EndPoint.origin)/airbnb/search/rooms"
        case .randomImage:
            return "https://placeimg.com/640/480/any"
        }
    }
}
