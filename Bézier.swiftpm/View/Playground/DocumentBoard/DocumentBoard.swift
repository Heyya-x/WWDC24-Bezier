//
//  DetailBoard.swift
//  Bezier
//
//  Created by Heyya on 2024/2/16.
//

import SwiftUI

struct DocumentBoard: View {
//    @ObservedObject var pageData: PageData = PageManager.shared.pageData
    @EnvironmentObject var pageData: PageData
    @EnvironmentObject var canvasData: PageCanvasData
    
    var body: some View {
        pageData.docView
            .frame(minWidth: 220,
                   idealWidth: 340,
                   maxWidth: 420,
            alignment: .top)
    }
}

struct DocumentBoard_Previews: PreviewProvider {
    static var previews: some View {
        DocumentBoard()
    }
}
