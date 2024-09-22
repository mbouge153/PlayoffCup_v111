//
//  RinkView.swift
//  PlayoffCup_v111
//
//  Created by Mark Bourgeois on 9/11/23.
//

import SwiftUI

struct RedLines: Shape {
    
    func path(in rect: CGRect) -> Path {
        let width: Double = rect.maxX
        let height: Double = (rect.maxX * 85/200)
        
        var path = Path()
        
        path.move(to: CGPoint(x: (width * 20 / 200), y: width * 8 / 200))
        path.addLine(to: CGPoint(x: (width * 20 / 200), y: height - (width * 8 / 200)))
        
        path.move(to: CGPoint(x: width / 2, y: width * 5 / 200))
        path.addLine(to: CGPoint(x: width / 2, y: height - (width * 5 / 200)))
        
        path.move(to: CGPoint(x: width - (width * 20 / 200), y: width * 8 / 200))
        path.addLine(to: CGPoint(x: width - (width * 20 / 200), y: height - (width * 8 / 200)))
        
        return path
    }
}

struct BlueLines: Shape {
    
    func path(in rect: CGRect) -> Path {
        let width: Double = rect.maxX
        let height: Double = (rect.maxX * 85/200)
        
        var path = Path()
        
        path.move(to: CGPoint(x: (width / 2) - (width * 25 / 200) + 0, y: width * 5 / 200))
        path.addLine(to: CGPoint(x: (width / 2) - (width * 25 / 200) + 0, y: height - (width * 5 / 200)))
        
        path.move(to: CGPoint(x: (width / 2) + (width * 25 / 200) + 0, y: width * 5 / 200))
        path.addLine(to: CGPoint(x: (width / 2) + (width * 25 / 200) + 0, y: height - (width * 5 / 200)))
        
        return path
    }
}

struct GoalPaint: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let width: Double = rect.maxX
        let height: Double = (rect.maxX * 85/200)
        
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: (width * 20 / 200), y: height / 2), radius: width * 8 / 200, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        path.move(to: CGPoint(x: width - (width * 20 / 200), y: 15))
        
        path.addArc(center: CGPoint(x: width - (width * 20 / 200), y: height / 2), radius: width * 8 / 200, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)
        
        return path
    }
}


struct Goal: Shape {
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let width: Double = rect.maxX
        let height: Double = (rect.maxX * 85/200)
        
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.move(to: CGPoint(x: (width * 19 / 200), y: (height / 2) - (width * 4 / 200)))
        
        path.addArc(center: CGPoint(x: (width * 18 / 200), y: (height / 2) - (width * 2 / 200)), radius: width * 2 / 200, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        path.addLine(to: CGPoint(x: (width * 18 / 200) - (width * 2 / 200), y: height / 2 + (width * 2 / 200)))
        
        path.addArc(center: CGPoint(x: (width * 18 / 200), y: (height / 2) + (width * 2 / 200)), radius: width * 2 / 200, startAngle: modifiedStart + Angle.degrees(270), endAngle: modifiedEnd - Angle.degrees(90), clockwise: !clockwise)
        
        path.addLine(to: CGPoint(x: (width * 20 / 200), y: height / 2 + (width * 4 / 200)))
        
        
        path.move(to: CGPoint(x: width - (width * 19 / 200), y: (height / 2) - (width * 4 / 200)))
        
        path.addArc(center: CGPoint(x: width - (width * 18 / 200), y: (height / 2) - (width * 2 / 200)), radius: width * 2 / 200, startAngle: modifiedStart, endAngle: modifiedEnd - Angle.degrees(180), clockwise: clockwise)
        
        path.addLine(to: CGPoint(x: width - (width * 18 / 200) + (width * 2 / 200), y: height / 2 + (width * 2 / 200)))
        
        path.addArc(center: CGPoint(x: width - (width * 18 / 200), y: (height / 2) + (width * 2 / 200)), radius: width * 2 / 200, startAngle: modifiedStart + Angle.degrees(90), endAngle: modifiedEnd - Angle.degrees(90), clockwise: clockwise)
        
        path.addLine(to: CGPoint(x: width - (width * 20 / 200), y: height / 2 + (width * 4 / 200)))
        
        return path
    }
}



struct RinkView: View {
    @ObservedObject var gameState: GameState
    var rinkCorner: Double = 28/200
//    var selectedColor: Color
    
    var body: some View {
        GeometryReader { geo in
            let thickLineWidth = geo.size.width * 3 / 200
            let thinLineWidth = geo.size.width * 1 / 200
            let boardWidth = geo.size.width * 4 / 200
            
            ZStack {
//                Color.yellow
//                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: geo.size.width * rinkCorner)
                    .fill(.white)
                    .frame(width: geo.size.width, height: geo.size.width * 85/200)

                Group {
                    BlueLines()
                        .stroke(.blue, style: StrokeStyle(lineWidth: thickLineWidth, lineCap: .square, lineJoin: .bevel))
                        .blur(radius: 1.5)
                        .frame(width: geo.size.width, height: geo.size.width * 85 / 200)
                    
                    
                    GoalPaint(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
                        .fill(.blue)
                        .blur(radius: 1.5)
                        .frame(width: geo.size.width, height: geo.size.width * 85 / 200)
                    
                    GoalPaint(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
                        .stroke(.red, lineWidth: thinLineWidth)
                        .blur(radius: 1.5)
                        .frame(width: geo.size.width, height: geo.size.width * 85 / 200)
                    
                    
                    RedLines()
                        .stroke(.red, style: StrokeStyle(lineWidth: thickLineWidth, lineCap: .square, lineJoin: .bevel))
                        .blur(radius: 1.5)
                        .frame(width: geo.size.width, height: geo.size.width * 85 / 200)
                }
                
                Group {
                    Circle()
                        .stroke(.red, lineWidth: thinLineWidth)
                        .offset(x: (-geo.size.width / 4) - (geo.size.width * 4 / 200), y: -geo.size.width * 16 / 200)
                        .frame(width: geo.size.width * 22 / 200)
                        .blur(radius: 1.0)
                    
                    Circle()
                        .stroke(.red, lineWidth: thinLineWidth)
                        .offset(x: (geo.size.width / 4) + (geo.size.width * 4 / 200), y: -geo.size.width * 16 / 200)
                        .frame(width: geo.size.width * 22 / 200)
                        .blur(radius: 1.0)
                    
                    Circle()
                        .stroke(.red, lineWidth: thinLineWidth)
                        .offset(x: (-geo.size.width / 4) - (geo.size.width * 4 / 200), y: geo.size.width * 16 / 200)
                        .frame(width: geo.size.width * 22 / 200)
                        .blur(radius: 1.0)
                    
                    Circle()
                        .stroke(.red, lineWidth: thinLineWidth)
                        .offset(x: (geo.size.width / 4) + (geo.size.width * 4 / 200), y: geo.size.width * 16 / 200)
                        .frame(width: geo.size.width * 22 / 200)
                        .blur(radius: 1.0)
                    
                    Circle()
                        .stroke(.red, lineWidth: thinLineWidth)
                        .frame(width: geo.size.width * 25 / 200)
                        .blur(radius: 1.0)
                }
                
                
                RoundedRectangle(cornerRadius: geo.size.width * rinkCorner)
                    .fill(.white)
                    .frame(width: geo.size.width, height: geo.size.width * 85/200)
                    .opacity(0.25)
                
                Goal(startAngle: .degrees(0), endAngle: .degrees(270), clockwise: false)
                    .stroke(.red, lineWidth: thinLineWidth)
//                    .blur(radius: 1.5)
                    .frame(width: geo.size.width, height: geo.size.width * 85 / 200)
                    
                
                RoundedRectangle(cornerRadius: geo.size.width * rinkCorner)
                    .strokeBorder(gameState.highlightColor, lineWidth: boardWidth * 2)
                    .frame(width: geo.size.width, height: geo.size.width * 85/200)
                    .overlay(RoundedRectangle(cornerRadius: geo.size.width * rinkCorner).strokeBorder(Color.black, lineWidth: boardWidth))
                
                if gameState.enableRinkView {
                    ZStack {
                        gameState.highlightColor
                            .frame(width: geo.size.width * 35/200, height: geo.size.width * 7/200)
                        Text("PERIOD \(gameState.period)")
                            .font(.system(size: geo.size.width * 6/200))
                    }
                    .offset(y: geo.size.width * 39/200)
                    
                    ZStack {
                        gameState.highlightColor
                            .frame(width: geo.size.width * 60/200, height: geo.size.width * 7/200)
                        HStack {
                            if gameState.skatersLeft > 0 {
                                ForEach(0..<gameState.skatersLeft, id: \.self) { _ in
                                    Text("⛸️")
                                        .font(.system(size: geo.size.width * 5/200))
                                }
                            }
                            Spacer()
                        }
                        .frame(width: geo.size.width * 53/200, height: geo.size.width * 7/200)
                    }
                    .offset(y: -geo.size.width * 39/200)
                }
            }
        }
    }
}

struct RinkView_Previews: PreviewProvider {
    static var previews: some View {
        RinkView(gameState: GameState())
//            .previewInterfaceOrientation(.landscapeRight)
    }
}
