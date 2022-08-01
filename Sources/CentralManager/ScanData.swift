//  Copyright (c) 2021 Manuel Fernandez-Peix Perez. All rights reserved.

import Foundation
import CoreBluetoothMock

/// Represents a single value gathered when scanning for peripheral.
public struct ScanData {
    public let peripheral: Peripheral
    /// A dictionary containing any advertisement and scan response data.
    public let advertisementData: [String : Any]
    /// The current RSSI of the peripheral, in dBm. A value of 127 is reserved and indicates the RSSI
    /// was not available.
    public let rssi: Int
}

extension Peripheral: Hashable {
    public static func == (lhs: Peripheral, rhs: Peripheral) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension ScanData: Hashable {
    public static func == (lhs: ScanData, rhs: ScanData) -> Bool {
        lhs.peripheral == rhs.peripheral
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(peripheral.identifier)
    }
}

extension ScanData {
    public func containsService(_ serviceId: UUID) -> Bool {
        let services: [CBMUUID:NSData]? = advertisementData[CBMAdvertisementDataServiceDataKey] as? [CBMUUID:NSData]
        if let services = services {
            if services.keys.contains(CBMUUID(string: serviceId.uuidString)) {
                return true
            }
            return false
        } else {
            return false
        }
    }
}
