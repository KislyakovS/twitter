//
//  ActionSheetLauncher.swift
//  Twitter
//
//  Created by Александр Кисляков on 22.03.2021.
//

import UIKit

protocol ActionSheetLauncherDelegate: class {
    func didSelect(option: ActionSheetOptions)
}

class ActionSheetLauncher: NSObject {
    
    // MARK: - Properties
    
    private let user: User
    private let tableView = UITableView()
    private var window: UIWindow?
    private lazy var viewModel = ActionSheetViewModel(user: user)
    weak var delegate: ActionSheetLauncherDelegate?
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDismissal))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(didTapDismissal), for: .touchUpInside)
        return button
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        
        view.addSubview(cancelButton)
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.anchor(left: view.leftAnchor, right: view.rightAnchor,
                            paddingLeft: 12, paddingRight: 12)
        cancelButton.centerY(inView: view)
        cancelButton.layer.cornerRadius = 50 / 2
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init()
        
        configureTableView()
    }
    
    // MARK: - Did
    
    @objc private func didTapDismissal() {
        hidden()
    }
    
    // MARK: - Helpers
    
    private func hidden() {
        let heightTable = CGFloat(viewModel.options.count * 60) + 100
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y += heightTable
        }
    }
    
    func show() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.window = window
        
        window.addSubview(blackView)
        blackView.frame = window.bounds
        
        window.addSubview(tableView)
        let heightTable = CGFloat(viewModel.options.count * 60) + 100
        tableView.frame = CGRect(x: 0, y: window.frame.height,
                                 width: window.frame.width, height: heightTable)
        
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 1
            self.tableView.frame.origin.y -= heightTable
        }
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = false
        
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: ActionSheetCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ActionSheetLauncher: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActionSheetCell.identifier, for: indexPath) as! ActionSheetCell
        cell.option = viewModel.options[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ActionSheetLauncher: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hidden()
        delegate?.didSelect(option: viewModel.options[indexPath.row])
    }
}
