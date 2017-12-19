//
//  Cube.m
//  arkit-by-example
//
//  Created by md on 6/15/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cube.h"
#import "CollisionCategory.h"
#import "PBRMaterial.h"

static int currentMaterialIndex = 0;


@implementation Cube

- (instancetype)initAtPosition:(SCNVector3)position withmass:(float)mss withbtype:(int)btype withScale:(float)scale withBlockSize:(float)size withMaterial:(SCNMaterial *)material {
  self = [super init];
    
    float dimension_x = 1.067 * scale * size;
    float dimension_y = 1.016 * scale * size;
    float dimension_z = 1.016 * scale * size;
   
  SCNBox *cube = [SCNBox boxWithWidth:dimension_x height:dimension_y length:dimension_z chamferRadius:0];
  cube.materials = @[material];
  self.node = [SCNNode nodeWithGeometry:cube];
   // self.node = [[self.cashStack rootNode] childNodeWithName:@"cashStack" recursively:YES];
   // [self.node setScale:SCNVector3Make(scale, scale, scale)];
  // The physicsBody tells SceneKit this geometry should be manipulated by the physics engine
  
    SCNPhysicsBody *body;
    if(btype == 0) {
        body = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeKinematic shape:nil];
    } else {
        body = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:nil];
    }
    body.affectedByGravity = true;

    self.node.physicsBody = body;
    
    self.node.physicsBody.mass = 1.0;
  self.node.physicsBody.friction = 1.0;
    self.node.physicsBody.rollingFriction = 1.0;
    self.node.physicsBody.restitution = 0.0;
    self.node.physicsBody.damping = 1.0;
    self.node.physicsBody.angularDamping = 1.0;
   // node.physicsBody.momentOfInertia = SCNVector3Make(0.0, 0.0, 0.0);
   // node.physicsBody.velocityFactor = SCNVector3Make(0.1,0.1,0.1);
   // node.physicsBody.damping = 500.0;
    self.node.physicsBody.categoryBitMask = CollisionCategoryCube;
   // node.physicsBody.collisionBitMask = CollisionCategoryCube;
   // node.physicsBody.contactTestBitMask = CollisionCategoryBottom;
    
    
  self.node.position = position;
   // node.physicsBody.velocity = SCNVector3Make(0.0, 0.0, 0.0);
    _prevPosition.x = position.x;
    _prevPosition.y = position.y;
    _prevPosition.z = position.z;
    
    
    _firstContact = true;
  [self addChildNode:self.node];
    
  return self;
}

- (void)changeMaterial {
  // Static, all future cubes use this to have the same material
  currentMaterialIndex = (currentMaterialIndex + 1) % 4;
  [self.childNodes firstObject].geometry.materials = @[[Cube currentMaterial]];
}

+ (SCNMaterial *)currentMaterial {
  NSString *materialName;

  switch(currentMaterialIndex) {
      case 0:
          materialName = @"100bill";
          break;
    case 1:
      materialName = @"rustediron-streaks";
      break;
    case 2:
      materialName = @"carvedlimestoneground";
      break;
    case 3:
      materialName = @"granitesmooth";
      break;
    case 4:
      materialName = @"old-textured-fabric";
      break;
  }
  return [[PBRMaterial materialNamed:materialName] copy];
}

- (void) remove {
  [self removeFromParentNode];
}

@end
