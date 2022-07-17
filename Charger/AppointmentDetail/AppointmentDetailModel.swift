//
//  AppointmentDetailModel.swift
//  Charger
//
//  Created by Hakan Pekşen on 17.07.2022.
//

import Foundation

struct AppointmentData: Decodable, Equatable {
    
    let appointment : Appointment
    
    struct Appointment: Decodable, Equatable {
        let time : String
        let date : String
        let station: [Station]
        let stationCode : String
        let userID: Int
        let socketID: Int
    }
    struct Station : Decodable, Equatable {
        let id: Int
        let stationCode: String
        let sockets: [Socket]
        let socketCount: Int
        let occupiedSocketCount: Int
        let distanceInKM: Double
        let geoLocation: GeoLocation
        let services: [String]
        let stationName: String
    }
    
    struct Socket : Decodable, Equatable {
        let socketID: Int
        let socketType: String
        let chargeType: String
        let power: Int
        let powerUnit: String
        let socketNumber: Int
    }
    
    struct GeoLocation : Decodable, Equatable {
        let longitude: Float
        let latitude: Float
        let provience: String
        let address: String
    }
}

extension AppointmentArray: Decodable {
    init(from decoder: Decoder) throws {
        self.appointment = try decoder.singleValueContainer().decode(AppointmentData.Appointment.self)
    }
}

struct AppointmentArray {
    let appointment: AppointmentData.Appointment
}
