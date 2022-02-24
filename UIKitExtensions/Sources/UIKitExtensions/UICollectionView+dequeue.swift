//
//  UICollectionView+dequeue.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import UIKit.UICollectionView

/// Тип `SupplementaryView` для коллекции в более типизированном варианте.
public enum CollectionSupplementaryViewKind: RawRepresentable {

    // MARK: - Cases

    /// Тип хедера секции для нативного `UICollectionViewFlowLayout`.
    case header
    /// Тип футера секции для нативного `UICollectionViewFlowLayout`.
    case footer
    /// Любой другой тип (Название типа).
    case custom(String)

    // MARK: - Initializers

    public init(rawValue: String) {
        switch rawValue {
        case UICollectionView.elementKindSectionHeader: self = .header
        case UICollectionView.elementKindSectionFooter: self = .footer
        default: self = .custom(rawValue)
        }
    }

    // MARK: - Properties

    public var rawValue: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        case .custom(let kind): return kind
        }
    }
}

public extension UICollectionView {

    /// Стандартный метод реюза ячеек для коллекции + автоматически регистрирует ячейку.
    ///
    /// - Parameters:
    ///   - itemType: Тип ячейки, которую нужно переиспользовать. Идентификатор ячейки должен сопадать с названием класса.
    ///   - supplementaryViewKind: Тип `SupplementaryView` для коллекции в более типизированном варианте. Если не передать, будет зарегистрирована ячейка. По дефолту == `nil`.
    ///   - indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
    /// - Returns: Реюзнутая ячейка.
    func dequeue<T: UICollectionViewCell>(_ itemType: T.Type, supplementaryViewKind: CollectionSupplementaryViewKind? = nil, at indexPath: IndexPath) -> T {
        let identifier: String = "\(itemType)"

        if !registeredCells.contains(identifier) {
            register(itemType, of: supplementaryViewKind, by: identifier)
        }

        let cell: T = supplementaryViewKind == nil ? dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T :
            dequeueReusableSupplementaryView(ofKind: supplementaryViewKind!.rawValue, withReuseIdentifier: identifier, for: indexPath) as! T
        return cell
    }

    private func register(_ itemType: UICollectionViewCell.Type, of supplementaryViewKind: CollectionSupplementaryViewKind?, by identifier: String) {
        let shouldRegisterNib: Bool = Bundle.allXibsFilesNames.contains(where: { $0 == identifier })
        registeredCells.append(identifier)

        guard shouldRegisterNib else {
            supplementaryViewKind == nil ? register(itemType, forCellWithReuseIdentifier: identifier) : register(itemType, forSupplementaryViewOfKind: supplementaryViewKind!.rawValue, withReuseIdentifier: identifier)
            return
        }

        let nib = UINib(itemType)
        supplementaryViewKind == nil ? register(nib, forCellWithReuseIdentifier: identifier) : register(nib, forSupplementaryViewOfKind: supplementaryViewKind!.rawValue, withReuseIdentifier: identifier)
    }
}

// MARK: - Rigester cells

private var key = "UICollectionView_registeredCells"

fileprivate extension UICollectionView {

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
