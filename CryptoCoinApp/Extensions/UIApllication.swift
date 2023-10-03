//
//  UIApllication.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//

import Foundation
import UIKit

extension UIApplication {
    func dismessKeyboard () {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
