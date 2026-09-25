//
//  GlassCard.swift
//  Bezier
//
//  Created by Heyya on 2024/2/9.
//

import SwiftUI

struct GlassCard: View {
    let gradientSurface = LinearGradient(colors: [.white.opacity(0.1), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
    let gradientBorder = LinearGradient(colors: [.white.opacity(0.5), .white.opacity(0.0), .white.opacity(0.0), .white.opacity(0.0), .white.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
    let material: Material = .thin
    var body: some View {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
            .foregroundStyle(gradientSurface)
            .background(material)
            .mask( RoundedRectangle(cornerRadius: 16, style: .circular).foregroundColor(.black) )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .stroke(lineWidth: 1.5)
                    .foregroundStyle(gradientBorder)
                    .opacity(0.8)
            )
            .shadow(color: .black.opacity(0.25), radius: 5, x: -2, y: 8)
    }
}

struct GlassCard_Previews: PreviewProvider {
    static var previews: some View {
        GlassCard()
    }
}
