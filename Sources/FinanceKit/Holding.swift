//
//  Holding.swift
//  FinanceKit
//
//  Created by Christian Mitteldorf on 28/10/2019.
//  Copyright © 2020 Mitteldorf. All rights reserved.
//

import Foundation

public struct Holding: Identifiable, Hashable, Codable {

    /// A unique identifier that identifies this holding.
    public var id = UUID()

    public let symbol: Symbol

    public internal(set) var stock: Stock?
    public internal(set) var company: Company?

    public internal(set) var quantity: Quantity {
        didSet {
            quantity = max(quantity, 0)
        }
    }

    /// The total cost basis for all transactions.
    /// Dividends and buybacks are not subtracted into this calculation.
    /// It is therefore the plain purchase price divided by the number of shares.
    /// See `adjustedCostBasis` to include dividends.
    /// Commissions are included in this cost.
    public internal(set) var costBasis: Price {
        didSet {
            costBasis = max(costBasis, 0)
        }
    }

    public internal(set) var costBasisInLocalCurrency: Price {
        didSet {
            costBasisInLocalCurrency = max(costBasisInLocalCurrency, 0)
        }
    }

    public var adjustedCostBasis: Price {
        guard isActive else { return 0 }
        return costBasis - accumulatedDividends
    }

    /// The average purchase price per share.
    public var averageCostPerShare: Price {
        guard isActive else { return 0 }
        return costBasis / Decimal(quantity)
    }

    public var averageAdjustedCostPerShare: Price {
        guard isActive else { return 0 }
        return adjustedCostBasis / Decimal(quantity)
    }

    @available(*, deprecated, renamed: "averageAdjustedCostPerShare")
    public var averageAdjustedCostBasisPerShare: Price {
        averageAdjustedCostPerShare
    }

    public internal(set) var accumulatedDividends: Amount = 0

    public internal(set) var commissionPaid: Price = 0

    public var displayName: String {
        company?.name ?? symbol.rawValue
    }

    public internal(set) var transactions: [Transaction] = []

    public internal(set) var currentValue: Price
    public internal(set) var currentValueInLocalCurrency: Price

    public var change: Change {
        Change(cost: costBasis, currentValue: currentValue)
    }

    public var changeInLocalCurrency: Change {
        Change(cost: costBasisInLocalCurrency, currentValue: currentValueInLocalCurrency)
    }

    /// Returns the ownership in terms of percentage of the total amount of oustanding shares.
    public var ownership: Percentage {
        guard let outstandingShares = stock?.shares, outstandingShares > 0 else { return .zero }
        return Percentage(Double(quantity) / Double(outstandingShares))
    }

    internal var isActive: Bool {
        quantity > 0
    }

    public init(symbol: Symbol, quantity: Quantity = 0, costBasis: Price = 0,
                costBasisInLocalCurrency: Price = 0, currentValue: Price = 0,
                currentValueInLocalCurrency: Price = 0) {
        self.symbol = symbol
        self.quantity = max(quantity, 0)
        self.costBasis = max(costBasis, 0)
        self.costBasisInLocalCurrency = max(costBasisInLocalCurrency, 0)
        self.currentValue = currentValue
        self.currentValueInLocalCurrency = currentValueInLocalCurrency
    }

    public static func makeHoldings(with transactions: [Transaction]) -> [Holding] {
        guard !transactions.isEmpty else {
            return []
        }

        // Sort transactions by date to be sure they are
        // processed in the right historical order.
        let sortedTransactions = transactions.sorted()

        var holdings: [Holding] = []
        sortedTransactions.forEach { transaction in
            let quantity = transaction.quantity
            let price = transaction.price
            let costBasis = price * Decimal(quantity) + transaction.commission

            // If a holding already exists for this symbol, update quantity and cost basis.
            // Otherwise add a new holding to the array
            if var holding = holdings.contains(symbol: transaction.symbol) {
                holding.commissionPaid += transaction.commission

                switch transaction.type {
                case .buy:
                    holding.quantity += quantity
                    holding.costBasis += costBasis
                case .sell:
                    holding.quantity -= quantity
                    holding.costBasis -= costBasis
                case .dividend:
                    holding.accumulatedDividends += Decimal(transaction.quantity) * transaction.price
                }

                // Remove previous and re-add newly calculated holding
                holdings.removeAll { $0.symbol == transaction.symbol }
                holdings.append(holding)
            } else {
                var holding = Holding(symbol: transaction.symbol)
                holding.commissionPaid += transaction.commission

                switch transaction.type {
                case .buy:
                    holding.quantity += quantity
                    holding.costBasis += costBasis
                case .sell:
                    break
                case .dividend:
                    holding.accumulatedDividends = Decimal(transaction.quantity) * transaction.price
                }

                holdings.append(holding)
            }
        }

        return holdings.active
    }

    /// Updates the holding with the current price of the specified stock.
    /// Also updates the `company` to reflect the stock.
    ///
    /// This function is useful for updating the holding with the result of a query
    /// from a Stock API, without you having to calculate this yourself.
    ///
    /// - Parameter stock: A stock containing the most recent price, and company details.
    ///   The symbol must match the holding.
    /// - Returns: The newly updated holding.
    public func update(with updatedStock: Stock) -> Holding {
        guard updatedStock.symbol == symbol else { return self }

        var newHolding = Holding(
            symbol: symbol,
            quantity: quantity,
            costBasis: costBasis,
            costBasisInLocalCurrency: costBasisInLocalCurrency,
            currentValue: updatedStock.price * Decimal(quantity),
            currentValueInLocalCurrency: currentValueInLocalCurrency
        )
        newHolding.stock = updatedStock
        newHolding.company = updatedStock.company

        return newHolding
    }

    /// Updates the holdings current value and cost basis in local currencies,
    /// using the companys currency as the base currency.
    /// - Parameter currencyPairs: The current rates to convert the currency with.
    /// - Parameter baseCurrency: The local currency to convert any other values into.
    /// - Returns: If the holdings company has a currency, and a matching currency pair,
    /// it returns the converted holding, otherwise it returns a holding where the local values
    /// is equal to the base values.
    public func update(with currencyPairs: [CurrencyPair], to baseCurrency: Currency) -> Holding {
        guard let companyCurrency = company?.currency else { return self }

        var updatedCurrencyValue = currentValue
        var updatedCostBasis = costBasis

        if companyCurrency != baseCurrency {
            if let pair = currencyPairs.first(where: { $0.baseCurrency == baseCurrency && $0.secondaryCurrency == companyCurrency }) {
                updatedCurrencyValue = currentValue / Decimal(pair.rate)
                updatedCostBasis = costBasis / Decimal(pair.rate)
            }
        }

        var newHolding = Holding(
            symbol: symbol,
            quantity: quantity,
            costBasis: costBasis,
            costBasisInLocalCurrency: updatedCostBasis,
            currentValue: currentValue,
            currentValueInLocalCurrency: updatedCurrencyValue
        )
        newHolding.stock = stock
        newHolding.company = company

        return newHolding
    }
}

extension Holding: Comparable {

    public static func < (lhs: Holding, rhs: Holding) -> Bool {
        lhs.displayName < rhs.displayName
    }
}

extension Holding: Equatable {

    public static func == (lhs: Holding, rhs: Holding) -> Bool {
        lhs.id == rhs.id &&
        lhs.symbol == rhs.symbol &&
        lhs.stock == rhs.stock &&
        lhs.company == rhs.company &&
        lhs.currentValue == rhs.currentValue &&
        lhs.currentValueInLocalCurrency == rhs.currentValueInLocalCurrency &&
        lhs.change == rhs.change &&
        lhs.changeInLocalCurrency == rhs.changeInLocalCurrency
    }
}

extension Array where Element == Holding {

    public var active: [Holding] {
        filter { $0.isActive }
    }

    public func contains(symbol: Symbol) -> Holding? {
        first { $0.symbol == symbol }
    }
}
