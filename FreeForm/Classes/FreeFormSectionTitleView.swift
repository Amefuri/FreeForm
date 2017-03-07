//
//  FreeFormSectionTitleView.swift
//  Pods
//
//  Created by Peerasak Unsakon on 3/7/17.
//
//

import UIKit

open class FreeFormSectionTitleView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    static func loadFromNib() -> FreeFormSectionTitleView? {
        let podBundle = Bundle(for: FreeFormViewController.self)
        let bundleURL = podBundle.url(forResource: "FreeForm", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)
        
        return UINib(nibName: String(describing: FreeFormSectionTitleView.self), bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? FreeFormSectionTitleView
    }
    
}
