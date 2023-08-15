//
//  ContentView.swift
//  swiftUIAnimation
//
//  Created by Adhithya Ramakumar on 8/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedProfile: Profile?
    @State private var pushView: Bool = false
    @State private var hideView: (Bool, Bool) = (false, false)
    var body: some View {
        NavigationStack {
            HomePage(selectedProfile: $selectedProfile, pushView: $pushView)
                .navigationTitle("Profile")
                .navigationDestination(isPresented: $pushView) {
                    DetailView(selectedProfile: $selectedProfile, 
                               pushView: $pushView, hideView: $hideView)
                   }
        }
        .overlayPreferenceValue(ImageAnchorKey.self,{ value in
            GeometryReader(content: { geometry in
                if let selectedProfile, let anchor = value[selectedProfile.id], !hideView.0{
                    let rect = geometry[anchor]
                    ImageView(profile: selectedProfile, size: rect.size)
                        .offset(x: rect.minX, y: rect.minY)
                   
                   /// animating
                        .animation(.snappy(duration: 0.35, extraBounce: 0), value: rect)
                }
            })
        })
    }
}


#Preview {
    ContentView()
}
