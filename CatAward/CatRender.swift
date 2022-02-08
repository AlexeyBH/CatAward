//
//  CatRender.swift
//  CatAward
//
//  Created by Alexey Khestanov on 08.02.2022.
//

import SwiftUI

enum CurveData {
    case dot(_ x: CGFloat, _ y: CGFloat)
    case move(_ toX: CGFloat, _ toY: CGFloat)
    case line(_ toX: CGFloat, _ toY: CGFloat)
    case quad(_ toX: CGFloat, _ toY: CGFloat, _ ctrlX: CGFloat, _ ctrlY: CGFloat)
    case curve(_ toX: CGFloat, _ toY: CGFloat, _ ctrlX0: CGFloat, _ ctrlY0: CGFloat, _ ctrlX1: CGFloat, _ ctrlY1: CGFloat)
    case arc(_ tanX0: CGFloat, _ tanY0: CGFloat, _ tanX1: CGFloat, _ tanY1: CGFloat, _ radius: CGFloat)
    case rect(_ fromX: CGFloat, _ fromY: CGFloat, _ width: CGFloat, _ height: CGFloat)
}


func drawPath(path: inout Path, scale: CGFloat, _ data: () -> [CurveData]) {

    func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        CGPoint(x: x * scale, y: y * scale)
    }

    data().forEach { element in
        switch element {
        case .dot(let x, let y):
            let dotSize = 5
            let rect = CGRect(
                        x: Int(x * scale),
                        y: Int(y * scale),
                        width: dotSize,
                        height: dotSize
            )
            path.addRect(rect)
        case .rect(let fromX, let fromY, let width, let height):
            let rect = CGRect(
                        x: Int(fromX * scale),
                        y: Int(fromY * scale),
                        width: Int(width * scale),
                        height: Int(height * scale)
            )
            path.addRect(rect)
        case .move(let toX, let toY):
            let point = pt(toX, toY)
            path.move(to: point)
        case .line(let toX, let toY):
            let point = pt(toX, toY)
            path.addLine(to: point)
        case .quad(let toX, let toY, let ctrlX, let ctrlY):
            let point = pt(toX, toY)
            let control = pt(ctrlX, ctrlY)
            path.addQuadCurve(to: point, control: control)
        case .curve(let toX, let toY, let ctrlX0, let ctrlY0, let ctrlX1, let ctrlY1):
            let point = pt(toX, toY)
            let ctrl0 = pt(ctrlX0, ctrlY0)
            let ctrl1 = pt(ctrlX1, ctrlY1)
            path.addCurve(to: point, control1: ctrl0, control2: ctrl1)
        case .arc(let tanX0, let tanY0, let tanX1, let tanY1, let radius):
            let tan0 = pt(tanX0, tanY0)
            let tan1 = pt(tanX1, tanY1)
            path.addArc(tangent1End: tan0, tangent2End: tan1, radius: radius * scale)
            
        }
    }
}
