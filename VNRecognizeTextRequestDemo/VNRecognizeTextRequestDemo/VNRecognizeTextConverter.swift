//
//  VNRecognizeTextConverter.swift
//  VNRecognizeTextRequestDemo
//
//  Created by STV-M025 on 2020/03/13.
//  Copyright © 2020 STV-M025. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

protocol VNRecognizeTextConverterDelegate: class {
    func didGetConvertedString(_ str: String)
}

final class VNRecognizeTextConverter: NSObject {

    var delegate: VNRecognizeTextConverterDelegate?

    func convertStart(image: UIImage){
        guard let cgImage = image.cgImage else { return  }
        let request = VNRecognizeTextRequest(completionHandler: self.recognizeTextHandler)
        request.recognitionLevel = .accurate  // .accurate と .fast が選択可能
        request.recognitionLanguages = ["en_US"] // 言語を選ぶ
        request.usesLanguageCorrection = true // 訂正するかを選ぶ

        let requests = [request]
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,  options: [:])
        try! imageRequestHandler.perform(requests)
    }

    func recognizeTextHandler(request: VNRequest?, error: Error?) {
        guard let observations = request?.results as? [VNRecognizedTextObservation] else {
            return
        }

        var str = ""

        for observation in observations {
            let candidates = 1
            guard let bestCandidate = observation.topCandidates(candidates).first else {
                continue
            }
            print(bestCandidate.string) // 文字認識結果
            // bestCandidate.confidence // 文字認識のスコア
            // observation.boundingBox // 文字認識の領域
            str += bestCandidate.string + "\n"
        }
        delegate?.didGetConvertedString(str)
    }

}
