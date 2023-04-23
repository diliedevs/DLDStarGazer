//
//  RepoTag.swift
//  DLDStarGazer
//
//  Created by Dionne Lie Sam Foek  on 23/04/2023.
//

import Foundation

import Foundation

public struct RepoTag: Codable {
    public var name       : String
    public var zipballUrl : URL
    public var tarballUrl : URL
    public var nodeId     : String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case zipballUrl = "zipball_url"
        case tarballUrl = "tarball_url"
        case nodeId     = "node_id"
    }
    
    public init(name: String, zipballUrl: URL, tarballUrl: URL, nodeId: String) {
        self.name       = name
        self.zipballUrl = zipballUrl
        self.tarballUrl = tarballUrl
        self.nodeId     = nodeId
    }
}
