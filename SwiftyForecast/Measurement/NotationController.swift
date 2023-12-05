import Foundation

final class NotationController {
    var measurementSystem: MeasurementSystem {
        get {
            loadMeasurementSystem()
        }

        set(newValue) {
            saveMeasurementSystem(newValue)
        }
    }

    var temperatureNotation: TemperatureNotation {
        get {
            loadTemperatureNotation()
        }

        set(newValue) {
            saveTemperatureNotation(newValue)
        }
    }

    private enum Constant {
        static let measurementSystem = "MeasurementSystemKey"
        static let temperatureUnit = "TemperatureUnitKey"
    }

    private let storage: UserDefaults

    init(storage: UserDefaults = .standard) {
        self.storage = storage
    }

    private func loadMeasurementSystem() -> MeasurementSystem {
        let storedValue = storage.integer(forKey: Constant.measurementSystem)
        return MeasurementSystem(rawValue: storedValue) ?? .imperial
    }

    private func saveMeasurementSystem(_ value: MeasurementSystem) {
        storage.set(value.rawValue, forKey: Constant.measurementSystem)
    }

    private func loadTemperatureNotation() -> TemperatureNotation {
        let storedValue = storage.integer(forKey: Constant.temperatureUnit)
        return TemperatureNotation(rawValue: storedValue) ?? .fahrenheit
    }

    private func saveTemperatureNotation(_ value: TemperatureNotation) {
        storage.set(value.rawValue, forKey: Constant.temperatureUnit)
    }
}
