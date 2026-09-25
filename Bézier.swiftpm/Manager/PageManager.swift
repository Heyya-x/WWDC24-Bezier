//
//  PageManager.swift
//  Bezier
//
//  Created by Heyya on 2024/2/18.
//

import Foundation
import SwiftUI

class PageManager: BaseManager {
    
    static let instance = PageManager()
    
    override class var shared: PageManager {
        return instance
    }
    
    @ObservedObject var pageData: PageData = PageData()
    
    override func setup() {
        
    }
    
    override func destroy() {
        
    }
}

