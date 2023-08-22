//
//  ContentView.swift
//  ObservationLog
//
//  Created by MAX on 2023/08/21.
//

import SwiftUI

struct MainCalendarView: View {
    @State var logName: String = ""
    
    var body: some View {
        VStack {
            TextField("비어있는 기록 1", text: $logName)
            Text("2023년 8월")
                .font(.title)
            Text("달력")
            Text("기록하기")
        }
        .padding()
    }
}

struct MainCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MainCalendarView()
    }
}
