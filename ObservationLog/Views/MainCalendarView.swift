//
//  ContentView.swift
//  ObservationLog
//
//  Created by MAX on 2023/08/21.
//

import SwiftUI

struct MainCalendarView: View {
    @State var nowDate: Date
    @State var selectNumber: Int = 0
    @State var logName: String = "비어있는 기록 1"
    
    init(nowDate: Date) {
            self._nowDate = State(initialValue: nowDate)
            _selectNumber = State(initialValue: dateToInt(for: nowDate))
        }
    
    var body: some View {
        NavigationView(){
            VStack {
                Text("\(getDate(for: selectNumber))")
                Text("\(logName)")
                    .underline()
                
                Text(nowDate, formatter: Self.dateFormatter)
                    .font(.title)
                
                HStack(spacing: 0) {
                    ForEach(0..<7) { dayWeek in
                        Text("\(Self.weekdaySymbols[dayWeek])")
                            .frame(width: 50)
                    }
                }
                
                VStack(spacing: 0) {
                    ForEach(0..<6) { row in
                        HStack(spacing: 0) {
                            ForEach(1..<8) { col in
                                DateCellView(nowDate: nowDate, cellNumber: (row * 7) + col, selectNumber: $selectNumber)
                            }
                        }
                    }
                }
                
                Text("기록하기")
                    .frame(width: 320)
                    .padding()
                    .border(.black)
                
                NavigationLink {
                    ReportView()
                } label: {
                    Text("통계보기")
                        .frame(width: 320)
                        .padding()
                        .border(.black)
                        .foregroundColor(.black)
                }
                
                NavigationLink {
                    MemoListView()
                } label: {
                    Text("메모보기")
                        .frame(width: 320)
                        .padding()
                        .border(.black)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct DateCellView: View {
    @State var nowDate: Date
    @State var cellNumber: Int
    @Binding var selectNumber: Int
    
    var body: some View {
        ZStack{
            if selectNumber == dateNumber(cellNumber: cellNumber) {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
            }
            
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
                .frame(width: 50, height: 50)
                .overlay(
                    Text("\(isDateNumber(cellNumber: cellNumber) ? String(dateNumber(cellNumber: cellNumber))+"일" : "")")
                )
        }
        .onTapGesture {
            if isDateNumber(cellNumber: cellNumber) {
                selectNumber = dateNumber(cellNumber: cellNumber)
            }
        }
    }
    
    private func isDateNumber(cellNumber: Int) -> Bool {
        var result: Bool = false
        
        if (cellNumber >= firstWeekdayOfMonth(in: nowDate)
            && cellNumber < numberOfDays(in: nowDate) + firstWeekdayOfMonth(in: nowDate)) {
            result = true
        }
        
        return result
    }
    
    private func dateNumber(cellNumber: Int) -> Int {
        var result: Int
        result = cellNumber - firstWeekdayOfMonth(in: nowDate) + 1
        
        return result
    }
}

private extension DateCellView {
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!

        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
}

private extension MainCalendarView {
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day-1, to: startOfMonth())!
    }
    
    func dateToInt(for day: Date) -> Int{
        return Calendar.current.component(.day, from: day)
    }
    
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: nowDate)
        return Calendar.current.date(from: components)!
    }
}

private extension MainCalendarView {
    static let weekdaySymbols: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.shortWeekdaySymbols
    }()
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }()
}


struct MainCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MainCalendarView(nowDate: Date())
    }
}
