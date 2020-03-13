//
//  TopViewController.swift
//  VNRecognizeTextRequestDemo
//
//  Created by STV-M025 on 2020/03/13.
//  Copyright © 2020 STV-M025. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    let converter = VNRecognizeTextConverter()

    override func viewDidLoad() {
        super.viewDidLoad()
        converter.delegate = self
    }

    @IBAction func didTapImage(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func didTapConvertButton(_ sender: UIButton) {
        guard let image = imageView.image else {
            print("cannot get a image")
            return
        }
        converter.convertStart(image: image)
    }
}

// MARK: - VNRecognizeTextConverterDelegate
extension TopViewController: VNRecognizeTextConverterDelegate {
    func didGetConvertedString(_ str: String) {
        print(str)
        textView.text = str
    }
}
