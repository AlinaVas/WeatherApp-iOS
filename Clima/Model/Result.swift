//
//  Result.swift
//  Clima
//
//  Created by Alina Fesyk on 3/22/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ErrorType)
}
