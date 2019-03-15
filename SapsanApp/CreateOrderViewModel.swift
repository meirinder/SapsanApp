//
//  CreateOrderViewModel.swift
//  SapsanApp
//
//  Created by Savely on 13/03/2019.
//  Copyright © 2019 Sapsan. All rights reserved.
//

import UIKit

class CreateOrderViewModel {
    
    var layout: CreationOrderData?{
        didSet {
            parseViewModels()
        }
    }
    
    var viewModels = [[CreateOrderCellViewModel]]()

    private func parseViewModels() {
        if let lay = layout?.creationLayout {
            if let blocks = lay.blocks {
                for i in 0..<blocks.count {
                    var secVM = [CreateOrderCellViewModel]()
                    let block = blocks[i]
                    if let rows = block.rows {
                        for row in rows {
                            let vm = CreateOrderCellViewModel(row: row)
                            secVM.append(vm)
                        }
                    }
                    viewModels.append(secVM)
                }
            }
        }
    }
    
    func viewModel(section: Int, index: Int) -> CreateOrderCellViewModel {
        return viewModels[section][index]
    }
    
    func cellType(section: Int, index: Int) -> String {
        return layout?.creationLayout?.blocks?[section].rows?[index].type ?? "errorType"
    }
    
    func sectionCount() -> Int {
        return layout?.creationLayout?.blocks?.count ?? 0
    }
    
    func cellCount(section: Int) -> Int {
        return layout?.creationLayout?.blocks?[section].rows?.count ?? 0
    }
    
    func getLayout() {
        if let path = Bundle.main.path(forResource: "CreateOrder", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                layout = JSONWorker.parseCreationLayout(data: data)
            } catch {
                // handle error
            }
        }
        
    }
    
    
    
}
