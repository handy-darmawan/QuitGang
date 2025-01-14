//
//  CalendarComponent.swift
//  QuitZone
//
//  Created by ndyyy on 28/04/23.
//

import SwiftUI

struct CalendarComponent: View {
    let columns = Array(repeating: GridItem(), count:7)
    let weekDaysData: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State var currProgressDate = Date()
    @State var daysData: [String] = []
    @Binding var progressData: [ProgressModel]
    @Binding var progressDataByDate: [ProgressModel]

    var body: some View {
        VStack {
            //MARK: Calendar Navigation
            HStack {
                //left button
                Button {
                    currProgressDate = CalendarHelper().minusMonth(date: currProgressDate)
                    DispatchQueue.main.async {
                        daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
                    }
                } label: {
                    Image("ButtonLeft")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                //Month & Year
                HStack {
                    Text(CalendarHelper()
                        .getCalendarComponentString(date: currProgressDate, format: "LLLL")
                    )
                    .font(.secondary(.custom(24)))
                    Text(CalendarHelper()
                        .getCalendarComponentString(date: currProgressDate, format: "yyyy")
                    )
                    .font(.secondary(.custom(24)))
                }
                .frame(width: 200)
                
                //right button
                Button {
                    currProgressDate = CalendarHelper().plusMonth(date: currProgressDate)
                    DispatchQueue.main.async {
                        daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
                    }
                } label: {
                    Image("ButtonRight")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding(.bottom, 30)
            
            //MARK: Calendar Data
            LazyVGrid(columns: columns) {
                //MARK: WeekDays
                ForEach(weekDaysData, id: \.self) {day in
                    Text(day)
                        .hAlign(.center)
                        .padding(.trailing, 5)
                        .font(.secondary(.custom(22)))
                }
                
                //MARK: Day Section
                ForEach(daysData.indices, id:\.self) {x in
                    
                    let boxItem = daysData[x]
                    
                    //get the current item date (1 is random number that I generate to handle error in empty boxItem)
                    let itemDate = CalendarHelper().getItemDate(day: Int(boxItem) ?? 1, currAppDate: currProgressDate)
                    
                    //get cigarettes data from itemDate
                    let cigarettesData: Int = CalendarHelper().findCigInProgressData(itemDate: itemDate, progressData: progressData)
                    
                    //show cigarettes data in box
                    let showCigarettes: Bool = (cigarettesData != -1) ? true : false
                    
                    //used to block input from user in date greater than today
                    let fillData: Bool = itemDate <= Date()
                    
                    //MARK: Day
                    VStack {
                        Text(boxItem)
                            .padding(.bottom, -5)
                        //MARK: Cigarettes box
                        if boxItem != "" {
                            Text(showCigarettes ? String(cigarettesData) : " ")
                                .frame(width: 35, height: 35)
                                .background(
                                   fillData ?
                                    Image("CalendarTickFill")
                                        .resizable()
                                        .scaledToFit()
                                   :
                                   Image("CalendarTickUnFill")
                                       .resizable()
                                       .scaledToFit()
                                )
                                .padding(-1)
                        }
                    }
                    .onTapGesture {
                        //format date
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd MMMM yyyy"
                        let itemDateString = dateFormatter.string(from: itemDate)
                        
                        //testing
                        /*print("")
                        print("item date: \(itemDate)")
                        print("date now: \(Date())")
                        print("fill data: \(fillData)")
                        print("cig data: \(cigarettesData)")
                        print("show cig: \(showCigarettes)")
                        print("")
                        print("")
                         */
                        
                        //alert only show for item <= today date
                        if fillData {
                            customAlertTextField(title: itemDateString,
                                                 message: "Number of cigarettes",
                                                 leftButton: "Cancel",
                                                 rightButton: "Save") {
                                print("Cancelled")
                            } rightAction: { text in
                                
                                var isDataExist = false
                                
                                //find data to update
                                for index in progressData.indices {
                                    if progressData[index].date == itemDate {
                                        progressData[index].cigarettes = Int(text)!
                                        isDataExist = true
                                        break
                                    }
                                }
                                
                                //add new data if there's no record in itemDate
                                if !isDataExist {
                                    let newData = ProgressModel(date: itemDate, cigarettes: Int(text)!)
                                    progressData.append(newData)
                                    
                                    print("New data saved: \(text) with date \(itemDate)")
                                }
                                
                                //refresh calendar to see update and set statistics view to 7 Days
                                daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
                                progressDataByDate = CalendarHelper().showStatLastSevenDays(progressData: progressData)
//                                currPicker = "7 Days"
                            }
                        }
                    }
                    .hAlign(.center)
                    .padding(1)
                }
                
            }
            .hAlign(.center)
        }
        .onAppear {
            daysData = CalendarHelper().showCalendarData(currProgressDate: currProgressDate)
        }
        
    }
}
