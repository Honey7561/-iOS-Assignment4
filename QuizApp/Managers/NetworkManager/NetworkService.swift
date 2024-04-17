//
//  NetworkService.swift
//  Squeezee
//
//  Created by user238851 on 13/04/24.
//

import Foundation

protocol NetworkService {
    func getData() async throws -> ResponseModel
}
