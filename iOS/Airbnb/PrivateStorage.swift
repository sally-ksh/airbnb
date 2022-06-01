import Foundation

struct PrivateStorage {
    static var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "ConfigProperty", ofType: "plist") else {
          fatalError("Couldn't find file 'ConfigProperty.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "GOOGLE_MAP_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'ConfigProperty'.")
        }
        return value
      }
    }
}


