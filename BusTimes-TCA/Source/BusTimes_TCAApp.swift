//
//  BusTimes_TCAApp.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 21/02/2023.
//

import SwiftUI
import ComposableArchitecture
import ComposableCoreLocation


@main
struct MyApp: App {
    
  var body: some Scene {
    WindowGroup {
        BusStopView(
        store: Store(
          initialState: BusStopFeature.State(),
          reducer: BusStopFeature()
        )
      )
    }
  }
}

