//
//  Divider.swift
//  Bezier
//
//  Created by Heyya on 2024/2/16.
//

import SwiftUI

struct Divider: View {
    @Binding var dividerPosition: CGFloat
    let width: CGFloat = 4
    let height: CGFloat = 50
        
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 4)
                .frame(width: width, height: height)
                .foregroundColor(Color.secondary)
//                .position(CGPoint(x: dividerPosition, y: UIScreen.main.bounds.size.height / 2 - height / 2))
                .position(CGPoint(x: dividerPosition, y: geometry.size.height / 2 - height / 2))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            dividerPosition = value.location.x
                            if dividerPosition > geometry.size.width * 0.5 {
                                dividerPosition = geometry.size.width * 0.5
                            }
                            if dividerPosition < geometry.size.width * 0.3 {
                                dividerPosition = geometry.size.width * 0.3
                            }
                        })
                )
        }
    }
}

struct Divider_Previews: PreviewProvider {
    @State static var dividerPosition: CGFloat = 0//UIScreen.main.bounds.size.width / 2
    static var previews: some View {
        Divider(dividerPosition: $dividerPosition)
    }
}
