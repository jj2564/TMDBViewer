//
//  UIFont+Theme.swift
//  Application
//
//  Created by IrvingHuang on 2021/11/22.
//

import UIKit

extension UIFont {
    
    
    //MARK: title
    static var title_xl_bold: UIFont { .systemFont(ofSize: 20, weight: .bold) }
    
    static var title_xl: UIFont { .systemFont(ofSize: 20, weight: .medium) }
    
    static var title_l_bold: UIFont { .systemFont(ofSize: 18, weight: .bold) }
    
    static var title_l: UIFont { .systemFont(ofSize: 18, weight: .medium) }
    
    static var title_m: UIFont { .systemFont(ofSize: 16, weight: .medium) }
    
    static var title_t: UIFont { .systemFont(ofSize: 16, weight: .thin) }
    
    
    //MARK: text_xl
    static var text_xl_bold: UIFont { .systemFont(ofSize: 22, weight: .bold) }
    
    
    //MARK: text_l
    static var text_l: UIFont { .systemFont(ofSize: 16, weight: .regular) }
    
    
    //MARK: text_m
    static var text_m: UIFont { .systemFont(ofSize: 14, weight: .regular) }
    
    static var text_m_bold: UIFont { .systemFont(ofSize: 14, weight: .medium) }
    
    
    //MARK: text_s
    static var text_s: UIFont { .systemFont(ofSize: 12, weight: .regular) }
    
    static var text_s_bold: UIFont { .systemFont(ofSize: 12, weight: .medium) }
    
    static var text_s_strong: UIFont { .systemFont(ofSize: 12, weight: .semibold) }
    
    
    //MARK: text_xs
    static var text_xs: UIFont  { .systemFont(ofSize: 10, weight: .regular) }
    
    static var text_xs_bold: UIFont  { .systemFont(ofSize: 10, weight: .medium) }
    
    
    //MARK: text_xss
    static var text_xss: UIFont  { .systemFont(ofSize: 9, weight: .regular) }
    static var text_xss_bold: UIFont  { .systemFont(ofSize: 9, weight: .medium) }
}
