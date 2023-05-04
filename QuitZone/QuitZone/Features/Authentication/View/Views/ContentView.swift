//
//  ContentView.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 19/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentPage = Page.home
    
    @State private var dummyUser : User = User(name: "Leonardo Da Vinci", dateOfBirth: "1 April 1050", frequency: 1, smokerFor: "Not set", typeOfCigarette: "Not set", email: "Not set", phone: "Not set")
    
    var body: some View {
        VStack {
            switch currentPage {
            case Page.welcome :
                WelcomeComponent(currentPage: $currentPage)
            case Page.form :
                FormComponent(dummyUser: $dummyUser, currentPage: $currentPage)
            default:
                VStack {
                    GeometryReader { geometry in
                        ZStack {
                            switch currentPage {
                            case Page.home:
                                HomeView()
                            case Page.friend:
                                MainTeamView()
                            case Page.mission:
                                MissionView()
                            case Page.user:
                                UserComponent()
                            default:
                                HomeView()
                            }
                            // bottom tab bar
                            VStack {
                                Spacer()
                                HStack {
                                    
                                    Spacer()
                                    
                                    customNavigationButton(page: Page.home, image: "barHome", currentPage: $currentPage)
                                    
                                    Spacer()
                                    
                                    customNavigationButton(page: Page.friend, image: "barGangs", currentPage: $currentPage)
                                    
                                    Spacer()
                                    
                                    customNavigationButton(page: Page.mission, image: "barTasks", currentPage: $currentPage)
                                    
                                    Spacer()
                                    
                                    customNavigationButton(page: Page.user, image:"barProfile", currentPage: $currentPage)
                                    
                                    Spacer()
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height/9)
                                .background(Material.ultraThinMaterial.opacity(0.1))
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
