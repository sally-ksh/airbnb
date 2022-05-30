import Foundation
import Alamofire
import OSLog


enum ContentType {
    case json
    case image
    var value: String {
        switch self {
        case .json:
            return "application/json"
        case .image:
            return "image/png"
        }
    }
}

enum HttpMethod {
    case get
    case post
}

enum EndPoint {
    case accomodationDetail(roomId: UniqueID)
    case list
    
    static let origin: String = "https://68ba057f-eb57-4bad-be9b-d220ac63ca31.mock.pstmn.io"
    var path: String {
        switch self {
        case .accomodationDetail(let roomId):
            return "\(EndPoint.origin)/airbnb/room/\(roomId)"
        case .list:
            return "\(EndPoint.origin)/airbnb/search/rooms"
        }
    }
}

struct NetworkHandler {
    
    private let logger = Logger()
    
    func request(endPoint: EndPoint, method: HttpMethod, contentType: ContentType, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: endPoint.path) else {
            return
        }
        guard let request = try? URLRequest(url: urlComponents, method: HTTPMethod(rawValue: "\(method)"), headers: ["Content-Type":contentType.value]) else {
            return
        }
        AF.request(request).validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    logger.error("\(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }
    
}
