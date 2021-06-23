//
//  RegisterCellsExtensions.swift
//  NewsList
//
//  Created by Maxim Osyagin on 20.06.2021.
//

import UIKit

extension UITableView {
    func register(cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.classId())
    }

    func register(cells: [UITableViewCell.Type]) {
        cells.forEach { register(cell: $0) }
    }

    func register(headerFooter: UITableViewHeaderFooterView.Type) {
        register(headerFooter, forHeaderFooterViewReuseIdentifier: headerFooter.classId())
    }

    func register(headerFooters: [UITableViewHeaderFooterView.Type]) {
        headerFooters.forEach { register(headerFooter: $0) }
    }

    func dequeueReusable<Cell>(cell: Cell.Type) -> Cell? where Cell: UITableViewCell {
        return dequeueReusableCell(withIdentifier: cell.classId()) as? Cell
    }

    func dequeueReusable<Cell>(cell: Cell.Type, indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        return dequeueReusableCell(withIdentifier: cell.classId(), for: indexPath) as! Cell
    }

    func dequeueReusable<HeaderFooter>(headerFooter: HeaderFooter.Type) -> HeaderFooter where HeaderFooter: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: headerFooter.classId()) as! HeaderFooter
    }
}

extension UICollectionView {
    func register(cell: UICollectionViewCell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.classId())
    }

    func register(cells: [UICollectionViewCell.Type]) {
        cells.forEach { register(cell: $0) }
    }

    func register(headerFooter: UICollectionReusableView.Type, kinde: String) {
        register(headerFooter, forSupplementaryViewOfKind: kinde, withReuseIdentifier: headerFooter.classId())
    }

    func dequeueReusableSuplementary<HeaderFooter>(headerFooter: HeaderFooter.Type, kinde: String, indexPath: IndexPath) -> HeaderFooter where HeaderFooter: UICollectionReusableView {
        return dequeueReusableSupplementaryView(ofKind: kinde, withReuseIdentifier: headerFooter.classId(), for: indexPath) as! HeaderFooter
    }

    func dequeueReusable<Cell>(cell: Cell.Type, indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: cell.classId(), for: indexPath) as! Cell
    }
}

extension NSObject {
    static func classId() -> String {
        return String(describing: self)
    }
}
