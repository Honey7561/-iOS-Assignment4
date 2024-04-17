//
//  ViewModel.swift
//  SwiftBoilerPlate
//
//  Created by user238851 on 13/04/24.
//

import Foundation

@MainActor
class ViewModel {
    // MARK: - Dependencies
    @Injected var router: Router
    @Injected var networkServices: NetworkService
}
