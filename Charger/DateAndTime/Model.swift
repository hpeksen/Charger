//
//  Model.swift
//  Charger
//
//  Created by Hakan Pekşen on 17.07.2022.
//

import Foundation

struct SocketData: Decodable, Equatable {
    
    let city : Socket
    
    struct Socket: Decodable, Equatable {
        let stationID : Int
        let stationCode : String
        let sockets: [Sockets]
        let geoLocation: GeoLocation
        let services: [String]
        let stationName: String
    }
    struct Sockets : Decodable, Equatable {
        let socketID: Int
        let day: [Day]
        let socketType: String
        let chargeType: String
        let power: Int
        let socketNumber: Int
        let powerUnit: String
    }
    struct Day : Decodable, Equatable {
        let id: Int
        let date: String
        let timeSlots: [TimeSlots]
    }
    struct TimeSlots : Decodable, Equatable {
        let slot: String
        let isOccupied: Bool
    }
    struct GeoLocation : Decodable, Equatable {
        let longitude: Float
        let latitude: Float
        let provience: String
        let address: String
    }
}

extension SocketArray: Decodable {
    init(from decoder: Decoder) throws {
        self.city = try decoder.singleValueContainer().decode(SocketData.Socket.self)
    }
}

struct SocketArray {
    let city: SocketData.Socket
}
