//
//  CustomDatePicker.swift
//  RoutineManger
//
//  Created by 문다 on 2022/05/09.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    @ObservedObject var viewModel: HistoryViewModel
    @ObservedObject var goalViewModel : ManageViewModel
    
    // Month update on arrow button clicks
    @State var currentMonth: Int = 0
    
    // Days
    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    // Months
    let months: [String : String] = ["January" : "01", "February":"02   ","March":"03","April":"04","May":"05","June":"06","July":"07", "August":"08","September":"09","October":"10","November":"11","December":"12"]
    
    func fetchMonthData() {
        viewModel.queryWeekSleep(date: "\(extraDate()[0])-\(String(describing: months[extraDate()[1]]!))-01", offset: 31)
    }
    
    var body: some View {
        VStack() {
            
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label : {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label : {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            // Day View
            
            HStack() {
                ForEach(days, id: \.self) {day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity) // 자동 간격 최대
                }
            }
            //Dates
            // Lazy Grid
            let columns = Array(repeating: GridItem() , count: 7)
            
            LazyVGrid(columns: columns) {
                ForEach(extractDate()) { value in
                    NavigationLink (destination: HistoryView(historyDate: value, viewModel: viewModel, goalViewModel: goalViewModel), label: {
                        CardView(value: value)
                            .frame(height: 70, alignment: .top)
                    })
                }
            }
        }
        .onChange(of: currentMonth) { newValue in
            // updating Month
            currentDate = getCurrentMonth()
        }
        .onAppear {
            fetchMonthData()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        HStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .padding([.leading, .top], 10)
                
                // poop code : ForEach문이 30번 (또는 31번 돌아감)
                // 🚫 error : 상세 히스토리를 조회하고 back해 나오면 아래코드만 두번 돌아감
                HStack {
                    ForEach(viewModel.offsetSleepRecord, id: \.self) {
                        if $0.date == Date2OnlyDate(date: value.date) && compareTimes(isLonger: getTimeDiff(from: $0.bedTime!, to: $0.wakeUpTime!), isShorter: getTimeDiff(from: goalViewModel.sleepGoal.goalBedTime, to: goalViewModel.sleepGoal.goalWakeUpTime)) {
                            Image(systemName: "checkmark.seal")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    // extraction Year and Month for display
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
        // extraDate()[0]이면 "YYYY"년
        // extraDate()[1]이면 "MMMM"월
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // Getting current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return Date() }
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
        //Getting Current Month Date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date ->
            DateValue in
            
            //getting day
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        // adding offset dys to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in (0..<(firstWeekday - 1)) {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

// Extending Date to get Current Month Dates
extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // getting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        // getting date
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
