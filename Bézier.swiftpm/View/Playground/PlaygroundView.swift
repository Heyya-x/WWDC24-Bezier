//
//  PlaygroundView.swift
//  Bezier
//
//  Created by Heyya on 2024/2/16.
//

import SwiftUI
import AVKit

struct PlaygroundView: View {
    @ObservedObject var pageData: PageData = PageManager.shared.pageData
//    @ObservedObject var pageData = PageData()
    
    let spacing: CGFloat = 12
    let boardSpacing: CGFloat = 24
    @State var dividerPosition: CGFloat = 50
    @State var status: Status = .speed
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(alignment: .center, spacing: spacing) {
                    PlaygroundBoard(title: "Document", childView: DocumentBoard())
                    PlaygroundBoard(title: pageData.canvasData.canvasTitle, childView: pageData.canvasView)
//                    // TODO: 添加隐藏按钮
                }
            }
            .padding(boardSpacing)
            .environmentObject(pageData)
            .environmentObject(pageData.canvasData)
            .onAppear {
                dividerPosition = geometry.size.width * 0.3
            }
            //            Divider(dividerPosition: $dividerPosition)
            .background(
                Color.gray
            )
        }
        .ignoresSafeArea(.all)
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
