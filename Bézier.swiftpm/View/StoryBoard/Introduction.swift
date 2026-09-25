//
//  IntroductionView.swift
//  Bezier
//
//  Created by Heyya on 2024/2/16.
//

import SwiftUI

struct Introduction: View {
    @Binding var isStart: Bool
    var body: some View {
        VStack {
            Text("What's Bézier Curve?")
                .font(.custom("Helvetica", size: 60))
            VStack(alignment: .leading) {
                Text("Bézier curves are a type of mathematical curve commonly used in computer graphics and art design. They are defined by a series of control points that determine the shape of the curve.")
                Text("\nWant to learning more about bézier curve?")
            }
            .font(.custom("Helvetica", size: 28))
            .padding(.horizontal, 40)
            
            Button {
                withAnimation(.easeOut(duration: 0.8)) {
                    isStart = true
                }
            } label: {
                Text("Start")
                    .font(.custom("Helvetica", size: 34))
            }
            .buttonStyle(.plain)
            .background (
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(.white, lineWidth: 4)
                    .frame(width: 100, height: 54)
            )
            .padding(.top, 20)
        }
        .shadow(color: .white.opacity(0.25), radius: 5, x: 0, y: 8)
        .frame(width: 800, height: 500)
        .background {
            GlassCard()
        }
    }
}

struct Introduction_Previews: PreviewProvider {
    @State static var isStart = false
    static var previews: some View {
        Introduction(isStart: $isStart)
    }
}
