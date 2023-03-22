//
//  ProfileModel.swift
//  Guilty
//
//  Created by Вячеслав Герасимов on 27.02.2023.
//

import Foundation
import SwiftUI


struct Profile {
    var username: String
    var mainPhoto: UIImage
    var hiddenPhotos: [UIImage?]
    var description: String?
}
