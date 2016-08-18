//
//  XFOAuthViewController.swift
//  XFWeiboSwift
//
//  Created by xiaofans on 16/8/10.
//  Copyright © 2016年 xiaofan. All rights reserved.
//

import UIKit
import SVProgressHUD

class XFOAuthViewController: UIViewController {
    // MARK:- 控件属性
    @IBOutlet weak var webView: UIWebView!
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        loadOAtuhPage()
    }
}

// MARK:- 设置界面
extension XFOAuthViewController {
    
    /// 设置导航栏返回按钮
    private func setupNavBar() {
        title = "登录授权"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "backBtnClick");
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .Plain, target: self, action: "fillInfoClick")
    }
    
    private func loadOAtuhPage() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_Key)&redirect_uri=\(redirect_uri)"
        
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        let request = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
    }
}

// MARK:- 事件监听
extension XFOAuthViewController {
    
    /// 返回按钮
    @objc private func backBtnClick() {
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func fillInfoClick() {
        let jsCode = "document.getElementById('userId').value='15307130789';document.getElementById('passwd').value='Lmz900904';"
        
        webView.stringByEvaluatingJavaScriptFromString(jsCode)
    }
}

// MARK:- webView 代理
extension XFOAuthViewController : UIWebViewDelegate{

    // 开始加载
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.Dark)
    }
    
    // 结束加载
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    // 加载网页失败
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        SVProgressHUD.dismiss()
    }
    
    // 将要加载时调用
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.URL else {
            return true
        }
        
        let urlString = url.absoluteString
        
        guard urlString.containsString("code") else {
            return true
        }
        
        let code = urlString.componentsSeparatedByString("code=").last!
        
        loadAccessToken(code)
        
        return false
    }
}

// MARK:- 请求数据
extension XFOAuthViewController {
    
    private func loadAccessToken(code : String) {
        XFNetWorkTools.shareInstance.loadAccessToken(code) { (result, error) -> () in
            
            if error != nil {
                XFLog(error)
                return
            }
            
            guard let accountDict = result else {
                XFLog("没有获取到授权后的数据")
                return
            }
            
            // 将字典专程模型对象
            let account = XFUserAccount(dict: accountDict)
            
            self.loadUserInfo(account)
        }
    }
    
    /// 请求用户数据
    private func loadUserInfo(account : XFUserAccount) {
        guard let accessToken = account.access_token else {
            return
        }
        
        guard let uid = account.uid else {
            return
        }
        
        XFNetWorkTools.shareInstance.loadUserInfo(accessToken, uid: uid) { (result, error) -> () in
            if error != nil {
                
                XFLog(error)
                return
            }
            
            guard let userInfoDict = result else {
                return
            }
            
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            NSKeyedArchiver.archiveRootObject(account, toFile: XFUserAccountTool.shareInstance.accountPath)
            
            XFUserAccountTool.shareInstance.account = account
            
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                UIApplication.sharedApplication().keyWindow?.rootViewController = XFWelcomeViewController()
            })
        }
    }
    
}












