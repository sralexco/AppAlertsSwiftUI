//
//  LoadingView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 12/03/25.
//

import SwiftUI

class LoadingManager: ObservableObject {
    @Published var isLoading: Bool = false
}

struct LoadingViewModifier: ViewModifier {
    @EnvironmentObject var loadingManager: LoadingManager
    @State private var isActuallyLoading: Bool = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isActuallyLoading)
            
            if isActuallyLoading {
               Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(4)
                VStack {
                    Spacer()
                    ActivityIndicator()
                        .frame(width: 160, height: 160)
                        .foregroundColor(Color.blue1)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background( Color.black.opacity(0.4) )
             
            }
        }
        .zIndex(3)
        .background(.green)
        .onChange(of: loadingManager.isLoading) { _, newValue in
            if newValue {
                isActuallyLoading = true
            } else {
                Task {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    withAnimation {
                        isActuallyLoading = false
                    }
                }
            }
        }
    }
}

extension View {
    func loadingView() -> some View {
        self.modifier(LoadingViewModifier())
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
