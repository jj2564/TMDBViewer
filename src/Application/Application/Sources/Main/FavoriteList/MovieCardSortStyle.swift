//
//  MovieCardSortStyle.swift
//  Application
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

enum MovieCardSortStyle: String, CaseIterable {

    case releaseDate = "發行日"
    case ranking = "評分"
    
    var sortStrategy: MovieCardSortStrategy {
        switch self {
        case .releaseDate:
            return ReleaseSort()
        case .ranking:
            return RankingSort()
        }
    }
}


protocol MovieCardSortStrategy {
    func sort(_ first: MovieCardViewModel, _ second: MovieCardViewModel) -> Bool
}

fileprivate struct ReleaseSort: MovieCardSortStrategy {
    func sort(_ first: MovieCardViewModel, _ second: MovieCardViewModel) -> Bool {
        let date0 = first.movie?.releaseDate
        let date1 = second.movie?.releaseDate
        
        return date0 ?? .distantPast > date1 ?? .distantPast
    }
}

fileprivate struct RankingSort: MovieCardSortStrategy {
    func sort(_ first: MovieCardViewModel, _ second: MovieCardViewModel) -> Bool {
        let vote0 = first.movie?.voteAverage
        let vote1 = second.movie?.voteAverage
        
        return vote0 ?? 0 > vote1 ?? 0
    }
}
