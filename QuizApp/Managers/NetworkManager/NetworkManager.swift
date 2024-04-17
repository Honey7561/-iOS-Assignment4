//
//  NetworkManager.swift
//  Squeezee
//
//  Created by user238851 on 13/04/24.
//

import Foundation

final class NetworkManager: NetworkService {
    func getData() async throws -> ResponseModel {
        return try await APIService.request(API.api)
    }
}
