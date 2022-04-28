//
//  CellBuilder.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/27/22.
//

import Foundation

protocol CellBuilder {
    var configurableCells: [CellConfigurator] {
        get set
    }
    
    mutating func reset() -> Self
    
    func getConfigurableCells() -> [CellConfigurator]
}

extension CellBuilder {
    mutating func reset() -> Self {
        configurableCells = []
        return self
    }
    
    func getConfigurableCells() -> [CellConfigurator] {
        return configurableCells
    }
}
