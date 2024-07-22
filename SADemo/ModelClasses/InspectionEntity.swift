//
//  InspectionEntity.swift
//  SADemo
//
//  Created by Rahul Gupta on 18/07/24.
//

import Foundation
import CoreData

struct Response: Codable {
    let inspection: InspectionSA
}

struct InspectionSA: Codable {
    let id: Int16
    let inspectionType: InspectionTypeSA
    let area: AreaSA
    let survey: SurveySA
}

struct AnswerChoiceSA: Codable {
    let id: Int16
    let name: String
    let score: Double
}

struct QuestionSA: Codable {
    let answerChoices: [AnswerChoiceSA]
    let id: Int16
    let name: String
    let selectedAnswerChoiceId: Int?
}

struct CategorySA: Codable {
    let id: Int16
    let name: String
    let questions: [QuestionSA]
}

struct InspectionTypeSA: Codable {
    let access: String
    let id: Int16
    let name: String
}

struct AreaSA: Codable {
    let id: Int16
    let name: String
}

struct SurveySA: Codable {
    let id: Int16
    let categories: [CategorySA]
}

