//
//  ProfileObject.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 29/6/25.
//
import Foundation

struct Profile: Identifiable {
    var id: String
    let firstName: String
    let lastName: String
    let gender: String
    let weight: Double
    let height: Double
    var fullName: String {
        firstName + " " + lastName
    }
    var bmi: Double
    {
        weight / pow(height / 100, 2)
    }
    
    init(id: String = UUID().uuidString, firstName: String, lastName: String, gender: String, weight: Double, height: Double) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.weight = weight
        self.height = height
    }
}

enum ProfileActionType {
    case delete(String)
    case edit(id: String, firstName: String, lastName: String, gender: String, weight: Double, height: Double)
    case add(Profile)
}

enum UpdateAction {
    case initial(profiles: [Profile])
    case update(index: Int, profile: Profile)
    case delete(index: Int)
    case add(profile: Profile)
}

