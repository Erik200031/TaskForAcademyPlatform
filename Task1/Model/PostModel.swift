//
//  PostModel.swift
//  Task1
//
//  Created by PicsartAcademy on 26.10.22.
//

import Foundation

struct Post : Codable {
    var userId: Int
    var title: String?
    var body: String?
}
