//
//  NewsListView.swift
//  NewsList
//
//  Created by Maxim Osyagin on 19.06.2021.
//

import Foundation

protocol NewsListView: AnyObject {
    var viewModel: NewsResponse? { get set }
}
