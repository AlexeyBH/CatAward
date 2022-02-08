//
//  CatModel.swift
//  CatAward
//
//  Created by Alexey Khestanov on 07.02.2022.
//

import Foundation

enum Size: CaseIterable {
    case small
    case medium
    case big
}

enum CatColor: CaseIterable {
    case white
    case yellow
    case orange
}

enum EyesType: CaseIterable {
    case openedNormal
    case openedWide
    case sleeping
    case enjoying
}

enum CheekColor: CaseIterable {
    case white
    case yellow
    case orange
    case lime
    case red
}

enum CheeckType: CaseIterable {

    case standart(catColor: CatColor)
    // Только белые котики могут иметь щечки разных цветов
    case left(color: CheekColor, size: Size)
    case right(color: CheekColor, size: Size)
    case both(color: CheekColor, size: Size)

    // Перечисление всех возможных комбинаций параметров для разных case
    static var allCases: [CheeckType] =
        CatColor.allCases.map {
            color in .standart(catColor: color)
        } + CheekColor.allCases.reduce([]) {
            (result, color) in
                result + Size.allCases.reduce([]) {
                    (tmpResult, size) in
                        tmpResult + [
                            .left(color: color, size: size),
                            .right(color: color, size: size),
                            .both(color: color, size: size)
                        ]
                }
        }
     
}


struct Cat {
    let catColor: CatColor
    let catSize: Size
    let eyesType: EyesType
    let mouthSize: Size
    let cheeckType: CheeckType
    
    init(catSize: Size, mouthSize: Size, eyesType: EyesType, cheeckType: CheeckType) {
        switch cheeckType {
        case .standart(let faceColor):
            catColor = faceColor
        default:
            catColor = .white
        }
        self.catSize = catSize
        self.mouthSize = mouthSize
        self.eyesType = eyesType
        self.cheeckType = cheeckType
    }
    
}

class Cats {
    
    static let catsCount = Int.random(in: 30...45)
    
    let shared = Cats(count: catsCount)

    let cats: [Cat]

    private init(count: Int) {
        let madeCats: [Cat] = (0..<count).compactMap { _ in
            guard let catSize = Size.allCases.randomElement(),
                  let mouthSize = Size.allCases.randomElement(),
                  let eyesType = EyesType.allCases.randomElement(),
                  let cheeckType = CheeckType.allCases.randomElement()
            else {
                return nil
            }
            return Cat(
                catSize: catSize,
                mouthSize: mouthSize,
                eyesType: eyesType,
                cheeckType: cheeckType
            )
        }
        cats = madeCats
    }
}
