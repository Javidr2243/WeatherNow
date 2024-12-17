//
//  CityRow.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import SwiftUI

struct CityRow: View {
    var ciudad: String
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "mappin.and.ellipse")
                    .padding()
                Text(ciudad)
                    .font(Font.custom("Myfont", size: 20))
                
                Spacer()
            }
        }
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(ciudad: "Reynosa")
    }
}
