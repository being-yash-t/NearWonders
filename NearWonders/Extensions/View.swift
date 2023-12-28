//
//  View.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func tabSheet<SheetContent: View>(
        showSheet: Binding<Bool>,
        otherDetents: Set<PresentationDetent> = [],
        initialHeight: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> SheetContent
    ) -> some View {
        self.modifier(BottomSheetModifier(
            initialHeight: initialHeight,
            sheetView: content(),
            otherDetents: otherDetents,
            showSheet: showSheet
        ))
    }
}

fileprivate struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    var initialHeight: CGFloat?
    var sheetView: SheetContent
    var otherDetents: Set<PresentationDetent>
    
    @Binding var showSheet: Bool
    
    func body(content: Content) -> some View {
        let initialDetent: Set<PresentationDetent> = [initialHeight != nil ? PresentationDetent.height(initialHeight!) : .medium]
        return content.sheet(isPresented: $showSheet) {
            sheetView
                .presentationDetents(initialDetent.union(otherDetents))
                .presentationBackgroundInteraction(.enabled(upThrough: initialDetent.first!))
//                .interactiveDismissDisabled()
        }
    }
}
