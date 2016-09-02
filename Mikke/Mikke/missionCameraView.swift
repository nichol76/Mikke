//
//  missionCameraView.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/08/06.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit
import AVFoundation

class missionCameraView: UIViewController, UIGestureRecognizerDelegate {
    
    // Outlet
    @IBOutlet var titleView: UIView!
    @IBOutlet var titleViewBackGround: UIImageView!
    @IBOutlet var titleViewText: UIImageView!
    @IBOutlet var caputureView: UIView!
    @IBOutlet var validateView: UIImageView!
    @IBOutlet var cameraEyes: UIImageView!
    @IBOutlet var shutterReleaseButton: UIButton!
    
    // Images
    var currentImageOutput: AVCaptureStillImageOutput!
    var currentVideoLayer: AVCaptureVideoPreviewLayer!
    var currentImage:UIImage!
    
    // AVCapture
    var avSession: AVCaptureSession!
    var avDevice: AVCaptureDevice!
    var avInput: AVCaptureInput!
    var avOutput: AVCaptureStillImageOutput!
    
    // Eyes
    let loopEyesTotalCount = 87
    var loopEyesCount = 0
    var loopEyesTimer = NSTimer()
    
    // Audio
    var btnPlayer2 = bgm(bgm: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景イメージ設定
        titleViewBackGround.layer.cornerRadius = 20
        switch missionCurrent {
        case 0:
            titleViewText.image = UIImage(named:"missionCameraView_title_red.png")
            titleView.backgroundColor = UIColor(red:0.98, green:0.11, blue:0.11, alpha:1.0)
        case 1:
            titleViewText.image = UIImage(named:"missionCameraView_title_blue.png")
            titleView.backgroundColor = UIColor(red: 0.07, green: 0.2, blue: 0.76, alpha: 1.0)
        case 2:
            titleViewText.image = UIImage(named:"missionCameraView_title_yellow.png")
            titleView.backgroundColor = UIColor(red: 0.95, green: 0.79, blue: 0.03, alpha: 1.0)
        case 3:
            titleViewText.image = UIImage(named:"missionCameraView_title_green.png")
            titleView.backgroundColor = UIColor(red: 0.03, green: 0.48, blue: 0.2, alpha: 1.0)
        case 4:
            titleViewText.image = UIImage(named:"missionCameraView_title_white.png")
            titleView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        case 5:
            titleViewText.image = UIImage(named:"missionCameraView_title_black.png")
            titleView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        case 6:
            titleViewText.image = UIImage(named:"missionCameraView_title_circle.png")
            titleView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_circle.png")!)
        case 7:
            titleViewText.image = UIImage(named:"missionCameraView_title_triangle.png")
            titleView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_triangle.png")!)
        case 8:
            titleViewText.image = UIImage(named:"missionCameraView_title_square.png")
            titleView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_square.png")!)
        default:
            break // do nothing
        }
        
        // Audio Setting
        btnPlayer2.volume = 0.5
        
        //
        validateView.hidden = true
        
        //
        loopEyesTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: #selector(missionCameraView.loopEyesAnimation), userInfo: nil, repeats: true)
        
        // AVキャプチャセッション
        avSession = AVCaptureSession()
        avSession.sessionPreset = AVCaptureSessionPresetHigh
        
        // AVキャプチャデバイス
        let devices = AVCaptureDevice.devices()
        
        // (前背面カメラやマイク等のデバイス)
        for device in devices {
            if (device.position == AVCaptureDevicePosition.Back) {
                avDevice = device as! AVCaptureDevice
            }
        }
        do {
            // AVキャプチャデバイスインプット
            avInput = try AVCaptureDeviceInput(device: avDevice)
            avSession.addInput(avInput)
            
            // AVキャプチャアウトプット
            avOutput = AVCaptureStillImageOutput()
            avSession.addOutput(avOutput)
            
            // 画像を表示するレイヤーを生成.
            currentVideoLayer = AVCaptureVideoPreviewLayer.init(session:avSession)
            currentVideoLayer.frame = self.view.bounds
            currentVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            // Viewに追加.
            self.caputureView.layer.addSublayer(self.currentVideoLayer)
            
            // セッション開始.
            avSession.startRunning()
        } catch let error as NSError {
            print("cannot use camera \(error)")
        }
    }
    
    @IBAction func shutterReleaseAction(sender: AnyObject) {
        // ビデオ出力に接続する
        let videoConnection = avOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        // 接続から画像を取得する
        self.avOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
            
            // Jpegに変換する (NSDataにはExifなどのメタデータも含まれている)
            let imageData: NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            
            // UIIMageを作成する
            self.currentImage = UIImage(data: imageData)!
            self.validateView.image = self.currentImage
            
            self.shutterReleaseButton.hidden = true
            self.caputureView.hidden = true
            self.validateView.hidden = false
            self.performSegueWithIdentifier("toMissionComplete",sender: nil)
        })
    }
    
    @IBAction func backButtonAction(sender: AnyObject) {
        btnPlayer2.currentTime = 0.0;
        btnPlayer2.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.currentVideoLayer.frame = self.caputureView.bounds
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        // カメラの停止とメモリ解放
        self.avSession.stopRunning()
        
        for output in self.avSession.outputs {
            self.avSession.removeOutput(output as? AVCaptureOutput)
        }
        
        for input in self.avSession.inputs {
            self.avSession.removeInput(input as? AVCaptureInput)
        }
        
        self.avOutput = nil
        self.avInput = nil
        self.avDevice = nil
        self.avSession = nil
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toMissionComplete") {
            let nextVC: missionComplete = (segue.destinationViewController as? missionComplete)!
            // ViewControllerのvc2Textにメッセージを設定
            nextVC.currentImage = currentImage
        }
    }
    
    func loopEyesAnimation() {
        if loopEyesCount < loopEyesTotalCount {
            loopEyesCount += 1
        } else {
            loopEyesCount = 0
        }
        cameraEyes.image = UIImage(named: "camera_\(loopEyesCount).png")
    }

}
