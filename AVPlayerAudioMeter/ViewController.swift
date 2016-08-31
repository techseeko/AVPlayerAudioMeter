//
//  ViewController.swift
//  AVPlayerAudioMeter
//
//  Created by Nao Tokui on 10/13/14.
//  Copyright (c) 2014 NT. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, MYAudioTabProcessorDelegate {
    var videoView:VideoView!
    var videoPlayer:AVPlayer!
    var tapProcessor: MYAudioTapProcessor!
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // A View for Video Playback
        videoView = VideoView(frame: self.view.frame)
        videoView.backgroundColor = UIColor.blackColor()
        videoView.videoFillMode   = AVLayerVideoGravityResizeAspectFill
        self.view.insertSubview(videoView, belowSubview: volumeSlider)
        
        // AVPlayer for Video Playback
        let filepath:String! = NSBundle.mainBundle().pathForResource("ppp", ofType: "mov")
        let fileUrl = NSURL.fileURLWithPath(filepath)
        videoPlayer = AVPlayer(URL: fileUrl) as AVPlayer
        videoView.player = videoPlayer
        
        // Notifications
        let playerItem: AVPlayerItem!  = videoPlayer.currentItem
        playerItem.addObserver(self, forKeyPath: "tracks", options: NSKeyValueObservingOptions.New, context:  nil);
        
        NSNotificationCenter.defaultCenter().addObserverForName(AVPlayerItemDidPlayToEndTimeNotification, object: videoPlayer.currentItem, queue: NSOperationQueue.mainQueue(), usingBlock: { (notif: NSNotification) -> Void in
            self.videoPlayer.seekToTime(kCMTimeZero)
            self.videoPlayer.play()
            print("replay")
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        videoPlayer.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (object === videoPlayer.currentItem && keyPath == "tracks"){
            if let playerItem: AVPlayerItem = videoPlayer.currentItem {
                if let tracks = playerItem.asset.tracks as? [AVAssetTrack] {
                    tapProcessor = MYAudioTapProcessor(AVPlayerItem: playerItem)
                    playerItem.audioMix = tapProcessor.audioMix
                    tapProcessor.delegate = self
                }
            }
        }
    }
    
    func audioTabProcessor(audioTabProcessor: MYAudioTapProcessor!, hasNewLeftChannelValue leftChannelValue: Float, rightChannelValue: Float) {
        print("volume: \(leftChannelValue) : \(rightChannelValue)")
        volumeSlider.value = leftChannelValue
    }
    
    @IBAction func compressorSwitchChanged(sender: UISwitch) {
        tapProcessor.compressorEnabled  = sender.on        
    }
}

