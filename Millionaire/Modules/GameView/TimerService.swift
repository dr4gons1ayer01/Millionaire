//
//  TimerService.swift
//  Millionaire
//
//  Created by artyom s on 23.07.2025.
//

import Foundation


final class TimerService {
    private var timer: Timer?
    private(set) var counter: Int = 0
    private let interval: TimeInterval
    private let onTick: (Int) -> Void

    init(interval: TimeInterval = 1.0, onTick: @escaping (Int) -> Void) {
        self.interval = interval
        self.onTick = onTick
    }

    func start() {
        stop() // in case already running
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.counter += 1
            self.onTick(self.counter)
        }
        RunLoop.current.add(timer!, forMode: .common)
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    deinit {
        stop()
    }
}
