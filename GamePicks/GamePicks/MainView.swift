//
//  MainView.swift
//  GamePicks
//
//  Created by Rodrigo Llaguno on 02/09/25.
//

import SwiftUI

struct MainView: View {
  @State private var authManager: AuthManager = AuthManager()
  @State private var showGetView: Bool = false
  @State private var showCreateView: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 80) {
        Button {
          showGetView = true
        } label: {
          GetRecommendationComponent()
        }
                
        Button {
          showCreateView = true
        } label: {
          CreateRecommendationComponent()
        }
      }
      .navigationTitle("Game Picks")
      .navigationDestination(isPresented: $showGetView) {
        GetRecommendationView()
      }
      .navigationDestination(isPresented: $showCreateView) {
        CreateRecommendationView()
      }
    }
  }
}

#Preview {
  MainView()
}
