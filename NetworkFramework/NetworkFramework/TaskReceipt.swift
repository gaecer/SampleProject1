//
//  TaskReceipt.swift
//  NetworkFramework
//
//  Created by gaetano cerniglia on 21/12/2020.
//

import Foundation

/// Class to generate and cancel the task
class TaskReceipt: Cancellable {

    private let task: URLSessionDataTask?

    init(task: URLSessionDataTask?) {
        self.task = task
    }

    func cancel() {
        task?.cancel()
    }
}
