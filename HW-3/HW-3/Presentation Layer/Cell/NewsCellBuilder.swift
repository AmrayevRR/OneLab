//
//  NewsCellBuilder.swift
//  HW-3
//
//  Created by Ramir Amrayev on 4/27/22.
//

import Foundation

class NewsCellBuilder: CellBuilder {
    
    var configurableCells: [CellConfigurator] = []
    
    @discardableResult
    func setNewsCell(with new: New) -> Self {
        configurableCells.append(NewsCellConfigurator(item: new))
        return self
    }
    
    @discardableResult
    func buildCells(with news: [New]) -> Self {
        for new in news {
            setNewsCell(with: new)
        }
        return self
    }
}
