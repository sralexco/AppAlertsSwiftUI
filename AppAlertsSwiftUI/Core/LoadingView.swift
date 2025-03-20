//
//  LoadingView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 12/03/25.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
            
            if isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                ActivityIndicator()
                    .frame(width: 160, height: 160)
                    .foregroundColor(Color.blue1)
                
            }
        }
    }
}

extension View {
    func loadingView(show: Binding<Bool>) -> some View {
        self.modifier(LoadingViewModifier(isLoading: show))
    }
}

struct ActivityIndicator: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<5, id: \.self) { index in
                Circle()
                    .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                    .scaleEffect(calcScale(index: index))
                    .offset(y: calcYOffset(geometry))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                    .animation(
                        Animation.timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                            .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            isAnimating = true
        }
    }
    
    func calcScale(index: Int) -> CGFloat {
        return isAnimating ? (0.2 + CGFloat(index) / 5) : (1 - CGFloat(index) / 5)
    }
    
    func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
}
