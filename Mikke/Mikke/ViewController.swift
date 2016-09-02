//
//  ViewController.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/07/25.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

let userConfig = NSUserDefaults.standardUserDefaults()

let missionTitle = ["あか","あお","きいろ","みどり","しろ","くろ","まる","さんかく","しかく"]
let missionTotalCount = missionTitle.count
var missionRecent = 0
var missionCurrent = 0
var medalCount = 3
var medalTotalCount = 0
var findCurrentCount = 0
var opening = false
var medalFlg = false

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

class ViewController: UIViewController {
    
    // Outlet
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var bookButton: UIButton!
    @IBOutlet var backGround: UIImageView!
    
    // Loading int
    let loadingImageTotalCount = 117
    var loadingImageCount = 0
    var loadingImageTimer = NSTimer()
    var loadingFinishTimer = NSTimer()
    
    // Audio
    var bgmPlayer = bgm(bgm: 0)
    var btnPlayer1 = bgm(bgm: 1)
    var mikkePlayer = bgm(bgm: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userConfig.registerDefaults(["name": "未設定"])
        userConfig.registerDefaults(["favoriteColor": "未設定"])
        
        // BackGround Setting
        let backImage = UIImage(named: "bg.png")!
        self.view.backgroundColor = UIColor(patternImage: backImage)
        backGround.layer.cornerRadius = 20
        
        // Audio Setting
        bgmPlayer.volume = 0.5
        bgmPlayer.numberOfLoops = -1
        bgmPlayer.currentTime = 0.0
        btnPlayer1.volume = 0.5
        
        if (!opening) {
            opening = true
            
            startButton.hidden = true
            bookButton.hidden = true
            startButton.alpha = 0
            bookButton.alpha = 0
            
            mikkePlayer.play()
            loadingImageTimer = NSTimer.scheduledTimerWithTimeInterval(0.06, target: self, selector: #selector(ViewController.loadingAnimation), userInfo: nil, repeats: true)
            
        } else {
            bgmPlayer.play()
            
            NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(ViewController.loopAnimation), userInfo: nil, repeats: true)
        }
        
        
    }
    @IBAction func bookButtonAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0
        btnPlayer1.play()
        bgmPlayer.stop()
    }
    
    @IBAction func pushStart(sender: AnyObject) {
        let userName : AnyObject! = userConfig.objectForKey("name")
        btnPlayer1.currentTime = 0.0
        btnPlayer1.play()
        bgmPlayer.stop()
        
        if(userName as! String == "未設定"){
            appDelegate.bgmPlayer.play()
            performSegueWithIdentifier("toMissionTutorial",sender: self)
        }else{
            appDelegate.bgmPlayer.play()
            performSegueWithIdentifier("toMissionMainTutorialSkip",sender: self)
        }
        
    }
    
    @IBAction func hideButtonAction(sender: AnyObject) {
        let userName : AnyObject! = userConfig.objectForKey("name")
        if(userName as! String != "未設定"){
            userConfig.setObject("未設定", forKey: "name")
            userConfig.setObject("未設定", forKey: "favoriteColor")
            userConfig.synchronize()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadingAnimation() {
        if loadingImageCount < 60 {
            loadingImageCount += 1
        } else {
            loadingFinish()
        }
        logoImage.image = UIImage(named: "logo_\(loadingImageCount).png")
    }
    
    func loopAnimation() {
        if loadingImageCount < loadingImageTotalCount {
            loadingImageCount += 1
        } else {
            loadingImageCount = 60
        }
        logoImage.image = UIImage(named: "logo_\(loadingImageCount).png")
    }
    
    func loadingFinish() {
        bgmPlayer.play()
        
        self.loadingImageTimer.invalidate()
        self.loadingFinishTimer.invalidate()
        
        NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(ViewController.loopAnimation), userInfo: nil, repeats: true)

        UIView.animateWithDuration(0.6, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.startButton.hidden = false
            self.bookButton.hidden = false
            
            self.homeStart()
            
            /*self.logoImage.alpha = 0
            self.logoImage.center = CGPointMake(self.logoImage.center.x , self.logoImage.center.y - 500)*/
            }, completion: { (finished: Bool) in
                /*self.logoImage.hidden = true
                self.homeStart()*/
        })

    }
    
    func homeStart() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.startButton.alpha = 1
            self.bookButton.alpha = 1
            
            }, completion: { (finished: Bool) in
        })
    }

}

