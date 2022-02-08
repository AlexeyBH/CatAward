//
//  Cat.swift
//  CatAward
//
//  Created by Alexey Khestanov on 07.02.2022.
//

import SwiftUI



struct MyCat: View {
    let cat: Cat
    @State var path: Path = Path()
    
    var body: some View {
        GeometryReader { geometry in
          //  let width = 500.0
        Path { path in
            drawPath(path: &path, scale: 300) {[
                
                .dot(0.0, 0.0),
                .dot(0.5, 0.0),
                .dot(1.0, 0.0),
                .dot(0.0, 0.5),
                .dot(0.5, 0.5),
                .dot(1.0, 0.5),
                .dot(0.0, 1.0),
                .dot(0.5, 1.0),
                .dot(1.0, 1.0),
                
                .move(0.5, 0.0),
                .curve(0.5, 0.5, 0.4, 0.4, 0.6, 0.6)
       
                
                
            ]}
        }.frame(width: 500.0, height: 500.0, alignment: .center)
                .padding(50)
    }
    }
    
}



struct Cat_Previews: PreviewProvider {
    static var previews: some View {
        MyCat(cat: Cat(
            catSize: .big,
            mouthSize: .medium,
            eyesType: .openedNormal,
            cheeckType: .standart(catColor: .orange))
        ).frame(width: 400, height: 400)
    }
}
