//
//  AssetAllocation.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 24/10/2021.
//

import Foundation

public struct AssetAllocation {
    public let name: String
    public let allocation: Percentage
    public let returnRate: Percentage

    public init(name: String, allocation: Percentage, returnRate: Percentage) {
        self.name = name
        self.allocation = allocation
        self.returnRate = returnRate
    }
}

extension AssetAllocation: Codable, Hashable {}

extension Array where Element == AssetAllocation {

    public var averageReturnRate: Percentage {
        var returnRate = 0.0
        forEach { asset in
            returnRate += (asset.allocation.decimal * asset.returnRate.decimal)
        }

        return Percentage(decimal: returnRate)
    }
}
