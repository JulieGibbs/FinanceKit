//
//  FinanceKit
//  Copyright © 2021 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

// swiftlint:disable:this file_name
//
//  Numerics+Total+Average.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 11/02/2020.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

extension Collection where Element: Numeric {

    /// Returns the total sum of all elements in the array
    public var total: Element {
        reduce(0, +)
    }
}

extension Collection where Element: BinaryInteger {

    /// Returns the average of all elements in the array
    public var average: Double {
        isEmpty ? 0 : Double(total) / Double(count)
    }
}

extension Collection where Element: BinaryFloatingPoint {

    /// Returns the average of all elements in the array
    public var average: Element {
        isEmpty ? 0 : total / Element(count)
    }
}

extension Collection where Element == Decimal {

    /// Returns the average of all elements in the array
    public var average: Decimal {
        isEmpty ? 0 : total / Decimal(count)
    }
}
