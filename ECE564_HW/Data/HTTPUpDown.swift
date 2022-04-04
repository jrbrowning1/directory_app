//
//  HTTPUpDown.swift
//  ECE564_HW
//
//  Created by Jonathan Browning on 1/30/22.
//  Copyright © 2022 ECE564. All rights reserved.
//

import Foundation
import UIKit

let myNet = "jrb127"
let token = "91EE374ECCC981BB438C61C76D9968BF"

class REST {
    let httpString = "http://kitura-fall-2021.vm.duke.edu:5640/b64entries"
    weak var delegate: URLSessionDownloadDelegate?
    
    convenience init(delegate: URLSessionDownloadDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    func download() {
        print("shit")
        let url = URL(string: httpString)
        let session : URLSession = {
            let config = URLSessionConfiguration.ephemeral
            config.allowsCellularAccess = false
            let session = URLSession(configuration: config, delegate: delegate, delegateQueue: .main)
            return session
        }()
        let downloadRequest = session.downloadTask(with: url!)
        downloadRequest.resume()
        print("hellow world")
        print(downloadRequest)
    }
    
    // significant code pulled from https://developer.apple.com/documentation/foundation/url_loading_system/uploading_data_to_a_website?language=objc
    func upload(person: DukePerson) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let personJsonData = try! encoder.encode(person)
//        print(String(data: personJsonData, encoding: .utf8)!)

        let loginString = "\(myNet):\(token)"
        let url = URL(string: httpString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        guard let loginBase64String = getBaseString(from: loginString) else { return }
        // auth must be base64
        request.setValue("Basic \(loginBase64String)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: personJsonData) { data, response, error in
            if let error = error {
                print("error calling POST \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("server error")
                return
            }
            if let mimeType = response.mimeType,
               mimeType == "application/json",
               let data = data,
               let dataString = String(data: data, encoding: .utf8) {
                print("got data \(dataString)")
            }
        }
        uploadTask.resume()
    }
    
    func getBaseString(from string: String) -> String? {
        let data = string.data(using: String.Encoding.utf8)
        let base = data!.base64EncodedString()
        return base
    }
}
