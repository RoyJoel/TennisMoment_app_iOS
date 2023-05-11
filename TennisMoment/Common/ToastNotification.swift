//
//  ToastNotification.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/2/24.
//

import Foundation
import UIKit

enum ToastNotification: String {
    case DataFreshToast
    case HomeViewToast
    case AddGameToast
    case ContinueGameToast
    case DataSavingToast

    /// 通知名称
    var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue)
    }
}
