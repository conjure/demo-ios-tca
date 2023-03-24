//
//  BusStopRow.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 08/02/2023.
//

import SwiftUI

struct BusStopRow: View {
    var busStop: BusStop
    private let screenWidth = UIScreen.main.bounds.width
    
    init(busStop: BusStop) {
        self.busStop = busStop
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(busStop.commonName)
                    .bold()
                    .foregroundColor(.white)
                Text(getListOfBus(with: busStop.lines))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 10)
            .padding(.top, 10)
            .frame(width: screenWidth - 10)
            .background(Color.gray)
            
        }
        .padding(.top, 4)
        .background(Color.white)
    }
    
    private func getListOfBus(with list: [Lines]) -> String {
        var busLines = ""
        for line in list {
            busLines += line.name + ", "
        }
        return busLines
    }
}
