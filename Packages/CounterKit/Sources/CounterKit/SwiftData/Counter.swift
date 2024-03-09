//
//  Counter.swift
//  CounterKit
//
//  Created by Abdullah Alhaider on 09/03/2024.
//

import Foundation
import SwiftData
import Helper4Swift
import SwiftUI

/// Defines a model for a counter object.
@Model
final public class Counter: Identifiable {
    /// Unique identifier for each counter instance.
    public private(set) var id: UUID = UUID()
    /// Name of the counter.
    public var name: String = ""
    /// Description for the counter.
    public var desc: String = ""
    /// Color of the counter, stored as a hexadecimal string.
    public var color: String = Color.accentColor.toHexString() ?? "#000000"
    /// Indicates whether the counter is marked as a favorite.
    public var isFavorite: Bool = false
    /// Creation date of the counter.
    public private(set) var createdAt: Date = Date()
    /// An optional array of CounterSession objects. The cascade delete rule implies that deleting a Counter will delete its sessions.
    @Relationship(deleteRule: .cascade) public private(set) var sessions: [CounterSession]?

    /// Initializes a new Counter with specified parameters.
    /// - Parameters:
    ///   - id: A unique identifier for the counter. Defaults to a new UUID if not provided.
    ///   - name: The name of the counter.
    ///   - color: The color of the counter, represented as a hexadecimal string.
    ///   - createdAt: The creation date of the counter. Defaults to the current date and time.
    ///   - sessions: An array of associated CounterSession objects. Defaults to an empty array.
    public init(
        id: UUID = UUID(),
        name: String,
        desc: String = "",
        color: String,
        isFavorite: Bool = false,
        createdAt: Date = Date.now,
        sessions: [CounterSession]
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.color = color
        self.isFavorite = isFavorite
        self.createdAt = createdAt
        self.sessions = sessions
    }

    /// Adds a new session to the counter.
    /// - Parameter session: The CounterSession to be added.
    public func addSession(_ session: CounterSession) {
        if sessions == nil {
            sessions = []
        }
        sessions?.append(session)
    }

    /// Removes a session from the counter.
    /// - Parameter sessionId: The UUID of the session to be removed.
    public func removeSession(withId sessionId: UUID) {
        sessions?.removeAll { $0.id == sessionId }
    }

    /// Finds a session by its ID.
    /// - Parameter sessionId: The UUID of the session.
    /// - Returns: The found CounterSession or nil if not found.
    public func findSession(withId sessionId: UUID) -> CounterSession? {
        return sessions?.first { $0.id == sessionId }
    }
}
