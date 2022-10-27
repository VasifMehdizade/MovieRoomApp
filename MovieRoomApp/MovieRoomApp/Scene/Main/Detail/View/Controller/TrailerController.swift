//
//  TrailerController.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 27.10.22.
//

import UIKit
import WebKit

class TrailerController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var video = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: "https://www.youtube.com/watch?v=\(video)")!)
        webView.load(request)
    }
    
}
