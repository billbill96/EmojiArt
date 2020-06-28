//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Supannee Mutitanon on 19/6/20.
//  Copyright © 2020 Supannee Mutitanon. All rights reserved.
//

import SwiftUI

class EmojiArtDocumnet: ObservableObject {
    static let palette: String = "⭐️🌧👩‍💻🍎🤡👾"
    
    private var emojiArt: EmojiArt {
        willSet {
            objectWillChange.send()
        }
        didSet {
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocumnet.untitled)
//            print("json = \(emojiArt.json?.utf8 ?? "nil")")
        }
    }
    
    private static let untitled = "EmojiArtDocument.Untitiled"
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocumnet.untitled)) ?? EmojiArt()
        fetchBackgroundImageData()
    }
    
    @Published var backgroudImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    
    //MARK: Intent(s)
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    func setBackgroundURL(_ url: URL?) {
        emojiArt.backgroudURL = url?.imageURL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData() {
        backgroudImage = nil
        if let url = self.emojiArt.backgroudURL {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        if url == self.emojiArt.backgroudURL {
                            self.backgroudImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y))}
}
