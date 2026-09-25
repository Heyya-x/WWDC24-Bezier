//
//  About.swift
//  Bezier
//
//  Created by Heyya on 2024/2/23.
//

import SwiftUI

struct Final: View {
    var body: some View {
            VStack {
                HStack {
                    Text("🎉")
                        .font(.system(size: 100))
                }
                HStack {
                    Text("\tCongratulations, you have completed all the challenges! Now you have mastered the knowledge about Bézier curves and are able to draw with Bézier curves as well as control velocity curves.\n\tYou can continue to review the knowledge you've learned before, or return to the drawing board to continue drawing. If you wish, you can click on the 'About' button to learn more about the author.")
                        .font(.title3.monospaced())
                }
                .padding(.horizontal, 40)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GlassCard())
    }
}

struct Final_Previews: PreviewProvider {
    static var previews: some View {
        Final()
    }
}
