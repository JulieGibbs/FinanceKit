//
//  FinanceKit
//  Copyright © 2022 Christian Mitteldorf. All rights reserved.
//  MIT license, see LICENSE file for details.
//

import Foundation

public struct Exchange: Codable, Equatable {

    public let symbol: String
    public let name: String

    public init(symbol: String, name: String) {
        self.symbol = symbol
        self.name = name
    }
}
