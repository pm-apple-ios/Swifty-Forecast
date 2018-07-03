//
//  HourForecastView.swift
//  Swifty Forecast
//
//  Created by Pawel Milek on 03/10/16.
//  Copyright © 2016 Pawel Milek. All rights reserved.
//

import UIKit
import Cartography
import WeatherIconsKit


class HourForecastView: UIView, CustomViewLayoutSetupable, ViewSetupable {
    private let iconLabel = UILabel()
    private let dateLabel = UILabel()
    private let temperaturesLabel = UILabel()
    private let descriptionLabel = UILabel()
    var isConstraints = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        self.setupStyle()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - Update Constraints
extension HourForecastView {
    
    override func updateConstraints() {
        if self.isConstraints {
            super.updateConstraints()
            return
        }
        
        self.setupLayout()
        
        super.updateConstraints()
        self.isConstraints = true
    }
}


// MARK: - CustomViewLayoutSetupable
extension HourForecastView {
    
    func setupLayout() {
        let mergin: CGFloat = 8
        
        func setViewConstrain() {
            constrain(self) { view in
                view.height == 60
                return
            }
        }
    }
    
}


// MARK: - CustomViewSetupable
extension HourForecastView {
    
    func setup() {
        
    }
    
    func setupStyle() {
        func setBorders() {
            let width: CGFloat = 1
            let borderColor = UIColor.blue.cgColor
            
            self.layer.borderWidth = width
            self.layer.borderColor = borderColor
        }
        
        
        setBorders()
    }
    
    
    func renderView(weather: HourlyForecast) {
    }
    
    func render() {
        
    }
    
}
