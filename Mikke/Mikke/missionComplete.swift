//
//  missionComplete.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/07/29.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit

class missionComplete: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // Outlet
    @IBOutlet var titleView: UIView!
    @IBOutlet var titleViewBackGround: UIImageView!
    @IBOutlet var thumbView: UIImageView!
    @IBOutlet var modalView: UIView!
    @IBOutlet var modalViewSave: UIView!
    @IBOutlet var modalViewMedal: UIView!
    
    // Image
    var currentImage:UIImage?
    
    // Audio
    var btnPlayer1 = bgm(bgm: 1)
    var btnPlayer2 = bgm(bgm: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.thumbView.image = currentImage
        
        modalView.hidden = true
        modalViewSave.hidden = true
        modalViewMedal.hidden = true
        
        // 背景イメージ設定
        titleViewBackGround.layer.cornerRadius = 20
        switch missionCurrent {
        case 0:
            titleView.backgroundColor = UIColor(red:0.98, green:0.11, blue:0.11, alpha:1.0)
        case 1:
            titleView.backgroundColor = UIColor(red: 0.07, green: 0.2, blue: 0.76, alpha: 1.0)
        case 2:
            titleView.backgroundColor = UIColor(red: 0.95, green: 0.79, blue: 0.03, alpha: 1.0)
        case 3:
            titleView.backgroundColor = UIColor(red: 0.03, green: 0.48, blue: 0.2, alpha: 1.0)
        case 4:
            titleView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        case 5:
            titleView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        case 6:
            titleView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_circle.png")!)
        case 7:
            titleView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_triangle.png")!)
        case 8:
            titleView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_square.png")!)
        default:
            break // do nothing
        }
        
        // Audio Setting
        btnPlayer1.volume = 0.5
        btnPlayer2.volume = 0.5
    }
    
    // ○ボタン押したとき
    @IBAction func savePicture(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        // カメラロールに画像を保存
        let image:UIImage! = thumbView.image
        if image != nil {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(missionComplete.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        else{
            print("error")
        }
    }
    
    // ×ボタン押したとき
    @IBAction func cameraAgain(sender: AnyObject) {
        btnPlayer2.currentTime = 0.0;
        btnPlayer2.play()
        self.move("backToCameraFromComplete")
    }
    
    @IBAction func modalSaveOkBtnAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        if(medalFlg){
            modalViewMedal.alpha = 0
            modalViewMedal.hidden = false
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.modalViewSave.alpha = 0
                }, completion: { finished in
                    self.modalViewSave.hidden = true
            })
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.modalViewMedal.alpha = 1
            })
            
        } else {
            self.move("backToMissionMain")
        }
    }

    @IBAction func modalMedalOkBtnAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        self.move("backToMissionMain")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 書き込み完了結果の受け取り
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        if error != nil {
            let alertCtr = UIAlertController(title: "",message: "エラーだよ",preferredStyle: .Alert)
            let defaultAction:UIAlertAction = UIAlertAction(title: "もどる",style: UIAlertActionStyle.Default,handler:{(action:UIAlertAction!) -> Void in
                print("Error")
            })
            
            alertCtr.addAction(defaultAction)
            
            presentViewController(alertCtr, animated: true, completion: nil)
        } else {
            // メダルの数をカウント
            medalTotalCount += 1
            if(medalTotalCount >= medalCount){
                medalFlg = true
            }
            
            // 現在発見した数カウント
            findCurrentCount += 1
            
            modalView.alpha = 0
            modalView.hidden = false
            modalViewSave.hidden = false
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.modalView.alpha = 1
            })
        }
    }
    
    func move(vcId:String){
        performSegueWithIdentifier(vcId,sender: self)
        
    }

}
