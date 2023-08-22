//
//  ReportView.swift
//  ObservationLog
//
//  Created by MAX on 2023/08/21.
//

import SwiftUI

struct ReportView: View {
    var body: some View {
        VStack {
            Text("비어있는 기록 1")
                .font(.title)
            Text("2023년 7월 18일")
            Text("에 시작해서")
            
            HStack {
                Text("평균")
                Text("31일")
                Text("간격으로")
            }

            HStack {
                Text("총")
                Text("2번")
                Text("기록되어")
            }
            
            Text("2023년 8월 18일")
            Text("에 종료했다.")
            
            HStack {
                Text("총 소요일")
                Text("32일")
            }
            
            HStack {
                VStack {
                    Text("최장 연속")
                    Text("기록 일수")
                }
                Text("1일")
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
