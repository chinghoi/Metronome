//
//  ViewController.swift
//  节拍器
//
//  Created by lolizzZ on 2017/5/22.
//  Copyright © 2017年 lolizzZ. All rights reserved.
//

import UIKit
import HGCircularSlider

class ViewController: UIViewController {


    @IBOutlet weak var circular: CircularSlider!
    @IBOutlet weak var speedLabler: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlider()
    }

    func setupSlider() {
        circular.minimumValue = 0
        circular.maximumValue = 180
        circular.endPointValue = 40
        circular.addTarget(self, action: #selector(updateValue), for: .valueChanged)
        circular.addTarget(self, action: #selector(adjustValue), for: .editingDidEnd)
    }
    func updateValue() {
        var selectedValue = Int(circular.endPointValue)
        // TODO: use date formatter
        selectedValue = (selectedValue == 180 ? 0 : selectedValue)
        speedLabler.text = String(format: "%02d", selectedValue)
    }
    
    func adjustValue() {
        let selectedMinute = round(circular.endPointValue)
        circular.endPointValue = selectedMinute
        updateValue()
    }

}

