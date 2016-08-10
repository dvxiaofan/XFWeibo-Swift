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
        
        // 设置导航栏
        setupNavBar()
        
        // 加载授权页面
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
        // 授权页面 url
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_Key)&redirect_uri=\(redirect_uri)"
        
        // 创建对应 nsurl
        guard let url = NSURL(string: urlString) else {
            return
        }
        
        // 创建 request
        let request = NSURLRequest(URL: url)
        
        // 加载
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
        // 显示加载提示
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
        
        // 获取加载网页的 URL
        guard let url = request.URL else {
            // 继续加载网页
            return true
        }
        
        // 获取 URL 中的字符串
        let urlString = url.absoluteString
        
        // 判断字符冲是否含有 code 字段
        guard urlString.containsString("code") else {
            return true
        }
        
        // 将 code 截取出来
        let code = urlString.componentsSeparatedByString("code=").last!
        
        // 请求AccessToken
        loadAccessToken(code)
        
        return false
    }
}


// MARK:- 请求数据
extension XFOAuthViewController {
    
    private func loadAccessToken(code : String) {
        XFNetWorkTools.shareInstance.loadAccessToken(code) { (result, error) -> () in
            
            // 有错误
            if error != nil {
                XFLog(error)
                return
            }
            
            // 拿到结果
            guard let accountDict = result else {
                XFLog("没有获取到授权后的数据")
                return
            }
            
            // 将字典专程模型对象
            let user = XFUser(dict: accountDict)
            
            // 请求用户数据
            self.loadUserInfo(user)
        }
    }
    
    /// 请求用户数据
    private func loadUserInfo(user : XFUser) {
        // 获取 accesstoken
        guard let accessToken = user.access_token else {
            return
        }
        
        guard let uid = user.uid else {
            return
        }
        
        XFNetWorkTools.shareInstance.loadUserInfo(accessToken, uid: uid) { (result, error) -> () in
            if error != nil {
                
                XFLog(error)
                return
            }
            
            // 拿到用户数据
            guard let userInfoDict = result else {
                return
            }
            
            // 从字典中取出昵称和头像
            user.screen_name = userInfoDict["screen_name"] as? String
            user.avatar_large = userInfoDict["avatar_large"] as? String
            
            
        }
    }
    
}












