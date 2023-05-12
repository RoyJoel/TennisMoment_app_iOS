//
//  testData.swift
//  TennisMoment
//
//  Created by Jason Zhang on 2023/3/2.
//

import Foundation
import SwiftyJSON
import UIKit

// let club: Club = Club(id: 1, icon: "JasonZhang", name: "TennisMoment", intro: "Tennis Moment is world NO.2 Tennis Association", owner: Player(json: JSON()), address: "Germany", events: [event, event, event])
// let event: Event = Event(id: 0, icon: "JasonZhang", name: "TM250", startDate: Date().timeIntervalSince1970, endDate: Date().timeIntervalSince1970 + 100_000_000, level: .TM250, draw: [Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())), Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON()))], schedule: [[game, game, game]])
// let game = Game(id: 0, date: Date().timeIntervalSince1970, place: "", surface: .hard, setNum: 3, gameNum: 6, round: 2, isGoldenGoal: false, isPlayer1Serving: true, isPlayer1Left: true, isChangePosition: true, isCompleted: false, player1: Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())), player1Stats: Stats(json: JSON()), player2: Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())), player2Stats: Stats(json: JSON()), isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[0, 0]]])
// let clubs = [club, club, club, club, club, club]
// let players: [Player] = [
//    Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())),
//    Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())),
//    Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())),
//    Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())),
//    Player(id: 0, loginName: "jasony", name: "Nick Kyrgios", icon: "NickKyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStats: Stats(json: JSON())),
// ]
//
// let games: [Game] = [Game(date: Date().timeIntervalSince1970, place: "西安邮", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: true, isPlayer1Serving: true, isPlayer1Left: true, isChangePosition: true, isCompleted: true, player1LoginName: "jason1", player1StatsId: 72, player2LoginName: "jasony", player2StatsId: 73, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[5, 3], [5, 1], [5, 0], [5, 3], [3, 5], [5, 1], [5, 1]], [[5, 1], [2, 5]]]), Game(date: Date().timeIntervalSince1970, place: "西安邮", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: true, isPlayer1Serving: true, isPlayer1Left: true, isChangePosition: true, isCompleted: true, player1LoginName: "jason1", player1StatsId: 72, player2LoginName: "jasony", player2StatsId: 73, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[5, 3], [5, 1], [5, 0], [5, 3], [3, 5], [5, 1], [5, 1]], [[5, 1], [2, 5]]]), Game(date: Date().timeIntervalSince1970, place: "西安邮", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: true, isPlayer1Serving: true, isPlayer1Left: true, isChangePosition: true, isCompleted: true, player1LoginName: "jason1", player1StatsId: 72, player2LoginName: "jasony", player2StatsId: 73, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[5, 3], [5, 1], [5, 0], [5, 3], [3, 5], [5, 1], [5, 1]], [[5, 1], [2, 5]]])]

// let stats: [Stats] = [Stats(id: 1, aces: 1, doubleFaults: 2, servePoints: 3, firstServePoints: 4, firstServePointsIn: 6, firstServePointsWon: 7, secondServePointsWon: 8, breakPointsFaced: 5, breakPointsSaved: 2, serveGamesPlayed: 3, serveGamesWon: 4, returnAces: 6, returnServePoints: 8, firstServeReturnPoints: 3, firstServeReturnPointsWon: 5, secondServeReturnPointsWon: 7, breakPointsOpportunities: 6, breakPointsConverted: 0, returnGamesPlayed: 7, returnGamesWon: 5, netPoints: 1, unforcedErrors: 8, forehandWinners: 8, backhandWinners: 6),
//                      Stats(id: 2, aces: 3, doubleFaults: 4, servePoints: 5, firstServePoints: 5, firstServePointsIn: 9, firstServePointsWon: 2, secondServePointsWon: 1, breakPointsFaced: 7, breakPointsSaved: 7, serveGamesPlayed: 3, serveGamesWon: 3, returnAces: 4, returnServePoints: 6, firstServeReturnPoints: 4, firstServeReturnPointsWon: 6, secondServeReturnPointsWon: 3, breakPointsOpportunities: 8, breakPointsConverted: 8, returnGamesPlayed: 5, returnGamesWon: 8, netPoints: 1, unforcedErrors: 1, forehandWinners: 7, backhandWinners: 6), Stats(id: 1, aces: 1, doubleFaults: 2, servePoints: 3, firstServePoints: 4, firstServePointsIn: 6, firstServePointsWon: 7, secondServePointsWon: 8, breakPointsFaced: 5, breakPointsSaved: 2, serveGamesPlayed: 3, serveGamesWon: 4, returnAces: 6, returnServePoints: 8, firstServeReturnPoints: 3, firstServeReturnPointsWon: 5, secondServeReturnPointsWon: 7, breakPointsOpportunities: 6, breakPointsConverted: 0, returnGamesPlayed: 7, returnGamesWon: 5, netPoints: 1, unforcedErrors: 8, forehandWinners: 8, backhandWinners: 6),
//                      Stats(id: 2, aces: 3, doubleFaults: 4, servePoints: 5, firstServePoints: 5, firstServePointsIn: 9, firstServePointsWon: 2, secondServePointsWon: 1, breakPointsFaced: 7, breakPointsSaved: 7, serveGamesPlayed: 3, serveGamesWon: 3, returnAces: 4, returnServePoints: 6, firstServeReturnPoints: 4, firstServeReturnPointsWon: 6, secondServeReturnPointsWon: 3, breakPointsOpportunities: 8, breakPointsConverted: 8, returnGamesPlayed: 5, returnGamesWon: 8, netPoints: 1, unforcedErrors: 1, forehandWinners: 7, backhandWinners: 6), Stats(id: 1, aces: 1, doubleFaults: 2, servePoints: 3, firstServePoints: 4, firstServePointsIn: 6, firstServePointsWon: 7, secondServePointsWon: 8, breakPointsFaced: 5, breakPointsSaved: 2, serveGamesPlayed: 3, serveGamesWon: 4, returnAces: 6, returnServePoints: 8, firstServeReturnPoints: 3, firstServeReturnPointsWon: 5, secondServeReturnPointsWon: 7, breakPointsOpportunities: 6, breakPointsConverted: 0, returnGamesPlayed: 7, returnGamesWon: 5, netPoints: 1, unforcedErrors: 8, forehandWinners: 8, backhandWinners: 6),
//                      Stats(id: 2, aces: 3, doubleFaults: 4, servePoints: 5, firstServePoints: 5, firstServePointsIn: 9, firstServePointsWon: 2, secondServePointsWon: 1, breakPointsFaced: 7, breakPointsSaved: 7, serveGamesPlayed: 3, serveGamesWon: 3, returnAces: 4, returnServePoints: 6, firstServeReturnPoints: 4, firstServeReturnPointsWon: 6, secondServeReturnPointsWon: 3, breakPointsOpportunities: 8, breakPointsConverted: 8, returnGamesPlayed: 5, returnGamesWon: 8, netPoints: 1, unforcedErrors: 1, forehandWinners: 7, backhandWinners: 6)]

// func test() {
//    TMGameRequest.searchAllGames(for: "p") { games in
//        print(games)
//    }
//    let game3 = Game(date: Date().timeIntervalSince1970, place: "西安邮", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: true, isPlayer1Serving: true, isCompleted: true, player1LoginName: "jason1", player1StatsId: 72, player2LoginName: "jasony", player2StatsId: 73, isPlayer1FirstServe: true, isPlayer2FirstServe: true, result: [[[5, 3], [5, 1], [5, 0], [5, 3], [3, 5], [5, 1], [5, 1]], [[5, 1], [2, 5]]])
//    let player5 = Player(loginName: "jasony", name: "Nick Kyrgios", icon: "Nick Kyrgios", sex: .Man, age: 21, yearsPlayed: 1, height: 10_000_000, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStatsId: 1, friends: "p")
//    TMPlayerRequest.addPlayer(player: player5) { player in
//        print(player)
//    }
//    TMGameRequest.addGame(game: game3) { result in
//        print(result)
//    }
//    let stats = Stats(id: 78, aces: 2, doubleFaults: 3, firstServePoints: 4, firstServePointsIn: 5, firstServePointsWon: 2, secondServePoints: 3, secondServePointsWon: 4, breakPointsFaced: 5, breakPointsSaved: 2, serveGamesPlayed: 3, serveGamesWon: 4, totalServePointsWon: 5, firstServeReturnPoints: 2, firstServeReturnAces: 3, firstServeReturnPointsWon: 4, secondServeReturnPoints: 5, secondServeReturnAces: 6, secondServeReturnPointsWon: 2, breakPointsOpportunities: 3, breakPointsConverted: 4, returnGamesPlayed: 5, returnGamesWon: 6, totalReturnPointsWon: 2, totalPointsWon: 3, netPoints: 4, unforcedErrors: 2, forehandWinners: 2, backhandWinners: 2)
//    TMStatsRequest.updateStats(stats: stats) { stats in
//        print(stats)
//
//        TMStatsRequest.searchStats(id: 78) { stats in
//            print(stats)
//        }
//    }
//    print(Date().timeIntervalSince1970)
//
//    let game1 = Game(date: Date().timeIntervalSince1970, place: "西安邮电大学雁塔校区", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: false, isCompleted: false, player1LoginName: "jason", player1StatsId: 0, player2LoginName: "p", player2StatsId: 1, result: [[2, 3], [3, 2]])
//    TMGameRequest.addGame(game: game1) { res in
//        print(res)
//    }
//    //        let relationship = Relationship(loginName: "p", friendLoginName: "TennisMoment")
//    let game2 = Game(date: Date().timeIntervalSince1970, place: "西安邮电大学雁塔校区", surface: .clay, setNum: 3, gameNum: 6, isGoldenGoal: true, isCompleted: true, player1LoginName: "p", player1StatsId: 0, player2LoginName: "jason", player2StatsId: 1, result: [[2, 3], [3, 2]])
//    let player1 = Player(loginName: "zhangjiacheng", name: "Jason Zhang", icon: "Jason Zhang", sex: .Man, age: 21, yearsPlayed: 1, height: 1, width: 1, grip: .Western, backhand: .TwoHandedBackhand, points: 1000, isAdult: true, careerStatsId: 1, friends: "p")
//    TMGameRequest.searchAllGames(for: "p") { games in
//        print(games)
//    }
//    TMGameRequest.saveGame(game: game2)
//
//    User.signUp(with: player5)
//    User.signUp(with: player2)
//    toastView.setup(toastView.bounds, toastView.layer.position, CGRect(x: 100, y: 100, width: UIStandard.shared.screenWidth * 0.4, height: 100), CGPoint(x: 125 + (UIStandard.shared.screenWidth * 0.4 - 50) / 2, y: 150), 0.3)
//    toastView.scaleTo(toastView.toggle)
//
//    let toastView = GameConfigToastView()
//    toastView.backgroundColor = .blue
//    toastView.setupUI()
//    view.showToast(toastView, position: .center)
//    let o = URL(string: "/player/getAll")
//    let a = TMNetWork.get("/player/getAll") { json, _ in
//        json?["data"].arrayValue.map { json in
//            print(Player(json: json))
//        }
//    }
//    let a = AF.request(o!).response { response in
//        print(Player(json: JSON(response.data)))
//    }
//    let player = Player(id: 1, loginName: "", name: "", icon: UIImage(systemName: "person")!, sex: .Man, age: 1, yearsPlayed: 1, height: 1, width: 1, grip: .Continented, backhand: .TwoHandedBackhand, points: 1, isAdult: false, careerStats: Stats(json: JSON()), friends: [], gamesPlayed: [])
//    print(player.toJSON())
// }

let com1 = Commodity(id: 0, images: ["Aus", "JasonZhang", "Aus", "JasonZhang", "Aus"], name: "DUNLOP邓禄普澳网AO官方比赛网球", intro: "澳大利亚网球公开赛官方指定用球 \n Wilson 公司全力打造的比赛用球！为大满贯比赛严格要求而设计的独特的网球,有OPTI-VIS增强视觉效果处理,更加清晰可见,更添专业品质。\n 具有Nano Play纳米科技，耐打性佳、弹性好，外表增添了加亮材料，大大增加了比赛或训练中捕球的机会性、可视性。", price: 123, limit: 9, orders: 2, cag: 1)

let com2 = Commodity(id: 0, images: ["Wim"], name: "Slazenger史莱辛格网球 温网比赛官方用球", intro: "澳大利亚网球公开赛官方指定用球；Wilson 公司全力打造的比赛用球！为大满贯比赛严格要求而设计的独特的网球,有OPTI-VIS增强视觉效果处理,更加清晰可见,更添专业品质。具有Nano Play纳米科技，耐打性佳、弹性好，外表增添了加亮材料，大大增加了比赛或训练中捕球的机会性、可视性。", price: 123, limit: 1, orders: 2, cag: 2)

let com: [Commodity] = [com1, com2]

let bill1 = Bill(id: 1, com: com1, quantity: 2, cag: 0)
let bill2 = Bill(id: 2, com: com2, quantity: 3, cag: 0)
let address1 = Address(id: 1, name: "张嘉诚", sex: .Man, phoneNumber: "18840250882", province: "陕西省", city: "西安市", area: "灞桥区", detailedAddress: "西安邮电大学雁塔校区")
let address2 = Address(id: 1, name: "李思齐", sex: .Man, phoneNumber: "18700350775", province: "北京市", city: "北京市", area: "顺义区", detailedAddress: "港鑫家园")
let address3 = Address(id: 1, name: "张嘉诚", sex: .Man, phoneNumber: "18840250882", province: "陕西省", city: "西安市", area: "新城区", detailedAddress: "西安邮电大学雁塔校区")
var addresss = [address1, address2, address3]

let order: Order = Order(id: 1, bills: [bill1, bill2, bill2], shippingAddress: address1, deliveryAddress: address1, payment: .WeChat, totalPrice: 984.00, createdTime: 1_682_329_527, payedTime: 1_682_415_927, completedTime: 1_682_588_727, state: .Done)

let order1: Order = Order(id: 1, bills: [bill1, bill2, bill2], shippingAddress: address1, deliveryAddress: address1, payment: .WeChat, totalPrice: 984.00, createdTime: 1_682_329_527, payedTime: nil, completedTime: nil, state: .ToPay)

let ordersa: [Order] = [order, order, order1]
