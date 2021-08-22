
// WelcomeValue.swift

import Foundation

struct Category: Decodable{
    var accessories: CategoryInfo
    var wooman: CategoryInfo
    var man: CategoryInfo
    var children: CategoryInfo
    var sale: CategoryInfo
    var newItems: CategoryInfo
    var marketplace: CategoryInfo
    enum CodingKeys: String, CodingKey {
        case accessories = "67"
        case wooman = "68"
        case man = "69"
        case children = "73"
        case sale = "156"
        case newItems = "165"
        case marketplace = "233"
    }
}

struct CategoryInfo: Decodable {
    var name: String
    var sortOrder: SortOrder
    var image: String
    var iconImage: String
    var iconImageActive: String
    var subcategories: [Subcategory]


    enum CodingKeys: String, CodingKey {
        case name = "name"
        case sortOrder = "sortOrder"
        case image = "image"
        case iconImage = "iconImage"
        case iconImageActive = "iconImageActive"
        case subcategories = "subcategories"
    }
}

struct Subcategory: Decodable {
    var id: SortOrder
    var iconImage: String
    var sortOrder: SortOrder
    var name: String
    var type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case iconImage = "iconImage"
        case sortOrder = "sortOrder"
        case name = "name"
        case type = "type"
    }
}


enum TypeEnum: String, Decodable, CodingKey {
    case category = "Category"
    case collection = "Collection"
}

extension CategoryInfo {
    init(data: Data) throws {
        self = try JSONDecoder().decode(CategoryInfo.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        name: String? = nil,
        sortOrder: SortOrder? = nil,
        image: String? = nil,
        iconImage: String? = nil,
        iconImageActive: String? = nil,
        subcategories: [Subcategory]? = nil
    ) -> CategoryInfo {
        return CategoryInfo(
            name: name ?? self.name,
            sortOrder: sortOrder ?? self.sortOrder,
            image: image ?? self.image,
            iconImage: iconImage ?? self.iconImage,
            iconImageActive: iconImageActive ?? self.iconImageActive,
            subcategories: subcategories ?? self.subcategories
        )
    }
}

enum SortOrder: Decodable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(SortOrder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SortOrder"))


    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

extension Subcategory {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Subcategory.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: SortOrder? = nil,
        iconImage: String? = nil,
        sortOrder: SortOrder? = nil,
        name: String? = nil,
        type: TypeEnum? = .category
    ) -> Subcategory {
        return Subcategory(
            id: id ?? self.id,
            iconImage: iconImage ?? self.iconImage,
            sortOrder: sortOrder ?? self.sortOrder,
            name: name ?? self.name,
            type: type ?? self.type
        )
    }
}
