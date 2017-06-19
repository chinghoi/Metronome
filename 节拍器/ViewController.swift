//
//  ViewController.swift
//  节拍器
//
//  Created by lolizzZ on 2017/5/22.
//  Copyright © 2017年 lolizzZ. All rights reserved.
//

import UIKit
import HGCircularSlider
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var circular: CircularSlider!
    @IBOutlet weak var speedLabler: UILabel!
    @IBOutlet weak var noteSelection: UISegmentedControl!
    @IBOutlet weak var beat: UISegmentedControl!
    
    var myPlayer :AVAudioPlayer!
    var isPlaying = false
    var timer: Timer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //圆的属性
        circular.minimumValue = 0
        circular.maximumValue = 256
        circular.endPointValue = 60
        speedLabler.text = "\(setupSlider())" //显示便签数字
        
        // 添加标签手势
        speedLabler.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.playLable))
        
        //绑定tap
        speedLabler.addGestureRecognizer(tap)
        self.view.addSubview(speedLabler)
    }
    func playLable(){
        //播放按钮
        if setupSlider() != 0 { //速度为0不做反应
            if isPlaying {
                isPlaying = false
                timer.invalidate() //停止计时器再次触发，并请求从其运行循环中删除它
            } else {
                isPlaying = true
                playMode()
            }
        }
    }
    
    func playMode() {  //播放模式选择
        //读取分段控件上的文本
        var mirrorStr = beat.titleForSegment(at: beat.selectedSegmentIndex)!//获取选中的坐标
        let firstChar = mirrorStr.remove(at: mirrorStr.startIndex) //获取分子数
        if Int(String(firstChar))!%2 == 0 {
            D_d()
        } else {
            D_dd()
        }
        print("调用成功")
    }
    
    func D_d () { //强弱
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(60/setupSlider()), target: self, selector: #selector(playD_d), userInfo: nil, repeats: true)
    }
    func D_dd () { //强弱弱
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(60/setupSlider()), target: self, selector: #selector(playD_dd), userInfo: nil, repeats: true)
    }
    
    func playD_d() {
        var a = 2
        if a%2 == 0 {
            print("播放成功1强")
            // 建立播放器
            let soundPath = Bundle.main.path(
                forResource: "ding", ofType: "wav")
            do {
                myPlayer = try AVAudioPlayer(
                    contentsOf: NSURL.fileURL(withPath: soundPath!))
                
                // 重複播放次數 設為 0 則是只播放一次 不重複
                myPlayer.numberOfLoops = 0
                
            } catch {
                print("error")
            }
            myPlayer.play()
            a = a + 1
            
        }
        else if a%2 == 1 {
            print("播放成功2弱")
            // 建立播放器
            let soundPath = Bundle.main.path(
                forResource: "beat", ofType: "mp3")
            do {
                myPlayer = try AVAudioPlayer(
                    contentsOf: NSURL.fileURL(withPath: soundPath!))
                
                // 重複播放次數 設為 0 則是只播放一次 不重複
                myPlayer.numberOfLoops = 0
                
            } catch {
                print("error")
            }
            myPlayer.play()
            a = a + 1
        }
    }
    func playD_dd() {
        var b = 3
        if b%3 == 0 {
            print("播放成功2强")
            // 建立播放器
            let soundPath = Bundle.main.path(
                forResource: "ding", ofType: "wav")
            do {
                myPlayer = try AVAudioPlayer(
                    contentsOf: NSURL.fileURL(withPath: soundPath!))
                
                // 重複播放次數 設為 0 則是只播放一次 不重複
                myPlayer.numberOfLoops = 0
                
            } catch {
                print("error")
            }
            myPlayer.play()
            b = b + 1
            
        }
        else if b%3 == 1 {
            print("播放成功2弱")
            // 建立播放器
            let soundPath = Bundle.main.path(
                forResource: "beat", ofType: "mp3")
            do {
                myPlayer = try AVAudioPlayer(
                    contentsOf: NSURL.fileURL(withPath: soundPath!))
                
                // 重複播放次數 設為 0 則是只播放一次 不重複
                myPlayer.numberOfLoops = 0
                
            } catch {
                print("error")
            }
            myPlayer.play()
            b = b + 1
        }
        else if b%3 == 2 {
            print("播放成功2弱弱")
            // 建立播放器
            let soundPath = Bundle.main.path(
                forResource: "beat", ofType: "mp3")
            do {
                myPlayer = try AVAudioPlayer(
                    contentsOf: NSURL.fileURL(withPath: soundPath!))
                
                // 重複播放次數 設為 0 則是只播放一次 不重複
                myPlayer.numberOfLoops = 0
                
            } catch {
                print("error")
            }
            myPlayer.play()
            b = b + 1
        }
        
    }
    func setupSlider() -> Int{
        // 更新圆中的数字
        
        circular.addTarget(self, action: #selector(updateValue), for: .valueChanged)
        circular.addTarget(self, action: #selector(adjustValue), for: .editingDidEnd)
        return Int(circular.endPointValue)
        
    }
    func updateValue() {
        var selectedValue = Int(circular.endPointValue)
        selectedValue = (selectedValue == 256 ? 0 : selectedValue)
        speedLabler.text = String(format: "%02d", selectedValue)
    }
    
    func adjustValue() {
        let selectedMinute = round(circular.endPointValue)
        circular.endPointValue = selectedMinute
        updateValue()
    }
    
    
    @IBAction func noteChanged(_ sender: Any) {
        // 音符选择按钮
        switch noteSelection.selectedSegmentIndex
        {
        case 0:
            //  ---2分音符
            
            beat.setTitle("2/2", forSegmentAt: 0)
            beat.setTitle("3/2", forSegmentAt: 1)
            beat.setTitle("4/2", forSegmentAt: 2)
            if beat.numberOfSegments == 5 {
                beat.removeSegment(at: 4, animated: true)
                beat.removeSegment(at: 3, animated: true)
            } else if beat.numberOfSegments == 4{
                beat.removeSegment(at: 3, animated: true)
            }
            
        case 1:
            // ---4分音符
            
            
            beat.setTitle("1/4", forSegmentAt: 0)
            beat.setTitle("2/4", forSegmentAt: 1)
            beat.setTitle("3/4", forSegmentAt: 2)
            if beat.numberOfSegments == 3 {
                beat.insertSegment(withTitle: "4/4", at: 3, animated: true)
                beat.insertSegment(withTitle: "5/4", at: 4, animated: true)
            }else if beat.numberOfSegments == 4 {
                beat.setTitle("4/4", forSegmentAt: 3)
                beat.insertSegment(withTitle: "5/4", at: 4, animated: true)
            }
            
        case 2:
            // ---8分音符
            
            
            beat.setTitle("3/8", forSegmentAt: 0)
            beat.setTitle("6/8", forSegmentAt: 1)
            beat.setTitle("9/8", forSegmentAt: 2)
            if beat.numberOfSegments == 3 {
                beat.insertSegment(withTitle: "12/8", at: 3, animated: true)
            } else if beat.numberOfSegments == 5 {
                beat.setTitle("12/8", forSegmentAt: 3)
                beat.removeSegment(at: 4, animated: true)
            }
            
            
        default:
            break
        }
    }
    //在五线谱中，节拍是用一种类似于分数的形式表示的，我们称之为拍号，它位于谱号的右侧。就跟所有的分数一样，拍号既有分子也有分母。这里的分子写在上两间之间，表示每一小节有多少拍。分母写在下两间之中，表示以什么音符为一拍（下面是4就是四分音符）。
}
