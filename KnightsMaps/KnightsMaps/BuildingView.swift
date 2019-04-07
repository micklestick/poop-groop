//
//  BuildingView.swift
//  KnightsMaps
//
//  Created by Isaac Vaughn on 4/6/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation
import UIKit

class BuildingView: UIView {
    let buildingTitle: UILabel
    
    init(name: String) {
        let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 4200, height: 400))
        
        self.buildingTitle = UILabel(frame: frame)
        
        super.init(frame: frame)
        self.addViews()
        self.initViews(name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews(_ name: String) {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 40.0
        self.layer.borderWidth = 10.0
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red:0.0, green:0.52, blue:1.0, alpha:1.0).cgColor
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.clipsToBounds = true
        
        buildingTitle.text = name
        buildingTitle.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.3)
        buildingTitle.textAlignment = NSTextAlignment.center
        buildingTitle.font = UIFont.systemFont(ofSize: 300)
    }
    
    func addViews() {
        self.addSubview(buildingTitle);
    }
}
