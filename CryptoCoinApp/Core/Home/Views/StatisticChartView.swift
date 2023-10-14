//
//  StatisticChartView.swift
//  CryptoCoinApp
//
//  Created by s on 14/10/2023.
//


import SwiftUI

struct StatisticChartView: View {
    let data: [Double] = [30, 50, 20, 45, 60, 30, 70, 45, 80, 40]
    let maxValue: Double = 80 // You can adjust this value based on your data range
    @State  var percentage: CGFloat = 0
    
    
    var body: some View {
        VStack {
            Text("Statistics Chart")
                .font(.title)
                .padding()
            
            GeometryReader { geometry in
                ZStack {
                    // Background grid
                    Path { path in
                        for i in 0...4 {
                            let y = CGFloat(i) / 5.0 * geometry.size.height
                            path.move(to: CGPoint(x: 0, y: y))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                        }
                    }
                    .trim(from: 0, to: percentage)
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 2, dash: [5]))
                    
                    // Data points
                    Path { path in
                        for i in 0..<data.count {
                            let x = CGFloat(i) / CGFloat(data.count - 1) * geometry.size.width
                            let y = geometry.size.height - (CGFloat(data[i]) / CGFloat(maxValue)) * geometry.size.height
                            if i == 0 {
                                path.move(to: CGPoint(x: x, y: y))
                            } else {
                                path.addLine(to: CGPoint(x: x, y: y))
                            }
                        }
                    }
                    .trim(from: 0, to: percentage)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin:  .round))
                    .shadow(color: Color.blue, radius: 10, x: 0, y: 10)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 20)
                    .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 30)
                    .shadow(color: Color.blue.opacity(0.2), radius: 10, x: 0, y: 40)
                    
//                    // Data point markers
//                    ForEach(0..<data.count) { i in
//                        let x = CGFloat(i) / CGFloat(data.count - 1) * geometry.size.width
//                        let y = geometry.size.height - (CGFloat(data[i]) / CGFloat(maxValue)) * geometry.size.height
//                        Circle()
//                            .fill(Color.blue)
//                            .frame(width: 8, height: 8)
//                            .position(x: x, y: y)
//                    }
                }
            }
            .frame(height: 200)
        
        }
        .onAppear {
            // Add a 2-second delay before showing the link
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 3)) {
                
                    percentage = 1
                }
                
            }
        }
    }
}

struct StatisticChartView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticChartView()
    }
}

