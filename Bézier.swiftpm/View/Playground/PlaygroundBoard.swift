//
//  PlaygroundBoard.swift
//  Bezier
//
//  Created by Heyya on 2024/2/17.
//

import SwiftUI

struct PlaygroundBoard<ChildView: View>: View {
    var title: String = ""
    var childView: ChildView
    let material: Material = .thin
    
    var body: some View {
        ZStack(alignment: .top) {
            childView
            ZStack{
                Text("\(title)")
                    .font(.body.monospaced())
                    .padding()
            }
            .background(material)
            .frame(height: 32)
            .mask(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 8)
            .padding(.top, 20)
        }
    }
}

struct PlaygroundBoard_Previews: PreviewProvider {
    static var childView = GlassCard()
    static var previews: some View {
        PlaygroundBoard(childView: childView)
    }
}
