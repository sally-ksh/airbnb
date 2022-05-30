import Foundation

typealias UniqueID = Int

struct RoomDetail: Codable {
    let roomId: UniqueID
    let images: [String] // url
    let isWished: Bool
    let title: String
    let averageOfStar: Float
    let numberOfReviews: Int
    let address: String
    let hostName: String
    let profileOfHost: String // url
    let maxNumberOfPeople: Int
    let styleOfRoom: String // enum
    let bedCount: Int
    let bathroomCount: Int
    let roomDescription: String // room
    let priceForOneDay: Int
    
    init() {
        roomId = 0
        images = []
        isWished = false
        title = ""
        averageOfStar = 0.0
        numberOfReviews = 0
        address = ""
        hostName = ""
        profileOfHost = ""
        maxNumberOfPeople = 0
        styleOfRoom = "원룸"
        bedCount = 0
        bathroomCount = 0
        roomDescription = ""
        priceForOneDay = 0
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.roomDescription = try container.decode(String.self, forKey: .roomDescription)
        self.roomId = try container.decode(UniqueID.self, forKey: .roomId)
        self.images = try container.decode([String].self, forKey: .images)
        self.isWished = try container.decode(Bool.self, forKey: .isWished)
        self.title = try container.decode(String.self, forKey: .title)
        self.averageOfStar = Float(try container.decode(String.self, forKey: .averageOfStar)) ?? 0.0
        self.numberOfReviews = try container.decode(Int.self, forKey: .numberOfReviews)
        self.address = try container.decode(String.self, forKey: .address)
        self.hostName = try container.decode(String.self, forKey: .hostName)
        self.profileOfHost = try container.decode(String.self, forKey: .profileOfHost)
        self.maxNumberOfPeople = try container.decode(Int.self, forKey: .maxNumberOfPeople)
        self.styleOfRoom = try container.decode(String.self, forKey: .styleOfRoom)
        self.bedCount = try container.decode(Int.self, forKey: .bedCount)
        self.bathroomCount = try container.decode(Int.self, forKey: .bathroomCount)
        self.priceForOneDay = try container.decode(Int.self, forKey: .priceForOneDay)
    }
    
    enum CodingKeys: String, CodingKey {
        case roomDescription = "description"
        case roomId
        case images
        case isWished
        case title
        case averageOfStar
        case numberOfReviews
        case address
        case hostName
        case profileOfHost
        case maxNumberOfPeople
        case styleOfRoom
        case bedCount
        case bathroomCount
        case priceForOneDay
    }
}
