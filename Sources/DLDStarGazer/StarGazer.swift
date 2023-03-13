//
//  StarGazer.swift
//  DLDStarGazer
//
//  Created by Dionne Lie Sam Foek  on 13/03/2023.
//

import Foundation

public struct StarGazer {
    public let username: String
    
    public static func starredRepos(for user: String) async -> [StarredRepo] {
        await StarGazer(username: user).fetchRepos()
    }
}

private extension StarGazer {
    func fetchRepos() async -> [StarredRepo] {
        let urlStr = "https://api.github.com/users/\(username)/starred"
        guard let url = URL(string: urlStr) else { return [] }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder(dateDecodingStrategy: .iso8601)
            let repos = try decoder.decode([StarredRepo].self, from: data)
            
            return repos
            
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}

private extension JSONDecoder {
    convenience init(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.dateDecodingStrategy = dateDecodingStrategy
    }
}
