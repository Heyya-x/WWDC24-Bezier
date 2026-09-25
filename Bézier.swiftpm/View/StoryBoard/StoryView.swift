//
//  StoryView.swift
//  Bezier
//
//  Created by Heyya on 2024/2/8.
//

import SwiftUI
import AVKit

//struct AVPlayerControllerRepresented: NSViewRepresentable {
//    var player : AVPlayer
//
//    func makeNSView(context: Context) -> AVPlayerView {
//        let view = AVPlayerView()
//        view.controlsStyle = .none
//        view.player = player
//        return view
//    }
//
//    func updateNSView(_ nsView: AVPlayerView, context: Context) {
//
//    }
//}

struct StoryView: View {
    @State var isStart = false
    @State private var player = AVPlayer(url: Bundle.main.url(forResource: "Apple", withExtension: "MOV")!)
    
    var body: some View {
        ZStack {
            if isStart {
                GeometryReader { geometry in
                    VideoPlayer(player: player)
                        .ignoresSafeArea()
                        .frame(width: geometry.size.height * 16 / 9, height: geometry.size.height)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .disabled(true)
                        .onAppear {
                            player.play()
                        }
                        .onDisappear {
                            player.pause()
//                            player.seek(to: .zero)
                        }
                }
            }
            if !isStart {
                Introduction(isStart: $isStart)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
