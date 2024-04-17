//
//  Extention+UIApplication.swift
//  SwiftBoilerPlate
//
//  Created by user238851 on 13/04/24.
//

import UIKit

extension UIApplication {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
    }
}
