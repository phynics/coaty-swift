//  Copyright (c) 2019 Siemens AG. Licensed under the MIT License.
//
//  IoPoint.swift
//  CoatySwift
//
//

import Foundation

 /// Defines meta information of an IO point.
 ///
 /// This base object has no associated framework base object type.
 /// For instantiation use one of the concrete subtypes `IoSource` or `IoActor`.
 open class IoPoint: CoatyObject {

     // MARK: - Attributes.

    /// The update rate (in milliseconds) for publishing IoValue events:
    /// * desired rate for IO actors
    /// * maximum possible drain rate for IO sources
    ///
    /// The IO router specifies the recommended update rate in Associate event data.
    /// If undefined, there is no limit on the rate of published events.
    public var updateRate: Double?

    /// A communication topic used for routing values from external sources to
    /// internal IO actors or from internal IO sources to external sinks (optional).
    /// Used only for predefined external topics that are not generated by the IO router
    /// dynamically, but defined by an external (i.e. non-Coaty) component instead.
    public var externalTopic: String?
    
    // MARK: - Initializers.
    
    /// Default initializer for an`IoPoint` object.
    init(coreType: CoreType,
         objectType: String,
         objectId: CoatyUUID,
         name: String,
         updateRate: Double? = nil,
         externalTopic: String? = nil) {
        self.updateRate = updateRate
        self.externalTopic = externalTopic
        super.init(coreType: coreType, objectType: objectType, objectId: objectId, name: name)
    }
    
    // MARK: - Codable methods.

    enum IoPointKeys: String, CodingKey, CaseIterable {
        case updateRate
        case externalTopic
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: IoPointKeys.self)
        self.updateRate = try container.decodeIfPresent(Double.self, forKey: .updateRate)
        self.externalTopic = try container.decodeIfPresent(String.self, forKey: .externalTopic)
        
        CoatyObject.addCoreTypeKeys(decoder: decoder, coreTypeKeys: IoPointKeys.self)
        try super.init(from: decoder)
    }
    
    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: IoPointKeys.self)
        try container.encodeIfPresent(updateRate, forKey: .updateRate)
        try container.encodeIfPresent(externalTopic, forKey: .externalTopic)
    }
}
