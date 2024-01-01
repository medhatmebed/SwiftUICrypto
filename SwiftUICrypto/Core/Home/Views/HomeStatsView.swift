//
//  HomeStatsView.swift
//  SwiftUICrypto
//
//  Created by Medhat Mebed on 1/1/24.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortoflio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.statistics) { statistics in
                StatisticView(stat: statistics)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortoflio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortoflio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
