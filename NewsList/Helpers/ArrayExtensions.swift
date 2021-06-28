//
//  ArrayExtensions.swift
//  NewsList
//
//  Created by Maxim Osyagin on 27.06.2021.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
