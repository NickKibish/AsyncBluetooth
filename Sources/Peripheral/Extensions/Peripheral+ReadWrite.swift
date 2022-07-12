//  Copyright (c) 2021 Manuel Fernandez-Peix Perez. All rights reserved.

import Foundation
import CoreBluetoothMock

extension Peripheral {
    /// Reads and parses the value of a characteristic with a given identifier, of a service with a
    /// given identifier.
    /// - Note: If the service or characteristic has not been discovered, it will attempt to discover it.
    public func readValue<Value>(
        forCharacteristicWithUUID characteristicUUID: UUID,
        ofServiceWithUUID serviceUUID: UUID
    ) async throws -> Value? where Value: PeripheralDataConvertible {
        guard let characteristic = try await self.findCharacteristic(
            uuid: characteristicUUID,
            ofServiceWithUUID: serviceUUID
        ) else {
            throw BluetoothError.characteristicNotFound
        }
        
        try await self.readValue(for: characteristic)
        
        guard let data = characteristic.value else {
            return nil
        }
        
        guard let value = Value.fromData(data) else {
            throw BluetoothError.unableToParseCharacteristicValue
        }
        
        return value
    }
    
    /// Writes and parses the value of a characteristic with a given identifier, of a service with a
    /// given identifier.
    /// - Note: If the service or characteristic has not been discovered, it will attempt to discover it.
    public func writeValue<Value>(
        _ value: Value,
        forCharacteristicWithUUID characteristicUUID: UUID,
        ofServiceWithUUID serviceUUID: UUID,
        type: CBMCharacteristicWriteType = .withResponse
    ) async throws where Value: PeripheralDataConvertible {
        guard let characteristic = try await self.findCharacteristic(
            uuid: characteristicUUID,
            ofServiceWithUUID: serviceUUID
        ) else {
            throw BluetoothError.characteristicNotFound
        }

        guard let data = value.toData() else {
            throw BluetoothError.unableToConvertValueToData
        }
        
        try await self.writeValue(data, for: characteristic, type: type)
    }
    
    private func findCharacteristic(
        uuid characteristicUUID: UUID,
        ofServiceWithUUID serviceUUID: UUID
    ) async throws -> CBMCharacteristic? {
        guard let service = try await self.findService(uuid: serviceUUID) else {
            return nil
        }
        
        let characteristicCBUUID = CBMUUID(nsuuid: characteristicUUID)
        let discoveredCharacteristic: () -> CBMCharacteristic? = {
            service.characteristics?.first(where: { $0.uuid == characteristicCBUUID })
        }
        
        if let characteristic = discoveredCharacteristic() {
            return characteristic
        }
        
        try await self.discoverCharacteristics([characteristicCBUUID], for: service)
        
        return discoveredCharacteristic()
    }
    
    private func findService(uuid: UUID) async throws -> CBMService? {
        let cbUUID = CBMUUID(nsuuid: uuid)
        let discoveredService: () -> CBMService? = {
            self.cbPeripheral.services?.first(where: { $0.uuid == cbUUID })
        }
        
        if let service = discoveredService() {
            return service
        }
        
        try await self.discoverServices([cbUUID])
        
        return discoveredService()
    }
}
