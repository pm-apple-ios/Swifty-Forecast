//
//  Registrable.swift
//  DVBChart
//
//  Created by Pawel Milek on 26/09/16.
//  Copyright © 2016 Pawel Milek. All rights reserved.
//

import UIKit


protocol Registrable: class {}


extension Registrable where Self: UITableView {
    func register<T: UITableViewCell>(cellClass: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName:  T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
}
