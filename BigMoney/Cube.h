//
//  Cube.h
//  arkit-by-example
//
//  Created by md on 6/15/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import "BudgetTypeEnum.h"

@interface Cube : SCNNode

- (instancetype)initAtPosition:(SCNVector3)position  withmass:(float)mss withbtype:(int)btype withScale:(float)scale withBlockSize:(float)size withMaterial:(SCNMaterial *)material;
- (void)changeMaterial;
- (void)remove;
+ (SCNVector3)getPosition;
+ (SCNMaterial *)currentMaterial;

@property SCNVector3 prevPosition;
@property BOOL firstContact;
@property (nonatomic, retain) SCNNode *node;
@property BudgetType myBType;
@property (nonatomic, retain) SCNScene *cashStack;
@end
