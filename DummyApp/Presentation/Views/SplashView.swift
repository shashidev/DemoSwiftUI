//
//  SplashView.swift
//  DummyApp
//

import SwiftUI

struct SplashView: View {
    @State private var showMainView = false

    var body: some View {
        // Show either the SplashScreen or MainView based on showMainView state
        if showMainView {
            HomeView() // Navigate to HomePage after the splash screen
        } else {
            VStack {
                Text("Welcome to Dummy App!")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(.blue)
                    .padding()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

#Preview {
    SplashView()
}
