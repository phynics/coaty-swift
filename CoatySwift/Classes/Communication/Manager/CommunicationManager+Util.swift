//
//  Communication+Util.swift
//  CoatySwift
//

import Foundation

extension CommunicationManager {
    
    func convertToTupleFormat(rawMessage: (String, String)) throws -> (Topic, String) {
        let (topic, payload) = rawMessage
        return try (Topic(topic), payload)
    }
    
    func isAdvertise(rawMessage: (Topic, String)) -> Bool {
        let (topic, _) = rawMessage
        return topic.eventType == CommunicationEventType.Advertise
    }
    
    func isResolve(rawMessage: (Topic, String)) -> Bool {
        let (topic, _) = rawMessage
        return topic.eventType == CommunicationEventType.Resolve
    }
    
    func isUpdate(rawMessage: (Topic, String)) -> Bool {
        let (topic, _) = rawMessage
        return topic.eventType == CommunicationEventType.Update
    }
    
    func isComplete(rawMessage: (Topic, String)) -> Bool {
        let (topic, _) = rawMessage
        return topic.eventType == CommunicationEventType.Complete
    }
    
    func isChannel(rawMessageWithTopic: (Topic, String)) -> Bool {
        let (topic, _) = rawMessageWithTopic
        return topic.eventType == .Channel
    }
}
