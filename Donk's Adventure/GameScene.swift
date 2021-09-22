//
//  GameScene.swift
//  Donk's Adventure
//
//  Created by Zakee Tanksley on 9/21/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //Nodes
    var character: SKNode?
    var joyStick: SKNode?
    var joyStickKnob: SKNode?
    
    //non action
    var joyStickAction = false
    
    //Measurement
    var knobRadius: CGFloat = 50.0
    
    //did move
    override func didMove(to view: SKView) {
        
        character = childNode(withName: "Character")
        joyStick = childNode(withName: "joyStick")
        joyStickKnob = joyStick?.childNode(withName: "joyStickKnob")
    }
}
// MARK: User Touch
extension GameScene {
    //User initial touch begins
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let joyStickKnob = joyStickKnob {
                let location = touch.location(in: joyStick!)
                joyStickAction = joyStickKnob.frame.contains(location)
            }
        }
    }
    //User touch Movement
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let joyStick = joyStick else { return }
        guard let joyStickKnob = joyStickKnob else { return }
        
        if !joyStickAction { return }
        
        //Distance of movement
        for touch in touches {
            
            let position  = touch.location(in: joyStick)
            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
            let angle = atan2(position.y, position.x)
            
            if knobRadius > length {
                joyStickKnob.position = position
            } else {
                joyStickKnob.position = CGPoint(x: cos(angle) * knobRadius, y: sin(angle) * knobRadius)
            }
        }
    }
    //User deinitiates touch
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let xjoyStickCoord = touch.location(in: joyStick!).x
            let xlimit: CGFloat = 200.0
            if xjoyStickCoord > -xlimit && xjoyStickCoord < xlimit {
                
            }
        }
    }
}

// MARK: Action

extension GameScene {
    func knobPositionReset() {
        let initialPosition = CGPoint (x: 0,y: 0)
        let moveBack = SKAction.move(to: initialPosition, duration: 0.1)
        moveBack.timingMode = .linear
        joyStickKnob?.run(moveBack)
        joyStickAction = false
    }
}


