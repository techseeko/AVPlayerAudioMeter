//
//  VideoView.swift
//  AVPlayerAudioMeter
//
//  Created by Nao Tokui on 10/13/14.
//  Copyright (c) 2014 NT. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

class VideoView : UIView
{
    
    override class func layerClass() -> AnyClass {
        return AVPlayerLayer.self
    }
    
    var player : AVPlayer {
        get {
            let playerLayer = self.layer as! AVPlayerLayer
            return playerLayer.player!
        }
        set {
            let playerLayer = self.layer as! AVPlayerLayer
            playerLayer.player = newValue
        }
    }
    
    var videoFillMode: NSString {
        get {
            let playerLayer = self.layer as! AVPlayerLayer
            return playerLayer.videoGravity
        }
        set {
            let playerLayer = self.layer as! AVPlayerLayer
            playerLayer.videoGravity = newValue as String
        }
    }

}