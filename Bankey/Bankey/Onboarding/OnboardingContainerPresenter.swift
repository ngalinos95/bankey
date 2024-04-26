//
//  OnboardingContainerPresenter.swift
//  Bankey
//
//  Created by Nikos Galinos on 26/4/24.
//

import Foundation

protocol OnboardingContainerPresenterProtocol {
    func attach(_ view: OnboardingContainerProtocol)
}

class OnboardingContainerPresenter: OnboardingContainerPresenterProtocol {
    
    weak var view: OnboardingContainerProtocol?

    func attach(_ view: OnboardingContainerProtocol) {
        assert(self.view == nil, "Cannot attach view twice")
        self.view = view
    }

    func closeButtonAction() {
    }

    func pushToView() {
// w8 for impplementation
    }

}
