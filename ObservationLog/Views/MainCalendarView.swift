//
//  ContentView.swift
//  ObservationLog
//
//  Created by MAX on 2023/08/21.
//

import SwiftUI

struct MainCalendarView: View {
    @State private var nowDate: Date
    @State private var selectNumber: Int = 0
    @State private var logName: String = "비어있는 기록 1"
    
    // 오늘 날짜를 정수(Int)로 바꿔서 selectNumber에 할당. 오늘 날짜로 자동 강조 표기.
    init(nowDate: Date) {
            self._nowDate = State(initialValue: nowDate)
            _selectNumber = State(initialValue: dateToInt(for: nowDate))
        }
    
    var body: some View {
        NavigationView(){
            VStack {
                // 현재 선택된 날짜 보여주기.
                Text("\(getDate(for: selectNumber))")
                
                // 현재 선택된 기록의 이름 보여주기.
                Text("\(logName)")
                    .underline()
                
                // 년, 월 Header
                Text(nowDate, formatter: Self.dateFormatter)
                    .font(.title)
                
                // 요일 이름
                HStack(spacing: 0) {
                    ForEach(0..<7) { dayWeek in
                        Text("\(Self.weekdaySymbols[dayWeek])")
                            .frame(width: 50)
                    }
                }
                
                // V, HStack으로 달력 그리기. 각 셀에 1부터 42까지 번호 cellNumber로 넘기기.
                VStack(spacing: 0) {
                    ForEach(0..<6) { row in
                        HStack(spacing: 0) {
                            ForEach(1..<8) { col in
                                DateCellView(nowDate: nowDate, cellNumber: (row * 7) + col, selectNumber: $selectNumber)
                            }
                        }
                    }
                }
                
                // 기록 버튼.
                Text("기록하기")
                    .frame(width: 320)
                    .padding()
                    .border(.black)
                
                // NavigationLink로 연결된 페이지 전환 버튼.
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
            // 선택된 Cell의 숫자와 날짜가 같으면 해당 Cell Color를 변경해 강조.
            if selectNumber == dateNumber(cellNumber: cellNumber) {
                Rectangle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
            }
            
            // 날짜가 들어있는 Cell을 그림.
            Rectangle()
                .stroke(Color.black, lineWidth: 1)
                .frame(width: 50, height: 50)
                .overlay(
                    Text("\(isDateNumber(cellNumber: cellNumber) ? String(dateNumber(cellNumber: cellNumber))+"일" : "")")
                )
        }
        .onTapGesture {
            // 터치했을 때 선택된 날짜를 selectNumber에 할당.
            if isDateNumber(cellNumber: cellNumber) {
                selectNumber = dateNumber(cellNumber: cellNumber)
            }
        }
    }
    
    // 날짜가 들어가야 하는 셀인지 빈 셀인지 판별하여 Bool 값을 반환하는 함수.
    private func isDateNumber(cellNumber: Int) -> Bool {
        var result: Bool = false
        
        if (cellNumber >= firstWeekdayOfMonth(in: nowDate)
            && cellNumber < numberOfDays(in: nowDate) + firstWeekdayOfMonth(in: nowDate)) {
            result = true
        }
        
        return result
    }
    
    // 셀의 숫자와 각 월의 시작 날짜를 계산하여 날짜(Int)를 반환하는 함수.
    private func dateNumber(cellNumber: Int) -> Int {
        var result: Int
        result = cellNumber - firstWeekdayOfMonth(in: nowDate) + 1
        
        return result
    }
}

private extension DateCellView {
    // 각 월의 총 일수를 정수로 반환하는 함수.
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    // 각 월의 시작일이 며칠 밀리는지 계산해서 정수로 반환하는 함수.
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!

        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
}

private extension MainCalendarView {
    // 정수로 받은 숫자를 날짜 Date로 변환하여 반환하는 함수.
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day-1, to: startOfMonth())!
    }
    
    // 날짜를 Date에서 Int로 변환하여 반환하는 함수.
    func dateToInt(for day: Date) -> Int{
        return Calendar.current.component(.day, from: day)
    }
    
    // 현재 월을 계산 후 Date로 반환하는 함수.
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: nowDate)
        return Calendar.current.date(from: components)!
    }
}

private extension MainCalendarView {
    // 요일을 담고 있는 문자 배열을 반환하는 함수.
    static let weekdaySymbols: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.shortWeekdaySymbols
    }()
    
    // 년, 월을 표기하는 Header에 들어갈 DateFormatter를 반환하는 함수.
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
