//
//  RecipeTableViewCell.swift
//  RecipeApp
//
//  Created by NEXTAcademy on 12/23/16.
//  Copyright © 2016 NEXTAcademy. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 12, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
            
        detailTextLabel?.frame = CGRect(x: 12, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
        
    
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
