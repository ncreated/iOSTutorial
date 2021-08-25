//
//  AppDelegate.swift
//  RocketReserver
//
//  Created by Ellen Shapiro on 11/13/19.
//  Copyright © 2019 Apollo GraphQL. All rights reserved.
//

import UIKit
import Datadog

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setup Datadog
        Datadog.initialize(
            appContext: .init(),
            trackingConsent: .granted,
            configuration: Datadog.Configuration.builderUsing(
                rumApplicationID: "<rum-application-id>",
                clientToken: "<client-token>",
                environment: "<env>"
            )
            .trackUIKitRUMViews()
            .trackUIKitActions()
            .trackURLSession(firstPartyHosts: ["apollo-fullstack-tutorial.herokuapp.com"])
            .setRUMResourceAttributesProvider { request, response, responseData, error in
                var requestBody: String? = nil
                var responseBody: String? = nil

                if let data = request.httpBody {
                    requestBody = String(data: data, encoding: .utf8)
                }

                if let data = responseData {
                    responseBody = String(data: data, encoding: .utf8)
                }

                return [
                    "request-data": requestBody ?? "<none>",
                    "response-data": responseBody ?? "<none>",
                ]
            }
            .build()
        )

        Global.rum = RUMMonitor.initialize()

        Datadog.debugRUM = true
        Datadog.verbosityLevel = .debug

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


}

