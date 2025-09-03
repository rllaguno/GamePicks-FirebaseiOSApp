//
//  CreateRecommendationComponent.swift
//  GamePicks
//
//  Created by Rodrigo Llaguno on 02/09/25.
//

import SwiftUI

struct CreateRecommendationComponent: View {
  @State private var dragAmount = CGSize.zero
  
  var body: some View {
    ZStack {
      LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        .frame(maxWidth: 300, maxHeight: 200)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .gray, radius: 1)
      
      VStack(spacing: 10) {
        VStack {
          Text("Create")
            .foregroundStyle(.white)
            .font(.system(size: 24, weight: .bold))
          
          Text("Recommendation")
            .foregroundStyle(.white)
            .font(.system(size: 24, weight: .bold))
        }
        
        Image(systemName: "plus.circle")
          .foregroundStyle(.white)
          .font(.system(size: 48, weight: .bold))
      }
      .padding()
    }
    .offset(dragAmount)
    .gesture(
      DragGesture()
        .onChanged { dragAmount = $0.translation }
        .onEnded { _ in dragAmount = .zero }
    )
    .animation(.bouncy, value: dragAmount)
  }
}

#Preview {
    CreateRecommendationComponent()
}
