
import Foundation
import SwiftUI
import Charts

struct HourlyWeatherChart : View {
    private let hourWidth = 75.0
    
    let hours: [HourChartItemViewModel]
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                Chart {
                    ForEach(hours) { hour in
                        
                        LineMark(
                            x: .value(
                                "time",
                                hour.timeAsString),

                            y: .value("temp", hour.temp)
                        )
                        .lineStyle(.init(lineWidth: 2))
                        .foregroundStyle(Color(uiColor: Colors.Weather.Hourly.hourChartLineColor))
                        
                        PointMark(
                            x: .value(
                                "time",
                                hour.timeAsString),

                            y: .value("temp", hour.temp)
                        )
                        .foregroundStyle(.white)
                        .annotation(position: .top, alignment: .center) {
                            Text(hour.tempAsString)
                                .font(Fonts.rubikRegular14.toFont())
                                .padding(.bottom, 5)
                        }
                        
                        AreaMark(
                            x: .value(
                                "time",
                                hour.timeAsString
                            ),
                            yStart: .value("temp", hour.temp >= 0 ?  hour.temp - 1 : hour.temp + 1),
                            yEnd: .value("minValue", 0)
                        )
                        .foregroundStyle(hour.temp >= 0 ? Gradient(colors: [
                            Color(red: 61/255.0, green: 105/255.0, blue: 220/225.0, opacity: 0.3),
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0.3),
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0),
                        ]) : Gradient(colors: [
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0),
                            Color(red: 32/255.0, green: 78/255.0, blue: 199/225.0, opacity: 0.3),
                            Color(red: 61/255.0, green: 105/255.0, blue: 220/225.0, opacity: 0.3),
                        ]))
                    }
                }
                .frame(width: Double(hours.count) * hourWidth,
                       height: 60)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .padding(.bottom, 5)
                
                Chart {
                    ForEach (hours) { hour in
                        
                        LineMark(
                            x: .value(
                                "time",
                                hour.timeAsString),

                            y: .value("precipitation", hour.precipitation)
                        )
                        .lineStyle(.init(lineWidth: 1))
                        .foregroundStyle(Color(uiColor: Colors.Weather.Hourly.hourChartLineColor))
                        
                        PointMark(
                            x: .value(
                                "time",
                                hour.timeAsString),

                            y: .value("temp", hour.precipitation)
                        )
                        .foregroundStyle(.white)
                        .annotation(position: .top, alignment: .center) {
                            Text(hour.precipitationAsString)
                                .font(Fonts.rubikRegular14.toFont())
                                .padding(.bottom, 5)
                        }
                    }
                }
                .frame(width: Double(hours.count) * hourWidth,
                       height: 92)
                .chartXAxis {
                    AxisMarks { mark in
                        AxisValueLabel()
                            .font(Fonts.rubikRegular14.toFont())
                            .foregroundStyle(.black)
                    }
                }
                .chartYAxis(.hidden)
                .padding(.bottom, 5)
            }
        }
        .background(Color(Colors.Weather.Hourly.tableBackground))
    }
}
