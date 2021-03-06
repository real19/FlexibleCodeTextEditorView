//
//  Code.swift
//  Test
//
//  Created by Suleman Imdad on 5/26/18.
//  Copyright © 2018 CodingAssignment. All rights reserved.
//

let codeString =  """
let labelNode = SKLabelNode(text: "SpriteKit")
labelNode.fontColor = UIColor.blue
labelNode.fontSize = 144

let effectNode = SKEffectNode()
effectNode.addChild(labelNode)

let destinationPositions: [vector_float2] = [
vector_float2(-0.1, 1), vector_float2(0.5, 1.3), vector_float2(1.1, 1),
vector_float2(0.1, 0.5), vector_float2(0.5, 0.5), vector_float2(0.9, 0.5),
vector_float2(-0.1, 0), vector_float2(0.5, -0.3), vector_float2(1.1, 0)
]

let warpGeometryGrid = SKWarpGeometryGrid(columns: 2, rows: 2)

effectNode.warpGeometry = warpGeometryGrid.replacingByDestinationPositions(positions: destinationPositions)
"""

