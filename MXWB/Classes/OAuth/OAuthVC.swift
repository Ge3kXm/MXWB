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
    // MARK: - Lazyload
    lazy var webView :UIWebView = {
        let webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self
        return webView
    }()
    
    let oAuthRequest = URLRequest(url: URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(MXWB_APP_KEY)&redirect_uri=\(MXWB_APP_REDIRECT_URL)")!)
    
    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initUI()
        initNav()
        startLoading()
    }
    
    // MARK: - PrivateFunc
    private func initUI()
    {
        view.addSubview(webView)
    }
    
    private func initNav()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OAuthVC.closeBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填", style: UIBarButtonItemStyle.plain, target: self, action: #selector(OAuthVC.fullBtnClick))
    }
    
    private func startLoading()
    {
        webView.loadRequest(oAuthRequest)
    }
    
    @objc func closeBtnClick()
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func fullBtnClick()
    {
        let jsString = "document.getElementById('userId').value = '7624619@qq.com'"
        webView.stringByEvaluatingJavaScript(from: jsString)
        
        let jsString2 = "document.getElementById('passwd').value = '4839286mm'"
        webView.stringByEvaluatingJavaScript(from: jsString2)
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
        let parameters = ["client_id": MXWB_APP_KEY, "client_secret": MXWB_APP_SECREAT, "grant_type": "authorization_code", "code": requestToken, "redirect_uri": MXWB_APP_REDIRECT_URL]

        HttpManager.sharedManager.post(path, parameters: parameters, progress: nil, success: { (sessionTask: URLSessionDataTask, obj: Any) in
            MXLog(obj)
            let account = OAuthAccount(dict: (obj as! [String: Any]))
            account.getUserInfo(finished: { (fullInfoAcctount, error) in
                MXLog(fullInfoAcctount?.saveAccount())
                NotificationCenter.default.post(name: Notification.Name(MXWB_NOTIFICATION_SWITCHROOTVC_KEY), object: false)
            })
            self.dismiss(animated: true, completion: nil)
        }) { (sessionTask: URLSessionDataTask?, error: Error) in
            MXLog(error)
        }
    }
}
