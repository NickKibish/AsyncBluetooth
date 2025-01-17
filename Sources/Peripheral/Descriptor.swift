//  Copyright (c) 2021 Manuel Fernandez-Peix Perez. All rights reserved.

import Foundation
import CoreBluetoothMock
import CoreBluetooth

/// An object that provides further information about a remote peripheral’s characteristic.
/// - This class acts as a wrapper for `CBDescriptor`.
public struct Descriptor {
    let cbDescriptor: CBMDescriptor
    
    init(_ cbDescriptor: CBMDescriptor) {
        self.cbDescriptor = cbDescriptor
    }
    
    /// The Bluetooth-specific UUID of the descriptor.
    public var uuid: CBMUUID {
        self.cbDescriptor.uuid
    }
    
    public var value: Any? {
        self.cbDescriptor.value
    }
}
