//  ViewController.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//


import UIKit
import Combine

final class NewsViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, News>
    
    private lazy var collectionView = makeCollectionView()
    private lazy var activityIndicator = makeActivityIndicator()
    
    private var dataSource: DataSource?
    private let viewModel = NewsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation(title: "Новости")
        configureViews()
        configureDataSource()
        bindViewModel()

        viewModel.loadNextPage()
    }
    
    private func bindViewModel() {
        viewModel.$news
            .receive(on: RunLoop.main)
            .sink { [weak self] news in
                guard let self = self else { return }
                if !news.isEmpty {
                    self.activityIndicator.stopAnimating()
                    self.collectionView.isHidden = false
                }
                self.applySnapshot(with: news)
            }
            .store(in: &cancellables)
        
        viewModel.$selectedNews
            .compactMap { $0?.fullUrl }
            .sink { [weak self] url in self?.openWeb(url) }
            .store(in: &cancellables)
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
        var snapshot = NSDiffableDataSourceSnapshot<Int, News>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func configureViews() {
        activityIndicator.startAnimating()
        collectionView.isHidden = true
        
        view.addSubview(collectionView)
        collectionView.pinToEdges(of: view, top: view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(activityIndicator)
        activityIndicator.pinToCenter(of: view)
      
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
