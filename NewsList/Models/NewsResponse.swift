//
//  NewsResponse.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import Foundation

// MARK: - News
struct NewsResponse: Codable {
    let data: NewsModelDTO?
}

struct NewsModelDTO: Codable {
    let items: [NewsModel]?
    let cursor: String?
}

struct NewsModel: Codable {
    let id: String?
    let isCreatedByPage: Bool?
    let status: String?
    let type: String?
    let coordinates: CoordinatesModel?
    let isCommentable: Bool?
    let hasAdultContent: Bool?
    let isAuthorHidden: Bool?
    let isHiddenInProfile: Bool?
    let contents: [ContentModel]? // more types
    let language: String?
    let awards: AwardsModel?
    let createdAt: Int?
    let updatedAt: Int?
    let isSecret: Bool?
    let author: AuthorModel?
    let stats: NewsStatsModel?
    let isMyFavorite: Bool?
}

// MARK: - Coordinates
struct CoordinatesModel: Codable {
    let latitude: Double?
    let longitude: Double?
    let zoom: Int?
}

// MARK: - Content
enum ContentType: String, Codable {
    case video = "VIDEO"
    case audio = "AUDIO"
    case image = "IMAGE"
    case gif = "IMAGE_GIF"
    case tags = "TAGS"
    case text = "TEXT"
}
struct ContentModel: Codable {
    let type: ContentType?
    let id: String?
    let data: Any?

    enum CodingKeys: String, CodingKey {
        case type
        case id
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(String?.self, forKey: .id)
        type = try container.decode(ContentType?.self, forKey: .type)

        switch type {
        case .video, .audio: data = try container.decode(MediaModel?.self, forKey: .data)
        case .image, .gif: data = try container.decode(ImageDataModel?.self, forKey: .data)
        case .text: data = try container.decode(TextModel?.self, forKey: .data)
        case .tags: data = try container.decode(TagsModel?.self, forKey: .data)
        case .none: data = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)

        switch type {
        case .video, .audio: try container.encode(data as? MediaModel, forKey: .data)
        case .image, .gif: try container.encode(data as? ImageDataModel, forKey: .data)
        case .text: try container.encode(data as? TextModel, forKey: .data)
        case .tags: try container.encode(data as? TagsModel, forKey: .data)
        case .none: break
        }
    }
}

struct ContentDataModel: Codable {
    let value: String?
}

// MARK: - Awards
struct AwardsModel: Codable {
    let recent: [String]?
    let statistics: [AwardsStatisticsModel]?
    let voices: Double?
    let awardedByMe: Bool?
}

struct AwardsStatisticsModel: Codable {
    let id: String?
    let count: Int?
}

// MARK: - NewsStats
struct NewsStatsModel: Codable {
    let likes: StatsModel?
    let views: StatsModel?
    let comments: StatsModel?
    let shares: StatsModel?
    let replies: StatsModel?
    let timeLeftToSpace: StatsModel?
}

struct StatsModel: Codable {
    let count: Int?
    let maxCount: Int?
    let my: Bool?
}

// MARK: - Author
struct AuthorModel: Codable {
    let id: String?
    let url: String?
    let name: String?
    let banner: ContentModel?
    let photo: ContentModel?
    let gender: String?
    let isHidden: Bool?
    let isBlocked: Bool?
    let allowNewSubscribers: Bool?
    let showSubscriptions: Bool?
    let showSubscribers: Bool?
    let isMessagingAllowed: Bool?
    let auth: AuthorAuthModel?
}

struct AuthorAuthModel: Codable {
    let isDisabled: Bool?
    let lastSeenAt: Int?
    let level: Int?
}

struct AuthorStatisticsModel: Codable {
    let likes: Int?
    let thanks: Int?
    let uniqueName: Bool?
    let thanksNextLevel: Int?
    let subscribersCount: Int?
    let subscriptionsCount: Int?
}

// MARK: - Image
struct ImageDataModel: Codable {
    let extraSmall: ImageInfoModel?
    let small: ImageInfoModel?
    let medium: ImageInfoModel?
    let large: ImageInfoModel?
    let original: ImageInfoModel?
}

extension ImageDataModel {

    var actualImage: ImageInfoModel? {
        if original != nil {
            return original
        } else if medium != nil {
            return medium
        } else if large != nil {
            return large
        } else if small != nil {
            return small
        } else {
            return extraSmall
        }
    }
}

struct ImageInfoModel: Codable {
    let url: String?
    let size: ContentSizeModel?
}

struct ContentSizeModel: Codable {
    let width: Int?
    let height: Int?
}

// MARK: - Video/Audio
struct MediaModel: Codable {
    let duration: Double?
    let url: String?
    let size: ContentSizeModel?
    let previewImage: ContentModel?
}

// MARK: - Text
struct TextModel: Codable {
    let value: String?
}

// MARK: = Tags
struct TagsModel: Codable {
    let values: [String]?
}

