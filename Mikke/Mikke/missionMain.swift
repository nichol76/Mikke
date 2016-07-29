//
//  missionMain.swift
//  Mikke
//
//  Created by Yuko Katsuda on 2016/07/27.
//  Copyright © 2016年 Yuko Katsuda. All rights reserved.
//

import UIKit

class missionMain: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate {
    
    var currentImage:UIImage!
    let toVC2Text = "from VC1"
    
    @IBAction func cameraStart(sender: AnyObject) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.presentViewController(cameraPicker, animated: true, completion: nil)
            
        }
        else{
            showAlert("", message: "Error of the camera function.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            currentImage = pickedImage
        }
        
        performSegueWithIdentifier("toMissionComplete",sender: nil)
        
        
        //閉じる処理
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        /*if (segue.identifier == "toMissionComplete") {
            let vc2: missionComplete = (segue.destinationViewController as? missionComplete)!
            // ViewControllerのvc2Textにメッセージを設定
            vc2.vc2Text = toVC2Text
        }*/
    }
    
    // アラートを表示する
    func showAlert(title: String, message: String) {
        let alertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
