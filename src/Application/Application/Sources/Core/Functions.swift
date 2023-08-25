//
//  Functions.swift
//  Application
//
//  Created by Irving Huang on 2023/8/16.
//

import UIKit
import Toaster

typealias VFLDictionary = [String: NSLayoutConstraint.FormatOptions?]
typealias ViewsDictionary = [String: UIView]
typealias MetricsDictionary = [String: CGFloat]

/// VFL語言 縮減排版
func constraintsVFL(_ vfl: String, views: ViewsDictionary, metrics: MetricsDictionary? = nil, options: NSLayoutConstraint.FormatOptions = []) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.constraints(withVisualFormat: vfl, options: options, metrics: metrics, views: views)
}

/// VFL語言 縮減排版
func constraintsArrayVFL(_ vfls: VFLDictionary, views: ViewsDictionary, metrics: MetricsDictionary? = nil) -> [NSLayoutConstraint] {
    
    var constraints = [NSLayoutConstraint]()
    
    for (vfl, options) in vfls {
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vfl, options: options ?? [], metrics: metrics, views: views)
    }
    
    return constraints
}


func quickView() -> UIView {
    let v = UIView()
    v.translatesAutoresizingMaskIntoConstraints = false
    return v
}

func quickLabel() -> UILabel {
    let lb = UILabel()
    lb.translatesAutoresizingMaskIntoConstraints = false
    lb.textColor = .secondary10
    return lb
}

func classFromString(_ className: String) -> AnyClass? {

    /// get namespace
    if let namespace = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String {
        return NSClassFromString("\(namespace).\(className)")
    }

    return nil
    
}

func showToaster(_ text: String) {
    
    let toast = Toast(text: text, duration: 1.0)
    toast.view.backgroundColor = .black.withAlphaComponent(0.6)
    toast.view.textColor = .neutral100
    toast.view.font = .title_l
    toast.view.bottomOffsetPortrait = UIScreen.main.bounds.height / 2
    
    DispatchQueue.main.async {
        toast.show()
    }
    
}

var isIphone: Bool {
    
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        return true
    default:
        return false
    }
    
}
