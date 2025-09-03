//
//  CreateRecommendationView.swift
//  GamePicks
//
//  Created by Rodrigo Llaguno on 02/09/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CreateRecommendationView: View {
  @Environment(\.dismiss) var dismiss
  @State private var name: String = ""
  @State private var selectedGenres: Set<String> = []
  @State private var selectedPlatforms: Set<String> = []
  @State private var review: String = ""
  @State private var score: Int = 0
  
  let genres = ["Adventure", "Indie", "Horror", "Action", "Cozy", "Racing", "Strategy", "Shooter", "Multiplayer", "Single Player", "Sports"]
  let platforms = ["Switch", "PC", "Xbox", "PlayStation"]
  
  var isSubmittable: Bool {
    if name.isEmpty || selectedGenres.isEmpty || selectedPlatforms.isEmpty || review.isEmpty {
      return false
    }
    else {
      return true
    }
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Game Info")) {
          TextField("Name", text: $name)
        }
        
        Section(header: Text("Genres")) {
          ForEach(genres, id: \.self) { genre in
            MultipleSelectionRow(title: genre, isSelected: selectedGenres.contains(genre)) {
              if selectedGenres.contains(genre) {
                selectedGenres.remove(genre)
              } else {
                selectedGenres.insert(genre)
              }
            }
          }
        }
        
        Section(header: Text("Platforms")) {
          ForEach(platforms, id: \.self) { platform in
            MultipleSelectionRow(title: platform, isSelected: selectedPlatforms.contains(platform)) {
              if selectedPlatforms.contains(platform) {
                selectedPlatforms.remove(platform)
              } else {
                selectedPlatforms.insert(platform)
              }
            }
          }
        }
        
        Section(header: Text("Review")) {
          TextEditor(text: $review)
            .frame(height: 100)
        }
        
        Section(header: Text("Score")) {
          Stepper(value: $score, in: 0...10) {
            Text("\(score) / 10")
          }
        }
      }
      .navigationTitle("New Recommendation")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            submit()
          } label: {
            Text("Submit")
          }
          .disabled(!isSubmittable)
        }
      }
    }
  }
  
  func submit() {
    let db = Firestore.firestore()
    guard let userId = Auth.auth().currentUser?.uid else {
      print("Bye")
      return
    }
    
    let newReview: [String: Any] = [
      "genres" : Array(selectedGenres),
      "name" : name,
      "platforms" : Array(selectedPlatforms),
      "review" : review,
      "score" : score,
      "userId" : userId
    ]
    
    db.collection("Recommendations").addDocument(data: newReview) { error in
      if let error = error {
        print("Error adding document: \(error)")
      } else {
        print("Document added successfully!")
        dismiss()
      }
    }
  }
}

struct MultipleSelectionRow: View {
  var title: String
  var isSelected: Bool
  var action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack {
        Text(title)
        Spacer()
        if isSelected {
          Image(systemName: "checkmark")
            .foregroundColor(.accentColor)
        }
      }
    }
    .foregroundColor(.primary)
  }
}
#Preview {
    CreateRecommendationView()
}
