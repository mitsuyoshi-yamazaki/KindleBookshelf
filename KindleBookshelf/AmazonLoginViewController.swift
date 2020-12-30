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

    private func getBooks() {
        (0..<10).forEach(getBook(for:))
    }

    private func getBook(for index: Int) {
        let id = "title\(index)"
        let js = "document.getElementById('\(id)').innerHTML.toString()" // オブジェクトを返却する関数を呼び出す際はStringなどに変換しないとSwift側で受け入れられないようだ
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.getBooks()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(#function), \(String(describing: navigation)), error: \(error)")
    }
}
