//
//  FeedViewController.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 15.11.2022.
//

import UIKit

final class FeedViewController: UIViewController {
    
    //MARK: - UI Elements -
    
    private var tableView   : UITableView!
    private var loader      : UIActivityIndicatorView!
    private var reloadButton: UIButton!
    
    //MARK: - Constraints -
    
    private var reloadButtonTopConstraint: NSLayoutConstraint!
    
    //MARK: - Fields -
    
    private var characterList: [RMCharacter] = []
    private let characterService: RMCharacterServiceProtocol
    
    init() {
        characterService = RMCharacterService()
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Lifecycle -

extension FeedViewController {
    override func loadView() {
        view = UIView()
        tableView = UITableView()
        view.addSubview(tableView)
        
        configureTableView()
        configureLoader()
        configureReloadButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        setLoader(forState: .on)
        fetchCharacters()
    }
}

//MARK: - Objective-C Methods -

extension FeedViewController {
    @objc
    private func handleReloadButtonTap() {
        UIView.animate(withDuration: 0.3) {
            self.setReloadButton(forState: .off)
            self.setLoader(forState: .on)
        }
    }
}

//MARK: - Private Helpers -

extension FeedViewController {
    private func fetchCharacters() {
        Task {
            do {
                characterList = try await characterService.fetchCharacters()
                DispatchQueue.main.async {
                    if self.characterList.isEmpty {
                        self.updateUI(forLoadedState: .zeroData)
                    } else {
                        self.updateUI(forLoadedState: .successfullyLoaded)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.updateUI(forLoadedState: .failed)
                }
            }
        }
    }
}

//MARK: - UI Update -

extension FeedViewController {
    private func updateUI(forLoadedState state: LoadedState) {
        if state == .successfullyLoaded {
            tableView.alpha = 1
            tableView.reloadData()
            setLoader(forState: .off)
            return
        }
        
        let description = state == .failed ? "Failed to fetch characters" : "No data to display"
        let title = description + ".\n" + "Tap to reload"
        reloadButton.setTitle(title, for: .normal)
        tableView.alpha = 0
        setReloadButton(forState: .on)
        setLoader(forState: .off)
    }
    
    private func setLoader(forState state: SwitchState) {
        switch state {
        case .on:
            UIView.animate(withDuration: 0.3) {
                self.loader.startAnimating()
                self.loader.alpha = 1
            }
        case .off:
            UIView.animate(withDuration: 0.3) {
                self.loader.alpha = 0
                self.loader.stopAnimating()
            }
        }
    }
    
    private func setReloadButton(forState state: SwitchState) {
        switch state {
        case .on:
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseOut) {
                    self.reloadButtonTopConstraint.constant = Paddings.reloadButtonVisibleTop
                    self.reloadButton.alpha = 1
                    self.view.layoutIfNeeded()
                }
        case .off:
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: .curveEaseIn) {
                    self.reloadButton.alpha = 0
                    self.reloadButtonTopConstraint.constant = Paddings.reloadButtonHiddenTop
                    self.view.layoutIfNeeded()
                }
        }
    }
}

//MARK: - UITableView DataSource -

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RMCharacterCell.identifier) as! RMCharacterCell
        cell.setCharacter(characterList[indexPath.row])
        return cell
    }
}

//MARK: - UITableView Delegate -

extension FeedViewController: UITableViewDelegate {
    
}

//MARK: - UI Configuration -

extension FeedViewController {
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RMCharacterCell.self, forCellReuseIdentifier: RMCharacterCell.identifier)
        tableView.rowHeight = Sizes.rowHeight
    }
    
    private func configureLoader() {
        loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: Sizes.loaderSize),
            loader.heightAnchor.constraint(equalToConstant: Sizes.loaderSize)
        ])
    }
    
    private func configureReloadButton() {
        reloadButton = UIButton()
        reloadButton.titleLabel?.numberOfLines = 2
        reloadButton.titleLabel?.font = .italicSystemFont(ofSize: 18)
        reloadButton.titleLabel?.textAlignment = .center
        reloadButton.setTitleColor(.gray, for: .normal)
        reloadButton.setTitleColor(.lightGray, for: .highlighted)
        reloadButton.addTarget(self, action: #selector(handleReloadButtonTap), for: .touchUpInside)
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButtonTopConstraint = reloadButton.topAnchor.constraint(equalTo: tableView.topAnchor, constant: Paddings.reloadButtonHiddenTop)
        view.addSubview(reloadButton)
        NSLayoutConstraint.activate([
            reloadButtonTopConstraint,
            reloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Paddings.horizontal),
            reloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Paddings.horizontal)
        ])
    }
}

//MARK: - Constants -

extension FeedViewController {
    
    private enum Sizes {
        
        /// 70
        static let rowHeight  : CGFloat = 150
        
        /// 40
        static let loaderSize : CGFloat = 40
    }
    
    private enum Paddings {
        
        /// 70
        static let reloadButtonVisibleTop: CGFloat = 200
        
        /// 50
        static let reloadButtonHiddenTop : CGFloat = 130
        
        /// 40
        static let horizontal            : CGFloat = 40
    }
}
