//
//  ScaleCube.h
//  arkit-by-example
//
//  Created by Jonathan Gallagher on 11/26/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#ifndef ScaleCube_h
#define ScaleCube_h
#import <SceneKit/SceneKit.h>
#import "BudgetTypeEnum.h"

@interface ScaleCube : SCNNode

- (instancetype)initAtPosition:(SCNVector3)position  withmass:(float)mss withbtype:(int)btype withScale:(float)scale withBlockSize:(float)size withMaterial:(SCNMaterial *)material;
- (void)changeMaterial;
- (void)remove;
- (void)CubeScale:(float)xzScale withYScale:(float)yScale;
+ (SCNVector3)getPosition;
+ (SCNMaterial *)currentMaterial;

@property SCNVector3 prevPosition;
@property BOOL firstContact;
@property (nonatomic, retain) SCNNode *node;
@property BudgetType myBType;
@property BOOL locked;
@property float scaleXInc,scaleYInc,scaleZInc;
@property float scaleX,scaleY,scaleZ;
@end
#endif /* ScaleCube_h */
