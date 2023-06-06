//
//  TMUserOrdersViewController.swift
//  TMMS
//
//  Created by Jason Zhang on 2023/4/29.
//
import Foundation
import JXSegmentedView
import TMComponent

class TMUserOrdersViewController: UIViewController {
    let allOrdersDS = ordersDataSource()
    let ordersToPayDS = ordersDataSource()
    let ordersToDeliveryDS = ordersDataSource()
    let ordersToConfirmDS = ordersDataSource()
    let ordersCompletedDS = ordersDataSource()
    let ordersToRefundDS = ordersDataSource()
    let ordersOnReturningDS = ordersDataSource()
    let ordersReturnedDS = ordersDataSource()

    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        JXSegmentedListContainerView(dataSource: self)
    }()

    lazy var allOrderTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    lazy var ordersToPayTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    lazy var ordersToDeliveryTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    lazy var ordersToConfirmTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    lazy var ordersCompletedTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    lazy var ordersToRefundTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    lazy var ordersOnReturningTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    lazy var ordersReturnedTableView: TMUserOrderTableView = {
        let tableView = TMUserOrderTableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "订单中心"
        view.backgroundColor = UIColor(named: "BackgroundGray")
        let titles = ["全部订单"] + OrderState.allCases.compactMap { $0.displayName }

        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleNormalColor = UIColor(named: "ContentBackground") ?? .black
        dataSource.titleSelectedColor = .black
        dataSource.titles = titles
        segmentedDataSource = dataSource
        // 配置指示器
        let indicator = JXSegmentedIndicatorBackgroundView()
        indicator.indicatorHeight = 30
        indicator.indicatorColor = UIColor(named: "TennisBlur") ?? .blue
        segmentedView.indicators = [indicator]

        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = listContainerView

        view.addSubview(segmentedView)
        view.addSubview(listContainerView)

        segmentedView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(103)
        }
        listContainerView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        allOrderTableView.delegate = allOrdersDS
        allOrderTableView.dataSource = allOrdersDS
        allOrderTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "allOrders")
        ordersToPayTableView.delegate = ordersToPayDS
        ordersToPayTableView.dataSource = ordersToPayDS
        ordersToPayTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "ordersToPay")

        ordersToDeliveryTableView.delegate = ordersToDeliveryDS
        ordersToDeliveryTableView.dataSource = ordersToDeliveryDS
        ordersToDeliveryTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "ordersToDelivery")
        ordersToConfirmTableView.delegate = ordersToConfirmDS
        ordersToConfirmTableView.dataSource = ordersToConfirmDS
        ordersToConfirmTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "ordersToConfirm")
        ordersCompletedTableView.delegate = ordersCompletedDS
        ordersCompletedTableView.dataSource = ordersCompletedDS
        ordersCompletedTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "ordersCompleted")
        ordersToRefundTableView.delegate = ordersToRefundDS
        ordersToRefundTableView.dataSource = ordersToRefundDS
        ordersToRefundTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "ordersToRefund")
        ordersOnReturningTableView.delegate = ordersOnReturningDS
        ordersOnReturningTableView.dataSource = ordersOnReturningDS
        ordersOnReturningTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "ordersOnReturning")
        ordersReturnedTableView.delegate = ordersReturnedDS
        ordersReturnedTableView.dataSource = ordersReturnedDS
        ordersReturnedTableView.register(TMUserOrderCell.self, forCellReuseIdentifier: "ordersReturned")
        refreshData()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshOrderData), name: Notification.Name(ToastNotification.refreshOrderData.rawValue), object: nil)
    }

    func refreshData() {
        TMOrderRequest.getInfos(id: TMUser.user.id) { orders in
            let filterOrders = orders.filter { $0.id != TMUser.user.cart }
            self.allOrdersDS.orders = filterOrders
            self.allOrderTableView.reloadData()
            self.ordersToPayDS.orders = filterOrders.filter { $0.state == .ToPay }
            self.ordersToPayTableView.reloadData()
            self.ordersToDeliveryDS.orders = filterOrders.filter { $0.state == .ToSend }
            self.ordersToDeliveryTableView.reloadData()
            self.ordersToConfirmDS.orders = filterOrders.filter { $0.state == .ToDelivery }
            self.ordersToConfirmTableView.reloadData()
            self.ordersCompletedDS.orders = filterOrders.filter { $0.state == .Done }
            self.ordersCompletedTableView.reloadData()
            self.ordersToRefundDS.orders = filterOrders.filter { $0.state == .ToRefund }
            self.ordersToRefundTableView.reloadData()
            self.ordersOnReturningDS.orders = filterOrders.filter { $0.state == .ToReturn }
            self.ordersOnReturningTableView.reloadData()
            self.ordersReturnedDS.orders = filterOrders.filter { $0.state == .Refunded }
            self.ordersReturnedTableView.reloadData()
        }
    }

    @objc func refreshOrderData() {
        refreshData()
    }
}

class ordersDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var orders: [Order] = []
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        orders.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TMUserOrderCell()
        cell.setupEvent(order: orders[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TMOrderDetailViewController()
        vc.order = orders[indexPath.row]
        vc.completionHandler = { order in
            self.orders[indexPath.row] = order
            tableView.reloadData()
        }
        vc.deleteCompletionHandler = {
            self.orders.remove(at: indexPath.row)
            tableView.reloadData()
        }
        if let parentVC = tableView.getParentViewController() {
            parentVC.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        188
    }
}

extension TMUserOrdersViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in _: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_: JXSegmentedListContainerView, initListAt: Int) -> JXSegmentedListContainerViewListDelegate {
        switch initListAt {
        case 0:
            allOrderTableView.reloadData()
            return allOrderTableView
        case 1:
            ordersToPayTableView.reloadData()
            return ordersToPayTableView
        case 2:
            ordersToDeliveryTableView.reloadData()
            return ordersToDeliveryTableView
        case 3:
            ordersToConfirmTableView.reloadData()
            return ordersToConfirmTableView
        case 4:
            ordersCompletedTableView.reloadData()
            return ordersCompletedTableView
        case 5:
            ordersToRefundTableView.reloadData()
            return ordersToRefundTableView
        case 6:
            ordersOnReturningTableView.reloadData()
            return ordersOnReturningTableView
        default:
            ordersReturnedTableView.reloadData()
            return ordersReturnedTableView
        }
    }
}

extension TMUserOrdersViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            // 先更新数据源的数据

            dotDataSource.dotStates[index] = false
            // 再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
    }

    func segmentedView(_: JXSegmentedView, didScrollSelectedItemAt _: Int) {}
}
