//
//  Utils.swift
//  MachineLearning
//
//  Created by Isma Dia on 07/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import Foundation
import UIKit
class Utlis {
    static func convertImageToBase64(image : UIImage) -> String?{
        guard let imageData : Data = image.pngData() else {
            return nil
        }
        let strBase64:String = imageData.base64EncodedString()
        return strBase64
    }
}
