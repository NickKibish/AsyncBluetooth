//  Copyright (c) 2021 Manuel Fernandez-Peix Perez. All rights reserved.

import Foundation
import CoreBluetoothMock

/// A characteristic of a remote peripheral’s service.
/// - This class acts as a wrapper around `CBCharacteristic`.
public struct Characteristic {
    let cbCharacteristic: CBMCharacteristic
    
    init(_ cbCharacteristic: CBMCharacteristic) {
        self.cbCharacteristic = cbCharacteristic
    }
    
    /// The Bluetooth-specific UUID of the characteristic.
    public var uuid: CBMUUID {
        self.cbCharacteristic.uuid
    }
    
    public var properties: CBMCharacteristicProperties {
        self.cbCharacteristic.properties
    }
    
    /// The latest value read for this characteristic.
    public var value: Data? {
        self.cbCharacteristic.value
    }

    /// A list of the descriptors discovered in this characteristic.
    public var descriptors: [Descriptor]? {
        self.cbCharacteristic.descriptors?.map { Descriptor($0) }
    }

    /// A Boolean value that indicates whether the characteristic is currently notifying a subscribed central
    /// of its value.
    public var isNotifying: Bool {
        self.cbCharacteristic.isNotifying
    }
}
