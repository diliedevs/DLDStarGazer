//
//  StarredRepo.swift
//  DLDStarGazer
//
//  Created by Dionne Lie Sam Foek  on 13/03/2023.
//

import Foundation

public struct StarredRepo: Codable {
    public let name: String
    public let fullName: String
    public let owner: Owner
    public let htmlURL: URL
    public let createdAt: Date
    public let updatedAt: Date
    public let cloneURL: URL
    public let topics: [String]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cloneURL = "clone_url"
        case topics
    }
    
    public init(name: String, fullName: String, owner: StarredRepo.Owner, htmlURL: URL, createdAt: Date, updatedAt: Date, cloneURL: URL, topics: [String]) {
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.htmlURL = htmlURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.cloneURL = cloneURL
        self.topics = topics
    }
}

extension StarredRepo: Identifiable, Hashable {
    public var id : String { fullName }
    
    public static func == (lhs: StarredRepo, rhs: StarredRepo) -> Bool {
        lhs.fullName == rhs.fullName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(fullName)
    }
}

extension StarredRepo {
    public struct Owner: Codable {
        public let login: String
        public let htmlURL: URL
        
        public init(login: String, htmlURL: URL) {
            self.login = login
            self.htmlURL = htmlURL
        }
        
        private enum CodingKeys: String, CodingKey {
            case login
            case htmlURL = "html_url"
        }
    }
}
