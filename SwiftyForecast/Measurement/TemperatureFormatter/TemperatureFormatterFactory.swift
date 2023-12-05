//
//  TemperatureFormatterFactory.swift
//  SwiftyForecast
//
//  Created by Pawel Milek on 10/16/23.
//  Copyright © 2023 Pawel Milek. All rights reserved.
//

import Foundation

protocol TemperatureFormatterFactoryProtocol {
    func make(
        by notation: TemperatureNotation,
        valueInKelvin current: Double
    ) -> TemperatureValueDisplayable

    func make(
        by notation: TemperatureNotation,
        valueInKelvin: TemperatureValue
    ) -> TemperatureValueDisplayable
}

struct TemperatureFormatterFactory: TemperatureFormatterFactoryProtocol {

    func make(
        by notation: TemperatureNotation,
        valueInKelvin current: Double
    ) -> TemperatureValueDisplayable {
        let value = TemperatureValue(current: current, max: .signalingNaN, min: .signalingNaN)
        return make(by: notation, valueInKelvin: value)
    }

    func make(
        by notation: TemperatureNotation,
        valueInKelvin: TemperatureValue
    ) -> TemperatureValueDisplayable {
        switch notation {
        case .celsius:
            return TemperatureCelsiusFormatter(
                currentInKelvin: valueInKelvin.current,
                maxInKelvin: valueInKelvin.max,
                minInKelvin: valueInKelvin.min
            )

        case .fahrenheit:
            return TemperatureFahrenheitFormatter(
                currentInKelvin: valueInKelvin.current,
                maxInKelvin: valueInKelvin.max,
                minInKelvin: valueInKelvin.min
            )
        }
    }
}
