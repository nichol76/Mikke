//
//  missionTutorial.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/07/26.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit

class missionTutorial: UIViewController, UITextFieldDelegate {
    
    // Outlet
    @IBOutlet var backGround: UIImageView!
    @IBOutlet var tutorialText: UIImageView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var nameInputField: UITextField!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var favoriteColorView: UIImageView!
    
    // page
    @IBOutlet var page1: UIView!
    @IBOutlet var page2: UIView!
    @IBOutlet var page3: UIView!
    
    // favoriteColorButton
    @IBOutlet var favoriteColorButtonRed: UIButton!
    @IBOutlet var favoriteColorButtonBlue: UIButton!
    @IBOutlet var favoriteColorButtonYellow: UIButton!
    @IBOutlet var favoriteColorButtonGreen: UIButton!
    @IBOutlet var favoriteColorButtonWhite: UIButton!
    @IBOutlet var favoriteColorButtonBlack: UIButton!
    
    // Audio
    var btnPlayer1 = bgm(bgm: 1)
    var btnPlayer2 = bgm(bgm: 2)
    
    // Page
    var pageNum = 0
    
    var favoriteImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInputField.delegate = self
        
        // BackGround Setting
        let backImage = UIImage(named: "bg.png")!
        self.view.backgroundColor = UIColor(patternImage: backImage)
        backGround.layer.cornerRadius = 20
        
        // Audio Setting
        btnPlayer1.volume = 0.5
        btnPlayer2.volume = 0.5
        
        // Page
        page2.hidden = true
        page3.hidden = true

    }
    
    // NextButton
    @IBAction func nextButtonAction(sender: AnyObject) {
        let userName : AnyObject! = userConfig.objectForKey("name")
        let favoriteColor : AnyObject! = userConfig.objectForKey("favoriteColor")
        
        if(pageNum == 0){
            if(userName as! String != "未設定"){
                pageNum += 1
                
                btnPlayer1.currentTime = 0.0;
                btnPlayer1.play()
                
                page2.alpha = 0
                page2.hidden = false
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.page1.alpha = 0
                }, completion: { finished in
                    self.page1.hidden = true
                })
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.page2.alpha = 1
                })
            }else{
                btnPlayer2.currentTime = 0.0;
                btnPlayer2.play()
            }
        } else if(pageNum == 1){
            if(favoriteColor as! String != "未設定"){
                pageNum += 1
                
                btnPlayer1.currentTime = 0.0;
                btnPlayer1.play()
                
                page3.alpha = 0
                page3.hidden = false
                
                favoriteColorView.image = favoriteImage
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.page2.alpha = 0
                    }, completion: { finished in
                        self.page2.hidden = true
                })
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.page3.alpha = 1
                })
            }else{
                btnPlayer2.currentTime = 0.0;
                btnPlayer2.play()
            }
        } else if(pageNum == 2){
            btnPlayer1.currentTime = 0.0;
            btnPlayer1.play()
            performSegueWithIdentifier("toMissionMain",sender: self)
        }
    }
    
    @IBAction func nameInputFieldAction(sender: AnyObject) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // キーボードを開いている時、キーボード以外タップで閉じる
        if(nameInputField.isFirstResponder()){
            nameInputField.resignFirstResponder()
        }
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var textFieldString = textField.text! as NSString
        
        textFieldString = textFieldString.stringByReplacingCharactersInRange(range, withString: string)
        if(textFieldString == ""){
            userConfig.setObject("未設定",forKey:"name")
            userConfig.synchronize()
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        // テキストフィールドの値をname変数に格納
        let name = nameInputField.text!
        let nameSize = name.characters.count
        
        if(name != "" && nameSize < 11){
            // もし空じゃなく6文字以内ならuserName変数に名前を設定
            userConfig.setObject(name,forKey:"name")
            userConfig.synchronize()
        } else {
            userConfig.setObject("未設定",forKey:"name")
            userConfig.synchronize()
        }
        
        let userName : AnyObject! = userConfig.objectForKey("name")

        // userNameが未設定じゃなければ
        if(userName as! String != "未設定"){
            // page2のラベルにuserNameを設定
            nameLabel.text = userName as? String
            
            // nameLabelをuserNameの長さにフィット
            nameLabel.sizeToFit()
            
            // nameViewのAutoLayoutを解除
            nameView.translatesAutoresizingMaskIntoConstraints = true
            
            // nameViewの横幅を変数に格納
            let nameViewWidth = nameLabel.layer.bounds.width + 80
            
            // nameViewを左右中央に配置
            nameView.frame = CGRectMake(page2.layer.bounds.width/2 - nameViewWidth/2, 62, nameViewWidth
                , 24)
            nameLabel.layer.position = CGPoint(x: nameLabel.layer.bounds.width,y: 0)
        }
        
        // returnタップでキーボードを閉じる
        nameInputField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func favoriteColorButtonRedAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        userConfig.setObject("あか",forKey:"favoriteColor")
        userConfig.synchronize()
        
        favoriteColorButtonRed.selected = true
        favoriteColorButtonBlue.selected = false
        favoriteColorButtonYellow.selected = false
        favoriteColorButtonGreen.selected = false
        favoriteColorButtonWhite.selected = false
        favoriteColorButtonBlack.selected = false
        
        favoriteImage = UIImage(named:"missionTutorial_page3_txt1_0.png")
        
        missionRecent = 0
        missionCurrent = 0
    }
    
    @IBAction func favoriteColorButtonBlueAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        userConfig.setObject("あお",forKey:"favoriteColor")
        userConfig.synchronize()
        
        favoriteColorButtonRed.selected = false
        favoriteColorButtonBlue.selected = true
        favoriteColorButtonYellow.selected = false
        favoriteColorButtonGreen.selected = false
        favoriteColorButtonWhite.selected = false
        favoriteColorButtonBlack.selected = false
        
        favoriteImage = UIImage(named:"missionTutorial_page3_txt2_0.png")
        
        missionRecent = 1
        missionCurrent = 1
    }
    
    @IBAction func favoriteColorButtonYellowAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        userConfig.setObject("きいろ",forKey:"favoriteColor")
        userConfig.synchronize()

        favoriteColorButtonRed.selected = false
        favoriteColorButtonBlue.selected = false
        favoriteColorButtonYellow.selected = true
        favoriteColorButtonGreen.selected = false
        favoriteColorButtonWhite.selected = false
        favoriteColorButtonBlack.selected = false
        
        favoriteImage = UIImage(named:"missionTutorial_page3_txt3_0.png")
        
        missionRecent = 2
        missionCurrent = 2
    }
    
    @IBAction func favoriteColorButtonGreenAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        userConfig.setObject("みどり",forKey:"favoriteColor")
        userConfig.synchronize()

        favoriteColorButtonRed.selected = false
        favoriteColorButtonBlue.selected = false
        favoriteColorButtonYellow.selected = false
        favoriteColorButtonGreen.selected = true
        favoriteColorButtonWhite.selected = false
        favoriteColorButtonBlack.selected = false
        
        favoriteImage = UIImage(named:"missionTutorial_page3_txt4_0.png")
        
        missionRecent = 3
        missionCurrent = 3
    }
    
    @IBAction func favoriteColorButtonWhiteAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        userConfig.setObject("しろ",forKey:"favoriteColor")
        userConfig.synchronize()
        
        favoriteColorButtonRed.selected = false
        favoriteColorButtonBlue.selected = false
        favoriteColorButtonYellow.selected = false
        favoriteColorButtonGreen.selected = false
        favoriteColorButtonWhite.selected = true
        favoriteColorButtonBlack.selected = false
        
        favoriteImage = UIImage(named:"missionTutorial_page3_txt5_0.png")
        
        missionRecent = 4
        missionCurrent = 4
    }
    
    @IBAction func favoriteColorButtonBlackAction(sender: AnyObject) {
        btnPlayer1.currentTime = 0.0;
        btnPlayer1.play()
        
        userConfig.setObject("くろ",forKey:"favoriteColor")
        userConfig.synchronize()
        
        favoriteColorButtonRed.selected = false
        favoriteColorButtonBlue.selected = false
        favoriteColorButtonYellow.selected = false
        favoriteColorButtonGreen.selected = false
        favoriteColorButtonWhite.selected = false
        favoriteColorButtonBlack.selected = true
        
        favoriteImage = UIImage(named:"missionTutorial_page3_txt6_0.png")
        
        missionRecent = 5
        missionCurrent = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
