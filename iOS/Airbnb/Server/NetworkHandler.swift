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


struct NetworkHandler {
    
    private let logger = Logger()
    
    func request(urlString: String, method: HttpMethod, contentType: ContentType, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: urlString) else {
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
