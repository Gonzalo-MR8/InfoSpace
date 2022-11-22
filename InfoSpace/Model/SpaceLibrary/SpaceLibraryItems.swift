//
//  SpaceLibraryItems.swift
//  InfoSpace
//
//  Created by GonzaloMR on 12/10/22.
//

import Foundation

// MARK: - SpaceLibraryItems
struct SpaceLibraryItems: Codable {
    var collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let version: String
    let href: String
    var spaceItems: [SpaceItem]
    let links: [CollectionLink]?
    
    enum CodingKeys: String, CodingKey {
        case version, href
        case spaceItems = "items"
        case links
    }
}

// MARK: - SpaceItem
struct SpaceItem: Codable {
    let href: String
    let spaceItemdata: SpaceItemData
    let links: [ItemLink]
    
    enum CodingKeys: String, CodingKey {
        case href
        case spaceItemdata = "data"
        case links
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.href = try container.decode(String.self, forKey: .href)
        let spaceItemsData = try container.decode([SpaceItemData].self, forKey: .spaceItemdata)
        self.spaceItemdata = spaceItemsData.first!
        self.links = try container.decodeIfPresent([ItemLink].self, forKey: .links) ?? []
    }
}

// MARK: - SpaceItemData
struct SpaceItemData: Codable {
    let title, nasaID: String
    let mediaType: MediaType
    let keywords, album: [String]?
    let dateCreated: Date
    let secondaryCreator, description, photographer, location, center: String?

    enum CodingKeys: String, CodingKey {
        case center, title
        case nasaID = "nasa_id"
        case mediaType = "media_type"
        case keywords
        case dateCreated = "date_created"
        case secondaryCreator = "secondary_creator"
        case album, photographer, location, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.center = try container.decodeIfPresent(String.self, forKey: .center)
        self.title = try container.decode(String.self, forKey: .title)
        self.nasaID = try container.decode(String.self, forKey: .nasaID)
        self.mediaType = try container.decode(MediaType.self, forKey: .mediaType)
        self.keywords = try container.decodeIfPresent([String].self, forKey: .keywords)
        
        let formatter = DateFormatter.dateFormatterUTC
        formatter.dateFormat = Constants.kLongDateFormat
        
        let strDate = try container.decode(String.self, forKey: .dateCreated)
        
        if let date = formatter.date(from: strDate) {
            self.dateCreated = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .dateCreated,
                                                   in: container,
                                                   debugDescription: "Date string \(strDate) does not match format expected \(Constants.kLongDateFormat)")
        }
        
        self.secondaryCreator = try container.decodeIfPresent(String.self, forKey: .secondaryCreator)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.album = try container.decodeIfPresent([String].self, forKey: .album)
        self.photographer = try container.decodeIfPresent(String.self, forKey: .photographer)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
    }
}

// MARK: - MediaType
enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
    case audio = "audio"
}

// MARK: - ItemLink
struct ItemLink: Codable {
    let href: String
    let rel: String
    let render: MediaType?
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let rel, prompt: String
    let href: String
}
