//
//  About.swift
//  Bezier
//
//  Created by Heyya on 2024/2/24.
//

import SwiftUI

struct About: View {
    let avataWidth: CGFloat = 150
    var body: some View {
            VStack {
                HStack {
                    Image("Avatar")
                        .resizable()
                        .frame(width: avataWidth, height: avataWidth)
                        .cornerRadius(avataWidth)
                    
                }
                HStack {
                    Text("""
                        \tHi! My name is Kaijun Zhu. I am a university student majoring in mathematics and I have a passion for programming. Since entering university, I have self-taught Swift through the internet, and I won the WWDC22 Swift Student Challenge. This is my third project.
                        \t\"The significance of programming lies not in the complexity of the algorithms we use, but in the impact programming can have on our world.\", I always feel this way.
                        \tAfter graduation, I will become a junior high school mathematics teacher. I hope to use programming to present mathematical knowledge in a more intuitive and vivid way. Helping students better grasp knowledge is the core goal of teaching, and it is also the significance of my learning programming.
                        """)
                    .font(.title3.monospaced())
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(GlassCard())
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
