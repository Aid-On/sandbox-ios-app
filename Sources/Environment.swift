//
//  Environment.swift
//  App
//
//  Created by Eimer on 2020/11/20.
//  Copyright © 2020 Silbern Eimer, Org. All rights reserved.
//

import Foundation

struct Environment {
    
    static func properties(forKey key: String) -> String {
        let bundle = Bundle.main
        return bundle
            .object(forInfoDictionaryKey: key) as! String
    }
}
