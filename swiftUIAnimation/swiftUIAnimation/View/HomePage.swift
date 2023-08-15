//
//  HomePage.swift
//  swiftUIAnimation
//
//  Created by Adhithya Ramakumar on 8/11/23.
//

import SwiftUI

struct HomePage: View {
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    var body: some View {
        List {
            ForEach(profiles) {
                profile in
                Button(action: {
                    selectedProfile = profile
                    pushView.toggle()
                }, label: {
                    HStack(spacing: 15) {
                        Color.clear
                            .frame(width: 90, height: 90)
                            .anchorPreference(key: ImageAnchorKey.self, value: .bounds,  transform: { anchor in
                                return [profile.id: anchor]
                            })
                        
                        VStack(alignment: .leading, spacing: 2, content: {
                            Text(profile.userName)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            Text(profile.profileDescription)
                                .font(.callout)
                                .foregroundStyle(.gray)
                            
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(profile.status)
                            .font(.caption)
                            .foregroundStyle(.green)
                    }
                    .contentShape(.rect)
                })

                
            }
        }
        .overlayPreferenceValue(ImageAnchorKey.self,{ value in
            GeometryReader(content: { geometry in
                ForEach(profiles) { profile in
                    if let anchor = value[profile.id], selectedProfile?.id != profile.id{
                        let rect = geometry[anchor]
                        ImageView(profile: profile, size: rect.size)
                            .offset(x: rect.minX, y: rect.minY)
                            .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                    }
                    
                }
            })
        })
    }
}

struct DetailView: View {
    @Binding var selectedProfile: Profile?
    @Binding var pushView: Bool
    @Binding var hideView: (Bool, Bool)
    var body: some View {
        if let selectedProfile {
            VStack{
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    VStack {
                        if hideView.0 {
                            ImageView(profile: selectedProfile, size: size)
                                .overlay(alignment: .top) {
                                    Button(action: {
                                        hideView.0 = false
                                        hideView.1 = true
                                        pushView = false
                                        /// Nav Pop
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            self.selectedProfile = nil
                                        }
                                    }, label: {
                                      Image(systemName: "xmark")
                                            .foregroundStyle(.white)
                                            . padding(10)
                                            .background(.black, in: .circle)
                                            .contentShape(.circle)
                                    })
                                    .padding(15)
                                    .padding(.top, 40)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .opacity(hideView.1 ? 1: 0)
                                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: hideView.1)
                                }
                            
                                .onAppear(perform: {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        hideView.1 = true
                                    }
                                })
                            
                            
                        } else {
                            Color.clear
                        }
                    }
                    
                    
                        .anchorPreference(key: ImageAnchorKey.self, value: .bounds,  transform: { anchor in
                            return [selectedProfile.id: anchor]
                        })
                    
                    
                })
                .frame(height: 400)
                .ignoresSafeArea()
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .toolbar(hideView.0 ? .hidden: .visible, for: .navigationBar)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                    hideView.0 = true
                }
            })
        }
    }
}

struct ImageView: View {
    var profile: Profile
    var size: CGSize
    var body: some View {
        Image(profile.profilePicture)
            .resizable()
            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .frame(width: size.width, height: size.height)
            .overlay(content: {
                LinearGradient(colors: [
                    .clear, .clear, .clear, .white.opacity(0.1),.white.opacity(0.5),.white.opacity(0.9),.white], startPoint: .top, endPoint: .bottom)
                .opacity(size.width > 90 ? 1 : 0)
               
            })
            .clipShape(.rect(cornerRadius: size.width > 100 ? 0: 60))

    }
}

#Preview {
    ContentView()
}
