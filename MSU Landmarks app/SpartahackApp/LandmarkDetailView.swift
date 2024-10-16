//
//  LandmarkDetailView.swift
//  MSULandmarks
//
//  Created by Carson Greene on 1/23/24.
//

import SwiftUI
import SwiftData

struct LandmarkDetailView: View {
   let landmark: Landmark
   
   @State private var visitLoggerShowing = false
   @State private var historyShowing = false
   
   var body: some View {
      ScrollView {
         VStack(alignment: .center) {
            Image(landmark.id)
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(maxWidth: 600, maxHeight: 300)
            Text(landmark.description)
               .multilineTextAlignment(.leading)
               .frame(maxWidth: .infinity)
         }
         .padding()
      }
      .navigationTitle(landmark.name)
      .toolbar {
         ToolbarItem(placement: .primaryAction) {
            Button(action: logVisit,
                   label: {
               Label("Log visit", systemImage: "calendar.badge.plus")
            })
         }
         ToolbarItem(placement: .secondaryAction) {
            Button(action: viewHistory, 
                   label: {
               Label("Visit History", systemImage: "clock.arrow.circlepath")
            })
         }
      }
      .sheet(isPresented: $visitLoggerShowing, content: {
         VisitLoggerView(showing: $visitLoggerShowing,
                         landmarkId: landmark.id)
      })
      .sheet(isPresented: $historyShowing, content: {
         HistoryView(landmarkId: landmark.id)
      })
   }
   
   func logVisit() {
      visitLoggerShowing = true
   }
   
   func viewHistory() {
      historyShowing = true
   }
}

#Preview {
   LandmarkDetailView(landmark: Landmark.landmarks.randomElement()!)
}
