//
//  BaseNavigationController.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    init() {
        super.init(nibName: nil, bundle: nil)
        setupNavigationBar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let image = UIImage(systemName: "chevron.left")
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
        navigationBar.tintColor = .white
    }
}
