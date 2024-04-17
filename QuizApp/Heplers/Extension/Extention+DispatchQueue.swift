//
//  Extention+DispatchQueue.swift
//  SwiftBoilerPlate
//
//  Created by user238851 on 13/04/24.
//

import Foundation

public extension DispatchQueue {
    func after(time interval: TimeInterval, work: @escaping () -> Void) {
        asyncAfter(deadline: .now() + interval) {
            work()
        }
    }
}
