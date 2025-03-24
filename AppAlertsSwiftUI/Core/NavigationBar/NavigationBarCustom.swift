//
//  NavigationBarCustom.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//
import SwiftUI

struct NavHeader: View {
    var scrollOffset: CGFloat
    var title:String
    var icon:String
    var iconAction: () -> Void // Closure for the icon action
   //     .background(Color.blue1.opacity(0.20))
    
    var body: some View {
        ZStack {
            Color.clear
                .frame(height: interpolatedHeight())
                .background(.ultraThinMaterial.opacity(opastyview()))
                .blur(radius: 0.5)
                .edgesIgnoringSafeArea(.top)
            HStack {
                Text(title).bold()
                    .font(.system(size: interpolatedOText()))
                Spacer()
                Button(action: iconAction) {
                                   Image(systemName: icon)
                                       .font(.system(size: iconsize()))
                               }
                               .buttonStyle(.plain)
                //Image(systemName:icon).font(.system(size: iconsize()))
            }
            .offset(y:PushupOffset())
            .padding()
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .animation(.easeIn, value: scrollOffset)
    }
    // Defines a function to calculate the height of an element based on the scroll offset.
    private func interpolatedHeight() -> CGFloat {
        // The starting height of the element before scrolling starts.
        let startHeight:CGFloat = 100
        // The ending height of the element after scrolling.
        let endHeight:CGFloat = 85
        // The amount of scroll required to transition from startHeight to endHeight.
        let transitionOffset :CGFloat = 35
        
        // Calculates the progress of the transition as a fraction between 0 and 1.
        // It uses the current scroll offset divided by the transitionOffset.
        // If the result is less than 0, it uses 0. If it's more than 1, it uses 1.
    let progress = min(max(scrollOffset / transitionOffset ,0 ) , 1)
        
        // Calculates the current height based on the progress.
        // If progress is 0, the height is startHeight. If progress is 1, the height is endHeight.
        // It interpolates between these two heights based on the progress.
        return  endHeight + (startHeight - endHeight) * progress
    }
    private func iconsize() -> CGFloat {
        let theend: CGFloat = 35
        let thestart: CGFloat = 30
        let transitionOffset: CGFloat = 35
        let progress = min(max(scrollOffset / transitionOffset, 0), 1)
        return thestart + (theend - thestart) * progress
    }
    
    
    private func PushupOffset() -> CGFloat {
           let theend: CGFloat = -40
           let thestart: CGFloat = -30
           let transitionOffset: CGFloat = 50
           let progress = min(max(scrollOffset / transitionOffset, 0), 1)
           return theend + (thestart - theend) * progress
       }
    private func interpolatedOText() -> CGFloat {
           let theendOffset: CGFloat = 30
           let thestartOffset: CGFloat = 40
           let transitionOffset: CGFloat = 50
           let progress = min(max(scrollOffset / transitionOffset, 0), 1)
           return theendOffset + (thestartOffset - theendOffset) * progress
       }
    private func opastyview() -> CGFloat {
           let startOffset: CGFloat = 0
           let endOffset: CGFloat = 1
           let transitionOffset: CGFloat = 50
           let progress = min(max(scrollOffset / transitionOffset, 0), 1)
           return endOffset + (startOffset - endOffset) * progress
       }
}

 
struct CustomNavView<Content: View > : View {
    var title: String
    var icon:String
    let content: Content
    var iconAction: () -> Void
    @State private var scrollOffset: CGFloat = 0
    
    init(title: String,icon:String,@ViewBuilder content: () -> Content, iconAction: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.content = content()
        self.iconAction = iconAction
    }
    var body: some View {
        
        GeometryReader{ geo in
            ScrollView {
                ScrollOffsetBackground { offset in
                    self.scrollOffset = offset - geo.safeAreaInsets.top
                }
                .frame(height: 0)
                content
            }
            .safeAreaPadding(.top,110)
            .ignoresSafeArea()
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 40)
            })
            .overlay {
                NavHeader(scrollOffset: scrollOffset, title: title, icon: icon, iconAction: iconAction)
            }
            
        }
    }
}
struct ScrollOffsetBackground: View {
    var onOffsetChange: (CGFloat) -> Void
    var body: some View {
        GeometryReader{ geometry in
            Color.clear
                .preference(key: ViewOffsetKey.self , value: geometry.frame(in: .global).minY)
                .onPreferenceChange(ViewOffsetKey.self, perform: onOffsetChange)
            
        }
    }
}

 
struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
