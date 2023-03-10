//
//  ArrivalTimeView.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 12/02/2023.
//

import SwiftUI
import ComposableArchitecture

struct ArrivalTimeView: View {
    
    let store: StoreOf<Feature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("Arrival Times")
                    .font(.system(size: 36, weight: .black))
                    .padding(.top, 100)
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<viewStore.arrivalTimes.count, id: \.self) { i in
                            let arrivalTime = viewStore.arrivalTimes[i]
                            ArriveTimeRow(arrivalTime: arrivalTime)
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
    }
}
