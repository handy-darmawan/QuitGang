//
//  GSM.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

//buat atur Text
extension Text {
    // set kalo body brp, title brp,
    //title: 36
    //body:14
    func customText(size:Double) -> some View {
        self.font(.custom("SF Pro", size: size))
    }
 
}

extension Font {
    enum DogicaFont {
        case regular
        case bold
        case pixel
        case pixelbold
        case custom(String)
        
        var value: String {
            switch self {
            case .regular:
                return "dogica"
            case .bold:
                return "dogicabold"
            case .pixel:
                return "pixel"
            case .pixelbold:
                return "pixelbold"
            case .custom(let name):
                return name
            }
        }
    }
    
    enum PixeledFont {
        case pixeled
        case custom(String)
        
        var value: String {
            switch self {
            case .pixeled:
                return "Pixeled"
            case .custom(let name):
                return name
            }
        }
    }
    
    static func dogica(_ type: DogicaFont, size: CGFloat = 32) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func pixeled(_ type: PixeledFont, size: CGFloat = 32) -> Font {
        return .custom(type.value, size: size)
    }
}

//buat atur penempatan View
extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

//warna apps kita
struct AppColor {
    static let primary1 = Color("blue")
    static let primary2 = Color("yellow")
    static let secondary = Color("green")
    static let tertiary = Color("yellow")
    private init() {}
}

//ukuran image

//button start, submit

//button nagivation bar (save, edit, create team, create)

//back button (my teams, asoy geboy, edit profile)

//text field form
    //ada text
    //ada date
    //ada dropdown

//alert


//button alert


//tabview


//user info list


//team list container


//team member list container

//search bar



