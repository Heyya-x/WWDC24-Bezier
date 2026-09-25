//
//  PageData.swift
//  Bezier
//
//  Created by Heyya on 2024/2/17.
//

import Foundation
import SwiftUI

protocol PageDataProvider {
    func modifyDocView(pageData: PageData)
    func modifyCanvasView(pageData: PageData)
}

// 

class PageData: ObservableObject {
    @ObservedObject var canvasData: PageCanvasData
    @Published var docView: AnyView
    @Published var canvasView: AnyView
    
    var modifier: PageDataProvider = PageDataChapter0()
    
    required init() {
        canvasData = PageCanvasData()
        docView = AnyView(ZStack{})
        canvasView = AnyView(ZStack{})
//        switchTo(index: 0)
        switchTo(index: 0)
    }
    
    func reset() {
        modifier.modifyDocView(pageData: self)
        modifier.modifyCanvasView(pageData: self)
    }
    
    func switchTo(index: Int) {
        switch index {
        case 0:
            modifier = PageDataChapter0()
            break
        case 10:
            modifier = PageDataChapter1Section0()
            break
        case 11:
            modifier = PageDataChapter1Section1()
            break
        case 12:
            modifier = PageDataChapter1Section2()
            break
        case 20:
            modifier = PageDataChapter2Section0()
            break
        case 21:
            modifier = PageDataChapter2Section1()
            break
        case 3:
            modifier = PageDataChapter3()
            break
        case -1:
            modifier = PageDataFinal()
            break
        case -2:
            modifier = PageDataAbout()
        default:
            break
        }
        
        reset()
    }
}
