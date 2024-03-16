//
//  CircleButtonAnimationView.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 26.12.2023.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scaleEffect(animate ? 1.0 : 0.0, anchor: .center)
            .opacity(animate ? 0.0 : 1.0)
            .animation(withAnimation {
                animate ? Animation.easeOut(duration: 1.0) : .none
            }, value: animate)
           
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundStyle(Color.red)
        .frame(width: 100, height: 100)
}
