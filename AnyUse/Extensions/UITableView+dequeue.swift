//
//  UITableView+dequeue.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit.UITableView

public extension UITableView {

    /// Стандартный метод реюза ячеек для коллекции + автоматически регистрирует ячейку.
    ///
    /// - Parameters:
    ///   - cellType: Тип ячейки, которую нужно переиспользовать. Идентификатор ячейки должен сопадать с названием класса.
    ///   - indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
    /// - Returns: Реюзнутая ячейка.
    func dequeue<CellType: UITableViewCell>(_ cellType: CellType.Type, at indexPath: IndexPath) -> CellType {
        let identifier = "\(cellType)"

        if !registeredCells.contains(identifier) {
            register(cellType, by: identifier, isCellClass: true)
        }

        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CellType
    }

    /// Стандартный метод реюза хедера/футера для коллекции + автоматически регистрирует хедер/футер.
    ///
    /// - Parameters:
    ///   - type: Тип хедера или футера, который нужно переиспользовать. Идентификатор хедера/футера должен сопадать с названием класса.
    ///   - indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
    /// - Returns: Реюзнутая ячейка.
    func dequeue<HeaderType: UITableViewHeaderFooterView>(_ type: HeaderType.Type) -> HeaderType {
        let identifier = "\(type)"

        if !registeredCells.contains(identifier) {
            register(type, by: identifier, isCellClass: false)
        }

        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! HeaderType
    }

    private func register(_ type: UIView.Type, by identifier: String, isCellClass: Bool) {
        let shouldRegisterNib: Bool = Bundle.allXibsFilesNames.contains(where: { $0 == identifier })
        registeredCells.append(identifier)

        guard shouldRegisterNib else {
            isCellClass ? register(type, forCellReuseIdentifier: identifier) : register(type, forHeaderFooterViewReuseIdentifier: identifier)
            return
        }

        let nib = UINib(type)
        isCellClass ? register(nib, forCellReuseIdentifier: identifier) : register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

// MARK: - Rigester cells

private var key = "UITableView_registeredCells"

private extension UITableView {

    /// Массив идентификаторов зарегистрированных ячеек.
    var registeredCells: [String] {
        get {
            return objc_getAssociatedObject(self, &key) as? [String] ?? []
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
