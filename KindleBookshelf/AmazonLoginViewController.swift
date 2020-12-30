//
//  AmazonLoginViewController.swift
//  KindleBookshelf
//
//  Created by Yamazaki Mitsuyoshi on 2020/12/30.
//

import UIKit
import WebKit

final class AmazonLoginViewController: UIViewController {
    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
            webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.1 Safari/605.1.15"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadLoginView()
    }

    private func loadLoginView() {
        let cloudReader = "https://read.amazon.co.jp"
        let contentManagement = "https://www.amazon.co.jp/mn/dcw/myx.html/ref=kinw_myk_redirect#/home/content/booksAll/dateDsc/"
        guard let url = URL(string: contentManagement) else {
            return
        }
        webView.load(URLRequest(url: url))
    }

    private func getDom() {
        let js = "document.documentElement.outerHTML.toString()"
        webView.evaluateJavaScript(js) { data, error in
            guard error == nil else {
                print(error as Any)
                return
            }
            guard let document = data as? String else {
                return
            }
            print(document)
        }
    }
}

extension AmazonLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("\(#function), \(String(describing: navigation))")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.getDom()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(#function), \(String(describing: navigation)), error: \(error)")
    }
}
