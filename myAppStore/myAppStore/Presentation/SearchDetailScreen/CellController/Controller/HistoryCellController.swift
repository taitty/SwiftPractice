//
//  HistoryCellController.swift
//  myAppStore
//
//  Created by 김희수 on 2022/03/20.
//

import UIKit

class HistoryCellController: GenericCellController<HistoryCell> {
    
    private var cellHeight = 170.0 {
        didSet {
            delegate.updateTable()
        }
    }
    private var prevValue = 0.0

    private func convertDate(updated: String) -> Int {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let date = Date()
        let nowDateStr = formatter.string(from: date)
        let nowDate = formatter.date(from: nowDateStr)
        let inputDate = formatter.date(from: updated)
        let diffBetweenDates = nowDate!.timeIntervalSince(inputDate!)
        let diffDate = diffBetweenDates / 3600 / 24
        return Int(diffDate)
    }
    
    override func configureCellContent(_ cell: HistoryCell, data: SearchModel?) {
        if let date = data?.updateDate {
            let diff = convertDate(updated: date)
            cell.updateTime.text = (diff == 0) ? "오늘" : "\(diff) 일전"
        }
        cell.version.text = data?.version
        cell.history.text = data?.history
        cell.expandedHeight.signal.observeValues { value in
            if value == self.prevValue { return }
            self.prevValue = value
            self.cellHeight += value
        }
    }
    
    override func getCellHeight() -> CGFloat {
        return cellHeight
    }

}
