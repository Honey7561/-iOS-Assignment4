//
//  MainVm.swift
//  SwiftBoilerPlate
//
//  Created by user238851 on 13/04/24.
//

import Foundation

final class MainVm: ViewModel {
    // MARK: - Properties
    private var bag = Bag()
    private var output = AppSubject<Output>()
    
    // MARK: - Enums
    enum Input {
        case didTapSignUp
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }
    
    // MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .didTapSignUp:
                strongSelf.router.setRoot(to: .tab, duration: 0.3, options: .transitionCrossDissolve)
            }
        }.store(in: &bag)
        return output.eraseToAnyPublisher()
    }
}
