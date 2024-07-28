//
//  DashboardViewModel.swift
//  SADemo
//
//  Created by Rahul Gupta on 20/07/24.
//

import Foundation
import CoreData
import UIKit

class DashboardViewModel: NSObject {
    var onSuccess: (() -> Void)?
    var commonSuccess: ((String) -> Void)?
    var onSubmitSuccess: (() -> Void)?
    var onGetRandomInpectionSuccess: (() -> Void)?
    var onFailure: ((Error) -> Void)?
    var inspection: [InspectionResponse] = []

    func startInspection() {
        APIService.startInspectionApi{ result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.handleSuccess(inspectionData: data)
                }
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }

    func submitInspection() {
        let inspection = InspectionResponse(inspection: InspectionSA(id: 11,
                                                           inspectionType: InspectionTypeSA(access: "write", id: 2, name: "Clinical"),
                                                           area: AreaSA(id: 5, name: "Emergency ICU Test"),
                                                           survey: SurveySA(id: 4,
                                                                            categories: [CategorySA(id: 2, name: "CategorySA1", 
                                                                                                    questions: [
                                                                                                        QuestionSA(answerChoices: [AnswerChoiceSA(id: 5, name: "AnswerChoiceSA", score: 1.0)],
                                                                                                                           id: 5, name: "qwert", selectedAnswerChoiceId: 5)])])))

        APIService.submitInspectionApi(inspection: inspection) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.commonSuccess?("Inspection submitted successfully!!")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.handleError(error: error)
                }
            }
        }
    }

    func generateRandomInspections() {
        APIService.generateRandomInspectionApi{ result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.commonSuccess?("10 Inspections generated successfully!!")
                }
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }

    func handleSuccess(inspectionData: InspectionResponse) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        saveDataInDB(inspectionData.inspection, in: appDel.persistentContainer.viewContext)
    }

    func handleError(error: Error) {
        DispatchQueue.main.async {
            self.onFailure?(error)
        }
    }

    func saveDataInDB(_ dto: InspectionSA, in context: NSManagedObjectContext)  {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.persistentContainer.performBackgroundTask { bgContext in
            let inspection = Inspection(context: bgContext)
            inspection.id = dto.id

            let inspectionType = InspectionType(context: bgContext)
            inspectionType.access = dto.inspectionType.access
            inspectionType.id = dto.inspectionType.id
            inspectionType.name = dto.inspectionType.name
            inspection.inspectionType = inspectionType

            let area = Area(context: bgContext)
            area.id = dto.area.id
            area.name = dto.area.name
            inspection.area = area

            let survey = Survey(context: bgContext)
            survey.id = dto.survey.id ?? 0

            for category in dto.survey.categories {
                let categoryL = Category(context: bgContext)
                categoryL.id = category.id ?? 0
                categoryL.name = category.name

                for questionO in category.questions {
                    let quest = Question(context: bgContext)
                    quest.id = questionO.id
                    quest.name = questionO.name
                    quest.selectedAnswerChoiceId =  4 //questionO.selectedAnswerChoiceId

                    for answer in questionO.answerChoices {
                        let ans = AnswerChoice(context: bgContext)
                        ans.id = answer.id
                        ans.name = answer.name
                        ans.score = answer.score
                        quest.answerChoices?.adding(ans)
                    }
                    categoryL.questions?.adding(quest)
                }
                categoryL.survey = survey
            }
            inspection.survey = survey

            do {
               try bgContext.save()
                self.onSuccess?()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func getRandomInspection() {
        APIService.getRandomInspectionApi { result in
            switch result {
            case .success(let response):
                self.inspection.append(response)
                self.onGetRandomInpectionSuccess?()
                break
            case .failure(let error):
                self.handleError(error: error)
                break
            }
        }
    }

    func getInspection(id: Int) {
        APIService.getInspectionApi(id: id) { result in
            switch result {
            case .success(let response):
                self.inspection.append(response)
                self.onGetRandomInpectionSuccess?()
                break
            case .failure(let error):
                self.handleError(error: error)
                break
            }
        }
    }

    func deleteInspection(id: Int) {
        APIService.deleteInspectionApi(id: id) { result in
            switch result {
            case .success:
                self.commonSuccess?("Inspection deleted successfully!!")
                self.inspection = []
                self.onGetRandomInpectionSuccess?()
                break
            case .failure(let error):
                self.handleError(error: error)
                break
            }
        }
    }
}
