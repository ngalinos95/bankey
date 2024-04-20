//
//  LoginView.swift
//  Bankey
//
//  Created by Nikos Galinos on 20/4/24.
//

import Foundation
import UIKit

class LoginView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    // This is required for storyboards and we dont need it
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .orange
    }

    func layout() {
    }
}
