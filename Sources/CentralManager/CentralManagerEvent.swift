// Copyright (c) 2022 Manuel Fernandez. All rights reserved.

import Foundation
import CoreBluetoothMock

public enum CentralManagerEvent {
    case didUpdateState(state: CBMManagerState)
    case didDisconnectPeripheral(peripheral: Peripheral, error: Error?)
}

