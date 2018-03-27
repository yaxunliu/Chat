//
//  AnimatedFix.swift
//  Chat
//
//  Created by yaxun on 2018/3/23.
//  Copyright © 2018年 yaxun. All rights reserved.
//

import UIKit
import PINRemoteImage
import AsyncDisplayKit

class AnimatedFix: NSObject {

    var gif : PINGIFAnimatedImage
    
    
    init(gifimage : PINGIFAnimatedImage) {
        gif = gifimage
        super.init()
        
    }
}

extension AnimatedFix : ASAnimatedImageProtocol {
    var coverImage: UIImage {
        return UIImage()
    }
    
    var coverImageReady: Bool {
        return true
    }
    
    var totalDuration: CFTimeInterval {
        return gif.totalDuration
    }
    
    var frameInterval: UInt {
        return gif.frameInterval
    }
    
    var loopCount: Int {
        return gif.loopCount
    }
    
    var frameCount: Int {
        return gif.frameCount
    }
    
    var playbackReady: Bool {
        return true
    }
    
    var error: Error {
        return gif.error!
    }
    
    var playbackReadyCallback: () -> Void {
        get {
            return {}
        }
        set(playbackReadyCallback) {
            
        }
    }
    
    func image(at index: UInt) -> Unmanaged<CGImage> {
        return self.gif.image(at: index, cacheProvider: nil)!
    }
    
    func duration(at index: UInt) -> CFTimeInterval {
        return self.gif.duration(at:index)
    }
    
    func clearAnimatedImageCache() {
        
    }
    
    
    
    
}
