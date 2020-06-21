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
    
    @Published private var emojiArt: EmojiArt = EmojiArt()
}
