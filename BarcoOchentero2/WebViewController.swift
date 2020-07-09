//
//  WebViewController.swift
//  BarcoOchentero2
//
//  Created by yisus on 10/06/2020.
//  Copyright © 2020 yisus. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    private let searchBar = UISearchBar()
    private var webView: WKWebView!
    private let refreshControl = UIRefreshControl()
    private let barcoUrl = "https://elbarcoochentero.es/el-viaje/el-barco-ochentero/"
    private let baseUrl = "https://www.google.es"
    private let searchUrl = "/search?q="
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Navigation buttons
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        
        // Seach bar
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        //web View
        let webViewPrefs = WKPreferences()
        webViewPrefs.javaScriptEnabled = true
        webViewPrefs.javaScriptCanOpenWindowsAutomatically = true
        let webViewConf = WKWebViewConfiguration()
        webViewConf.preferences = webViewPrefs
        webView = WKWebView(frame: view.frame, configuration: webViewConf)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.keyboardDismissMode = .onDrag
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        //refresh control
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        webView.scrollView.addSubview(refreshControl)
        view.bringSubviewToFront(refreshControl)
        
        
        load(url: barcoUrl)
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        webView.goForward()
    }
    
    private func load(url: String){
        var urlToLoad: URL!
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url)
        {
         urlToLoad = url
        }else{
            urlToLoad = URL(string: "\(baseUrl)\(searchUrl)\(url)")!
        }
        webView.load(URLRequest(url: urlToLoad))
    }
    
    @objc private func reload(){
        webView.reload()
    }
    
}

extension WebViewController: UISearchBarDelegate{
    func  searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        load(url: searchBar.text ?? "")
    }
}

extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        refreshControl.endRefreshing()
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        view.bringSubviewToFront(refreshControl)

    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        refreshControl.beginRefreshing()
        searchBar.text = webView.url?.absoluteString
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        refreshControl.beginRefreshing()
        view.bringSubviewToFront(refreshControl)
    }
}
