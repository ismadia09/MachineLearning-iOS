//
//  RoundedView.swift
//  MachineLearning
//
//  Created by Isma Dia on 07/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
       // self.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 8
    }
    
}
