//
//  SendDrawnNumberRequest.swift
//  MachineLearning
//
//  Created by Isma Dia on 07/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import Foundation
import Alamofire

class Requests {
    static func sendDrawnNumbers(image : String, type : String, expectedResult : Int, completion: @escaping (Int) -> Void){
        let urlString = "\(UidDef.baseUrlString)"
        guard let url = URL(string: urlString) else {
            return
        }
        let parameters : [String : Any] = [
            "type":type,
            "value":expectedResult,
            "image":image]
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            if (response.error != nil){
                print("ERROR : \(String(describing: response.error))")
            }
            
            if let json = response.result.value as? [String : Any]{
                
            }
        }
        
    }
}
