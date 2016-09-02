//
//  bookView.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/08/07.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit
import AVFoundation

class bookView: UIViewController {
    // Outlet
    @IBOutlet var backGround: UIImageView!
    @IBOutlet var nameView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleView: UIImageView!
    
    // View
    @IBOutlet var mainView: UIView!
    @IBOutlet var medalListView: UIView!
    
    // Audio
    var bgmPlayer = bgm(bgm: 4)
    var btnPlayer1 = bgm(bgm: 1)
    
    // Loading int
    let loadingImageTotalCount = 38
    var loadingImageCount = 0
    var loadingImageTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Audio Setting
        bgmPlayer.volume = 0.5
        bgmPlayer.numberOfLoops = -1
        bgmPlayer.currentTime = 0.0
        bgmPlayer.play()
        
        // BackGround Setting
        let backImage = UIImage(named: "bg.png")!
        self.view.backgroundColor = UIColor(patternImage: backImage)
        backGround.layer.cornerRadius = 20
        
        
        let userName : AnyObject! = userConfig.objectForKey("name")
        
        // userNameが未設定じゃなければ名前を設定
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
            nameView.frame = CGRectMake(mainView.layer.bounds.width/2 - nameViewWidth/2, 62, nameViewWidth
                , 24)
            nameLabel.layer.position = CGPoint(x: nameLabel.layer.bounds.width,y: 0)
        }
        
        initImageView()
        
        loadingImageTimer = NSTimer.scheduledTimerWithTimeInterval(0.06, target: self, selector: #selector(self.loadingAnimation), userInfo: nil, repeats: true)
    }
    
    func initImageView(){
        // UIImage インスタンスの生成
        let image1:UIImage? = UIImage(named:"book_ico_flag_red.png")
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image1)
        
        // 画像の中心を設定
        imageView.center = CGPointMake(0,0)
        
        // UIImageViewのインスタンスをビューに追加
        mainView.addSubview(imageView)
        
    }
    
    func loadingAnimation() {
        if loadingImageCount < 38 {
            loadingImageCount += 1
        } else {
            self.loadingImageTimer.invalidate()
        }
        titleView.image = UIImage(named: "book_ttl_diary_\(loadingImageCount).png")
    }
    
    @IBAction func topButtonAction(sender: AnyObject) {
        bgmPlayer.stop()
        btnPlayer1.currentTime = 0.0
        btnPlayer1.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
