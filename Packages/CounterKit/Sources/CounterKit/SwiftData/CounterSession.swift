//
//  CounterSession.swift
//  CounterKit
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import Foundation
import SwiftData

/// Defines a model for a counter session.
@Model
final public class CounterSession: Identifiable {
    /// Unique identifier for each counter session.
    public var id: UUID = UUID()
    /// Title of the counter session.
    public var title: String = ""
    /// Creation date of the session.
    public private(set) var createdAt: Date = Date()
    /// An array of Dates representing 'hits' or interactions with the counter.
    public private(set) var hits: [Date] = []
    /// Target value for hits, nil if it's open target.
    public var target: Int? = 100

    /// Inverse relationship to Counter. Links each session to its parent counter.
    @Relationship(inverse: \Counter.sessions) public private(set) var counter: Counter?

    /// Computed property to get the count of hits.
    public var count: Int {
        hits.count
    }
    
    public var isOpenTarget: Bool {
        target.isNil
    }
    
    /// Check if the session has reached its target
    /// Note: If target is nil, it's open-ended, so it never "reaches" the target
    public var hasReachedTarget: Bool {
        guard let target = target else {
            // If target is nil, it's open-ended, so it never "reaches" the target
            return false
        }
        return hits.count >= target
    }
    
    /// Initializes a new CounterSession with specified parameters.
    /// - Parameters:
    ///   - id: A unique identifier for the session. Defaults to a new UUID if not provided.
    ///   - title: The title of the session.
    ///   - createdAt: The creation date of the session. Defaults to the current date and time.
    ///   - hits: An array of dates representing interactions with the counter. Defaults to an empty array.
    ///   - target: The target number of hits for the session.
    public init(id: UUID = UUID(), title: String = "", createdAt: Date = Date.now, hits: [Date] = [], target: Int? = 100) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.hits = hits
        self.target = target
    }

    /// Adds a hit to the session.
    /// - Parameter hitDate: The date of the hit. Defaults to the current date and time.
    public func addHit(on hitDate: Date = .now) {
        hits.append(hitDate)
    }

    /// Removes the most recent hit from the session.
    /// - Returns: The last element of the hits if the hits array is not empty; otherwise, nil.
    @discardableResult
    public func removeLastHit() -> Date? {
        hits.popLast()
    }

    /// Calculates the progress towards the target as a percentage, if it's an open target, it will return nil.
    /// - Returns: The progress as a percentage.
    public var progressPercentage: Double? {
        guard let target = target else {
            return nil
        }
        let progress = Double(count) / Double(target)
        return progress * 100
    }

    /// Function to reset the session by clearing hits and setting target to 0.
    public func reset() {
        target = 0
        hits = []
    }
}

