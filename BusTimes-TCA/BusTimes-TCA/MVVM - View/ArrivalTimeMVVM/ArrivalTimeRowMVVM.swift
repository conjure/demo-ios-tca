//
//  ArriveTimeRowMVVM.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 12/02/2023.
//

import SwiftUI

struct ArriveTimeRowMVVM: View {
    var arrivalTime: ArrivalTime
    private let screenWidth = UIScreen.main.bounds.width
    
    init(arrivalTime: ArrivalTime) {
        self.arrivalTime = arrivalTime
    }
    
    var body: some View {
        
        ZStack {
            Text(arrivalTime.stationName)
            HStack {
                VStack(alignment: .leading) {
                    Text("Bus")
                        .bold()
                    Spacer()
                    Text(arrivalTime.lineName)
                        .foregroundColor(.white)
                }.padding(.trailing, 100)
                
                VStack(alignment: .leading) {
                    Text("Arrival Time")
                        .bold()
                    Spacer()
                    Text(arrivalTime.timeInMinutes)
                        .foregroundColor(.white)
                }
            }.padding(.bottom, 10)
                .padding(.top, 10)
                .frame(width: screenWidth - 10)
                .background(Color.accentColor)
        }.padding(.top, 4)
            .background(Color.white)
    }
}

