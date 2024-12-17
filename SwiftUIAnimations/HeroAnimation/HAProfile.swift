//
//  HAProfile.swift
//  SwiftUIAnimations
//
//  Created by Mohammad Afshar on 15/12/2024.
//

import SwiftUI

struct ProfileModel: Identifiable {
    var id = UUID().uuidString
    var userName: String
    var profilePicture: String
    var lastMsg: String
    var lastActive: String
}

var profileSample: [ProfileModel] = [
    .init(userName: "Jimmy", profilePicture: "ImageA", lastMsg: "Hi Mohammad", lastActive: "10:10 PM"),
    .init(userName: "Alex", profilePicture: "ImageB", lastMsg: "Hi Mohammad", lastActive: "11:11 AM"),
    .init(userName: "Harry", profilePicture: "ImageC", lastMsg: "Hi Mohammad", lastActive: "14:14 AM"),
    .init(userName: "Johnny", profilePicture: "ImageD", lastMsg: "Hi Mohammad", lastActive: "20:20 AM"),
    .init(userName: "Tummy", profilePicture: "ImageE", lastMsg: "Hi Mohammad", lastActive: "12:12 PM")
]
