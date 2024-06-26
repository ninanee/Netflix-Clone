//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Yun Ni on 2024-06-07.
//

import UIKit

enum Section: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMove: Title?
    
    private var headerView: HeroHeaderUIView?

    let sectionTitles:[String] = ["Trending Movies", "Trending Tv", "Popular",  "Upcoming Movies", "Top Rated"]
    
    // dynamic define
    private let homeFeedTable: UITableView = {
        //frame: .zero, style: .grouped for the cell's header
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.indeitifer)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.dataSource = self
        homeFeedTable.delegate = self
        
        configureNavBar()
//        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

//
//        fetchData()
        
//        APICaller.shared.getMovie(with: "Harry potter") { result in
//            //
//        }
//    
        
//        navigationController?.pushViewController(TitlePreviewViewController(), animated: true)
        configureHeroHeaderView()
        
        
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let titles):
                
                let selectedTitle = titles.randomElement()
                
                self.randomTrendingMove = selectedTitle
                
                
                self.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "NetflixLogo")

        //always keep the image as its original
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        
        ]
        
        navigationController?.navigationBar.tintColor = .white
        
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
//    private func fetchData() {
//        APICaller.shared.getTopRated { _ in
//            
////            switch results {
////                
////            case .success(let movies):
////                print(movies)
////                
////            case .failure(let error):
////                print(error)
//            }
//        }
//        
////        APICaller.shared.getTrendingTvs { results in
////            
////            switch results {
////                
////            case .success(let movies):
////                print(movies)
////                
////            case .failure(let error):
////                print(error)
////            }
////        }
//    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.indeitifer, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
            
        case Section.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Section.TrendingTV.rawValue:
            APICaller.shared.getTrendingTvs{ result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Section.Popular.rawValue:
            
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Section.Upcoming.rawValue:
            
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Section.TopRated.rawValue:
            
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        // header could have 20 margin to the left
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
//        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
    
    // scroll up ,the nav bar gonna dissapper
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
                    
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
   
    }
    
}
