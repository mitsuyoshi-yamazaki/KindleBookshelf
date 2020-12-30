//
//  AppDelegate.swift
//  KindleBookshelf
//
//  Created by Yamazaki Mitsuyoshi on 2020/12/30.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        loadBooks() // FixMe: デバッグコード

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func loadBooks() {
        guard let url = URL(string: "https://www.amazon.co.jp/mn/dcw/myx.html/ref=kinw_myk_redirect#/home/content/booksAll/dateDsc/") else {
            return
        }
        let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.1 Safari/605.1.15"
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "User-Agent": userAgent
        ]
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error as Any)
                return
            }
            guard let data = data, let dataString = String(data: data, encoding: .utf8), let response = response as? HTTPURLResponse else {
                print("Unexpected error")
                return
            }
            print(response)
            print(dataString)
        }
        task.resume()
    }
}
