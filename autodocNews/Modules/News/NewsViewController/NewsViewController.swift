//  ViewController.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//


import UIKit
import Combine

final class NewsViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, News>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, News>
    
    private lazy var collectionView = makeCollectionView()
    private var dataSource: DataSource?
    
    private let viewModel = NewsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(title: "Новости")
        configureConstraints()
        configureDataSource()
        bindViewModel()
        viewModel.loadNextPage()
    }
    
    private func bindViewModel() {
        viewModel.$news
            .receive(on: RunLoop.main)
            .sink { [weak self] news in
                self?.applySnapshot(with: news)
            }
            .store(in: &cancellables)
        
        viewModel.$selectedNews
            .compactMap { $0?.fullUrl }
            .sink { [weak self] url in self?.openWeb(url) }
            .store(in: &cancellables)
    }
}

extension NewsViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 2 {
            viewModel.loadNextPage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectNews(at: indexPath.item)
    }
}

private extension NewsViewController {
    func configureDataSource() {
        dataSource = collectionView.makeDiffableDataSource { collectionView, indexPath, news in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsCell
            cell.configure(item: news)
            return cell
        }
    }
    
    func applySnapshot(with items: [News]) {
        collectionView.applySnapshot(items, dataSource: dataSource)
    }
    
    func configureConstraints() {
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view, top: view.safeAreaLayoutGuide.topAnchor)
    }
}

