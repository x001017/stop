//
//  ViewController.swift
//  StopWatch_ModulTest_1
//
//  Created by HisashiShindo on 2016/06/17.
//  Copyright © 2016年 HisashiShindo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 時間表示用のラベル
    
    @IBOutlet weak var myTimeLabel: UILabel!
    
    // NSTimeInterval：時間を計算するメソッド
    var startTime = NSTimeInterval()
    
    // NSTimer：タイマーを管理するクラス
    var timer:NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // スタートボタンが押された時の設定
    
    @IBAction func myBtnStart(sender: AnyObject) {
        
        if (!timer.valid) {
            let mySelector : Selector = #selector(ViewController.myStartTime)
            
            // NSTimer：タイマーを管理するクラス
              //（１）scheduledTimerWithTimeInterval：時間の間隔〔0.01〕
              //（２）target：タイマー発生時に呼び出すメソッドがあるtarget〔self〕
              //（３）selector：タイマー発生時に呼び出すメソッドを指定〔mySelector〕
              //（４）userInfo：selectorで呼びだすメソッドに渡す情報〔nil〕
              //（５）repeats：タイマーの実行を繰り返すかどうかの指定〔true〕
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: mySelector, userInfo: nil, repeats: true)
            
            // NSDate：日付と時間を管理するクラス
            startTime = NSDate.timeIntervalSinceReferenceDate()

        }
    }
    
    // ストップボタンが押された時の設定
      //〔ストップボタン〕が押されたら無効化〔invalidate：無効化〕
    
    @IBAction func myBtnStop(sender: AnyObject) {
        timer.invalidate()
    }
    
    func myStartTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        // 現在の時間を調べるためにスタートします
        var myTime: NSTimeInterval = currentTime - startTime
        
        //〔分〕を計算
          // UInt8：8 ビット符号なし整数への変換
          // NSTimeInterval：引数に時間の長さを示す値
        let minutes = UInt8(myTime / 60.0)
        myTime -= (NSTimeInterval(minutes) * 60)
        
        //〔秒〕を計算
        let seconds = UInt8(myTime)
        myTime -= NSTimeInterval(seconds)
        
        //〔ミリ秒〕を計算
        let flaction = UInt8(myTime * 100)
        
        //〔分〕〔秒〕〔ミリ秒〕を文字列にします
        let timeMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let timeSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let timeFraction = flaction > 9 ? String(flaction):"0" + String(flaction)
        
        // 時間表示用のラベルに〔分〕〔秒〕〔ミリ秒〕を表示
        myTimeLabel.text = "\(timeMinutes):\(timeSeconds):\(timeFraction)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

