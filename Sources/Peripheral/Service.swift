//  Copyright (c) 2021 Manuel Fernandez-Peix Perez. All rights reserved.

import Foundation
import CoreBluetoothMock
import CoreBluetooth

/// A collection of data and associated behaviors that accomplish a function or feature of a device.
/// - This class acts as a wrapper around `CBService`.
public struct Service {
    let cbService: CBMService
    
    /// The Bluetooth-specific UUID of the service.
    public var uuid: CBMUUID {
        self.cbService.uuid
    }
    
    /// A Boolean value that indicates whether the type of service is primary or secondary. A primary service
    /// describes the primary function of a device. A secondary service describes a service that’s relevant only
    /// in the context of another service that references it.
    public var isPrimary: Bool {
        self.cbService.isPrimary
    }
    
    /// A list of included services discovered in this service.
    public var discoveredIncludedServices: [Service]? {
        self.cbService.includedServices?.map { Service($0) }
    }
    
    /// A list of characteristics discovered in this service.
    public var discoveredCharacteristics: [Characteristic]? {
        self.cbService.characteristics?.map { Characteristic($0) }
    }
    
    init(_ cbService: CBMService) {
        self.cbService = cbService
    }
    
    public var identifier: UUID {
        UUID(uuidString: uuid.uuidString)!
    }
}
