//
//  ScheduleView.swift
//  Delee
//
//  Created by Шабнам Шарипова on 16/10/26.
//

import SwiftUI

struct ScheduleView:View {
    let schedule = [
        ("Понедельник", "10:00 – 22:00"),
                ("Вторник", "10:00 – 22:00"),
                ("Среда", "10:00 – 22:00"),
                ("Четверг", "10:00 – 22:00"),
                ("Пятница", "10:00 – 23:00"),
                ("Суббота", "11:00 – 23:00"),
                ("Воскресенье", "11:00 – 22:00")
    ]
    var todayIndex:Int{
        let weekday = Calendar.current.component(.weekday, from: Date())
        return weekday == 1 ? 6 : weekday - 2
    }
    var isOpenNow:Bool{
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 10 && hour < 22
    }
    var body: some View {
        NavigationStack{
            ScrollView{
                HStack(spacing:8){
                    Circle()
                        .fill(isOpenNow ? Color.green : Color.red)
                        .frame(width: 15,height: 15)
                    Text(isOpenNow ? "Сейчас открыто" : "Сейчас закрыто")
                           .font(.headline)

                       Spacer()
                }
                .padding(16)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                VStack(spacing: 12){
                    ForEach(Array(schedule.enumerated()),id: \.offset){index, item in
                        HStack{
                            Text(item.0)
                                .font(.headline)
                            Spacer()
                            Text(item.1)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(16)
                        .background(index == todayIndex ? Color.accentOrange.opacity(0.15) : Color(.systemGray6) )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                }
                .padding(16)
            }
            .navigationTitle("График работы")
        }
    }
        
}


#Preview {
    ScheduleView()
}
