//  Copyright (c) 2021 Manuel Fernandez-Peix Perez. All rights reserved.

import Foundation
import CoreBluetoothMock
import CoreBluetooth
import Combine

/// Contains the objects necessary to track a Peripheral's commands.
class PeripheralContext {
    private(set) lazy var characteristicValueUpdatedSubject = PassthroughSubject<Characteristic, Never>()
    
    private(set) lazy var readRSSIExecutor = AsyncSerialExecutor<NSNumber>()
    private(set) lazy var discoverServiceExecutor = AsyncSerialExecutor<Void>()
    private(set) lazy var discoverIncludedServicesExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var discoverCharacteristicsExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var readCharacteristicValueExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var writeCharacteristicValueExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var setNotifyValueExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var discoverDescriptorsExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var readDescriptorValueExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var writeDescriptorValueExecutor = AsyncExecutorMap<CBMUUID, Void>()
    private(set) lazy var openL2CAPChannelExecutor = AsyncSerialExecutor<Void>()
}
