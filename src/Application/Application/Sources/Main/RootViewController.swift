//
//  RootViewController.swift
//  Application
//
//  Created by Irving Huang on 2023/1/11.
//

import UIKit
import TinyConstraints


class RootViewController: BaseViewController {


    //MARK: - Fields
    
    
    //MARK: - Constructors
    override func loadView() {
        super.loadView()
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("點此進入現在播放頁面", for: .normal)
        button.setTitleColor(.secondary10, for: .normal)
        button.titleLabel?.font = .title_l_bold
        
        button.addTarget(self, action: #selector(didPressedNowPlaying(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        button.centerInSuperview()
        
    }
    
    
    //MARK: - Properties
    
    
    //MARK: - Methods
    @objc private func didPressedNowPlaying(_ sender: UIButton) {
        
        let vc = NowPlayingViewController()
        UIApplication.rootViewController = BaseNavigationController(rootViewController: vc)
        
    }
}

