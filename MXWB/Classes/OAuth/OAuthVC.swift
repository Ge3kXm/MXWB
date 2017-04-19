//
//  OAuthVC
//  MXWB
//
//  Created by maRk on 2017/4/18.
//  Copyright © 2017年 maRk. All rights reserved.
//

import UIKit

class OAuthVC: UIViewController
{
    // MARK: -
    lazy var webView :UIWebView = {
        let webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        return webView
    }()
    
    let oAuthRequest = URLRequest(url: URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(MXWB_APP_Key)&redirect_uri=\(MXWB_APP_Redirect_Uri)")!)
    
    
    // MARK: -
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initUI()
        startLoading()
    }
    
    private func initUI()
    {
        view.addSubview(webView)
    }
    
    private func startLoading()
    {
        webView.loadRequest(oAuthRequest)
    }
}

extension OAuthVC: UIWebViewDelegate
{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let requestURlString = request.url?.absoluteString else {
            MXLog("url is not valid")
            return false
        }
        if !requestURlString.contains("https://www.google.com") {
            MXLog("is not autoPage")
            return true
        }
        MXLog("is autoPage")
        let key = "code="
        if requestURlString.contains(key) {
            let requestToken = request.url?.query!.substring(from: key.endIndex)
            getAccessToken(requestToken: requestToken)
            MXLog(requestToken)
            return false
        }
        return true
    }
    
    
    private func getAccessToken(requestToken: String?)
    {
        let path = "oauth2/access_token"
        let parameters = ["client_id": MXWB_APP_Key, "client_secret": MXWB_APP_Secret, "grant_type": "authorization_code", "code": requestToken, "redirect_uri": MXWB_APP_Redirect_Uri]

        HttpManager.sharedManager.post(path, parameters: parameters, progress: nil, success: { (sessionTask: URLSessionDataTask, obj: Any) in
            MXLog(obj)
            let account = OAuthAccount(dict: (obj as! [String: Any]))
            MXLog(account.saveAccount())
            self.dismiss(animated: true, completion: nil)
        }) { (sessionTask: URLSessionDataTask?, error: Error) in
            MXLog(error)
        }
    }
}
