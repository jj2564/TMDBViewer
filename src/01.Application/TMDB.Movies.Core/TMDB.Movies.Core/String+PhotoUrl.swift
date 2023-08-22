//
//  String+PhotoUrl.swift
//  TMDB.Movies.Core
//
//  Created by Irving Huang on 2023/8/21.
//

import Foundation

public extension String {
    
    func getPhotoUrl(isThumb: Bool) -> String? {
        
        let imageBaseUrl = "https://image.tmdb.org/t/p/"
        let name = self
        let size  = isThumb ? "w500" : "original"
        
        return imageBaseUrl + size + name
        
    }
    
}
