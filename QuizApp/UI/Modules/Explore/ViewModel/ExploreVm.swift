//
//  ExploreVm.swift
//  NewsApp
//
//  Created by user238851 on 13/04/24.
//

import Foundation


final class ExploreVm: ViewModel {
    //MARK: - Properties
    private var disposeBag = Bag()
    private var taskBag = TaskBag()
    private var output = AppSubject<Output>()
    
    //MARK: - Enums
    enum Input {
        case viewWillAppear
    }
    
    enum Output {
        case loader(isLoading: Bool)
        case showError(msg: String)
    }
    
    //MARK: - Functions
    func transform(input: AppAnyPublisher<Input>) -> AppAnyPublisher<Output> {
        input.weekSink(self) { strongSelf, event in
            switch event {
            case .viewWillAppear: break
            }
        }.store(in: &disposeBag)
        return output.eraseToAnyPublisher()
    }
}

