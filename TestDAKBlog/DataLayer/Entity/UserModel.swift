//
//  UserModel.swift
//  TestDAKBlog
//
//  Created by Tio Hardadi Somantri on 11/3/23.
//

import Foundation

// MARK: - UserLoginResponse
struct UserResponse: Codable {
    let success: Bool
    let message: String
    let data: DataLogin
}

// MARK: - DataClass
struct DataLogin: Codable {
    let token, name, email: String?
}

