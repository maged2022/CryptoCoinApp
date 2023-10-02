//
//  AnimationCircle.swift
//  CryptoCoinApp
//
//  Created by s on 02/10/2023.
//

import SwiftUI

struct AnimationCircle: View {
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scaleEffect(animate ? 1 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ?  .easeInOut(duration: 1) : .none)
        
    }
}
