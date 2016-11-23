//
//  ProgressWebViewController.swift
//  MengGou
//
//  Created by liujianlin on 2016/11/23.
//  Copyright © 2016年 xdream. All rights reserved.
//

import UIKit

class ProgressWebViewController: WebViewController {

    private var loadFinished = false
    fileprivate var timer: Timer?
    fileprivate var timeInterval: TimeInterval = 0.01667//一秒内没有输入则执行搜索
    private let progressView = UIProgressView(progressViewStyle: .bar)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(view)
            make.height.equalTo(2)
        }
    }
    
    override func backAction() {
        if webView.canGoBack {
           webView.goBack()
        } else {
            super.backAction()
        }
    }
    
    func loadingProgress() {
        if loadFinished {
            if progressView.progress >= 1 {
                progressView.isHidden = true
                timer?.invalidate()
            } else {
                progressView.progress += 0.1
            }
        } else {
            progressView.progress += 0.05
            if progressView.progress > 0.95 { progressView.progress = 0.95 }
        }
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        progressView.progress = 0
        progressView.isHidden = false
        loadFinished = false
        timer?.invalidate()
        timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(loadingProgress), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    override func webViewDidFinishLoad(_ webView: UIWebView) {
        super.webViewDidFinishLoad(webView)
        loadFinished = true
    }
}
