//
//  CLProximity+CustomStringConvertible.swift
//  iBacon
//
//  Created by 14223775 on 19/10/2018.
//  Copyright © 2018 14223775. All rights reserved.
//

import Foundation
import CoreLocation

extension CLProximity:CustomStringConvertible {
    public var description:String {
        switch self {
            
        case .unknown:
            return "Unknown"
        case .immediate:
            return "Immediate"
        case .near:
            return "Near"
        case .far:
            return "Far"
        default:
            return "Unknown"
            
        }
    }
}
