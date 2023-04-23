//
//  StarGazer.swift
//  DLDStarGazer
//
//  Created by Dionne Lie Sam Foek  on 13/03/2023.
//

import Foundation

public struct StarGazer {
    public let username : String
    public var getTags  : Bool = false
    
    public static func starredRepos(for user: String, withTags tags: Bool) async -> [StarredRepo] {
        await StarGazer(username: user, getTags: tags).fetchRepos()
    }
}

private extension StarGazer {
    func fetchRepos() async -> [StarredRepo] {
        let urlStr = "https://api.github.com/users/\(username)/starred"
        let decoder = JSONDecoder(dateDecodingStrategy: .iso8601)
        let repos: [StarredRepo]? = await fetchGithub(at: urlStr, decoder: decoder)
        
        guard var repos else { return [] }
        
        if getTags {
            repos = await tagRepos(repos)
        }
        
        return repos
    }
    
    func tagRepos(_ repos: [StarredRepo]) async -> [StarredRepo] {
        var tagged = [StarredRepo]()
        
        for repo in repos {
            
            let tags = await fetchTags(at: repo.tagsURL.absoluteString)
            tagged.append(repo.withTags(tags))
            
        }
        
        return tagged
    }
    
    func fetchTags(at urlStr: String) async -> [RepoTag] {
        let tags: [RepoTag]? = await fetchGithub(at: urlStr, decoder: JSONDecoder())
        
        return tags ?? []
    }
    
    func fetchGithub<T: Decodable>(at urlString: String, decoder: JSONDecoder) async -> T? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try decoder.decode(T.self, from: data)
            
            return response
            
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

private extension JSONDecoder {
    convenience init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
