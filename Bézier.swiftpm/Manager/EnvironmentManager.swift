//
//  EnvironmentManager.swift
//  Bezier
//
//  Created by Heyya on 2024/2/17.
//

import Foundation

class EnvironmentManager: BaseManager {
    
    static let instance = EnvironmentManager()
    
    override class var shared: EnvironmentManager {
        return instance
    }
    
    let environment : Environment = Environment()
    
    override func setup() {
        
    }
    
    override func destroy() {
        
    }
}
