//
//  missionMain.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/07/27.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit
import AVFoundation

class missionMain: UIViewController {
    
    // Outlet
    @IBOutlet var backGround: UIImageView!
    @IBOutlet var currentMissionImage: UIImageView!
    @IBOutlet var missionCountView: UIImageView!
    @IBOutlet var modalView: UIView!
    @IBOutlet var modalViewHome: UIView!
    @IBOutlet var modalViewMikke: UIView!
    @IBOutlet var modalViewMikkeCountLabel: UILabel!
    
    // Image
    var currentImage:UIImage!
    
    // Audio
    var btnPlayer1 = bgm(bgm: 1)
    var btnPlayer2 = bgm(bgm: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // BackGround Setting
        let backImage = UIImage(named: "bg.png")!
        self.view.backgroundColor = UIColor(patternImage: backImage)
        backGround.layer.cornerRadius = 20
        
        // モーダル初期設定
        modalView.hidden = true
        modalViewHome.hidden = true
        modalViewMikke.hidden = true
        
        // Audio Setting
        btnPlayer1.volume = 0.5
        btnPlayer2.volume = 0.5
        
        // メダルの数をチェック
        if(medalFlg) {
            medalTotalCount = 0
            medalFlg = false
            
            missionSlot()
        }
        
        switch missionCurrent {
        case 0:
            currentMissionImage.image = UIImage(named:"missionMain_title_red.png")
        case 1:
            currentMissionImage.image = UIImage(named:"missionMain_title_blue.png")
        case 2:
            currentMissionImage.image = UIImage(named:"missionMain_title_yellow.png")
        case 3:
            currentMissionImage.image = UIImage(named:"missionMain_title_green.png")
        case 4:
            currentMissionImage.image = UIImage(named:"missionMain_title_white.png")
        case 5:
            currentMissionImage.image = UIImage(named:"missionMain_title_black.png")
        case 6:
            currentMissionImage.image = UIImage(named:"missionMain_title_circle.png")
        case 7:
            currentMissionImage.image = UIImage(named:"missionMain_title_triangle.png")
        case 8:
            currentMissionImage.image = UIImage(named:"missionMain_title_square.png")
        default:
            break // do nothing
        }
        
        if( missionCurrent == 4 ||
            missionCurrent == 6 ||
            missionCurrent == 7 ||
            missionCurrent == 8 ) {
            
            switch medalTotalCount {
            case 0:
                missionCountView.image = UIImage(named:"missionMain_txt_count_0_gr.png")
            case 1:
                missionCountView.image = UIImage(named:"missionMain_txt_count_1_gr.png")
            case 2:
                missionCountView.image = UIImage(named:"missionMain_txt_count_2_gr.png")
            default:
                break // do nothing
            }
        } else {
            switch medalTotalCount {
            case 0:
                missionCountView.image = UIImage(named:"missionMain_txt_count_0_wh.png")
            case 1:
                missionCountView.image = UIImage(named:"missionMain_txt_count_1_wh.png")
            case 2:
                missionCountView.image = UIImage(named:"missionMain_txt_count_2_wh.png")
            default:
                break // do nothing
            }
        }
        
    }
    
    @IBAction func cameraStart(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
    }
    
    
    @IBAction func backButtonAction(sender: AnyObject) {
        if(findCurrentCount > 0){
            btnPlayer1.currentTime = 0.0;
            btnPlayer1.play()
            
            modalView.alpha = 0
            modalView.hidden = false
            modalViewHome.hidden = false
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.modalView.alpha = 1
            })
        } else {
            btnPlayer2.currentTime = 0.0;
            btnPlayer2.play()
            appDelegate.bgmPlayer.stop()
            performSegueWithIdentifier("backToStart",sender: self)
        }
    }
    
    @IBAction func modalViewHomeNoBtnAction(sender: AnyObject) {
        btnPlayer2.currentTime = 0.0;
        btnPlayer2.play()
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.modalView.alpha = 0
            }, completion: { finished in
                self.modalView.hidden = true
                self.modalViewHome.hidden = true
        })
    }

    @IBAction func modalViewHomeYesBtnAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        let count = findCurrentCount
        modalViewMikkeCountLabel.text = String(count)
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.modalViewHome.alpha = 0
            }, completion: { finished in
                self.modalViewHome.hidden = true
        })
        
        modalViewMikke.alpha = 0
        modalViewMikke.hidden = false
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.modalViewMikke.alpha = 1
        })
    }

    @IBAction func modalViewMikkeOkBtnAction(sender: AnyObject) {
        appDelegate.bgmPlayer.stop()
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        // おさんぽリセット
        findCurrentCount = 0
        medalTotalCount = 0
        medalFlg = false
        missionSlot()
        
        performSegueWithIdentifier("backToStart",sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // お題スロット
    func missionSlot(){
        let number = random() % missionTotalCount
        if number != missionCurrent {
            missionRecent = missionCurrent
            missionCurrent = number
        }else{
            missionSlot()
        }
    }
}
