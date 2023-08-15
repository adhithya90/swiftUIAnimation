//
//  Profile.swift
//  swiftUIAnimation
//
//  Created by Adhithya Ramakumar on 8/11/23.
//

import SwiftUI

/// Profile data
struct Profile: Identifiable {
    var id = UUID().uuidString
    var userName: String
    var profilePicture: String
    var profileDescription: String
    var status: String
}

var profiles = [
    Profile(userName: "Adhithya", profilePicture: "00", profileDescription: "A description goes here", status: "Active"),
    Profile(userName: "Design&Debug", profilePicture: "01", profileDescription: "A description goes here", status: "Active"),
    Profile(userName: "Design", profilePicture: "02", profileDescription: "A description goes here", status: "Active"),
    Profile(userName: "Debug", profilePicture: "03", profileDescription: "A description goes here", status: "Active")
    ]
