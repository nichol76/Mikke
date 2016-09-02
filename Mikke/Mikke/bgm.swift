//
//  bgm.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/08/06.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit
import AVFoundation

class bgm: AVAudioPlayer {
    let bgm_list = [
        0: "opening",
        1: "buttonA",
        2: "buttonB",
        3: "mikke",
        4: "book"
    ]
    
    init (bgm:Int){
        let bgm_url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(bgm_list[bgm], ofType:"mp3")!)
        try! super.init(contentsOfURL: bgm_url, fileTypeHint: "mp3")
    }
}
