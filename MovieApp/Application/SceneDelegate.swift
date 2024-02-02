//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import UIKit
import Swinject

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private var windowController: WindowControllerProtocol?
    private let appAssembler = Assembler.appAssembler()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard !isRunningUnitTests else { return }

        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)

        windowController = appAssembler.resolver.resolve(WindowControllerProtocol.self)!
        windowController?.setupWindow(window)
    }
}

