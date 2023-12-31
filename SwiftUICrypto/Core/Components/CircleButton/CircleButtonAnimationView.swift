//
//  CircleButtonAnimationView.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 12/31/23.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate : Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? .easeOut(duration: 1.0) : .none, value: animate)
            .onAppear {
                animate.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
}
