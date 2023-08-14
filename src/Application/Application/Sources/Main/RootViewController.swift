//
//  RootViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/1/11.
//

import UIKit

import Infrastructure_Hosting
import TMDB_Movies_Core

class RootViewController: BaseViewController {


    //MARK: - Fields
    private var moviesContext: MoviesContext? = HostContext.current.getService()
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        
        let result = try? moviesContext?.moviesRepository?.findPlayingList(by: 1)
        print(result)
        
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
}

