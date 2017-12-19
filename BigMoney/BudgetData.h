//
//  BudgetData.h
//  arkit-by-example
//
//  Created by Jonathan Gallagher on 11/16/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//
//extern double defenseData[] = {777.,666.,555.};
#ifndef BudgetData_h
#define BudgetData_h
#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>
#import "Cube.h"



@interface BudgetData : NSObject
- (instancetype)init;
//- (void)setBudgetType:(BudgetType)type;
- (void)MakeLabels;
- (void)SetMoneyLabel:(int)idx withValue:(float)val;
- (void)SetYearLabel:(uint)aYear;
- (void)GetMinMaxExtents;
- (void)GetMinMaxExtents:(NSString *)bname;
- (void)RemoveAllLabels;


@property BudgetType myType;
@property (nonatomic, retain) NSString *budgetName;
@property (nonatomic, retain) NSMutableArray<NSString *> *budgetSubCategories;
@property (nonatomic, retain) NSMutableDictionary<NSNumber *, NSNumber *> *budgetValues;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSMutableDictionary *> *subBudgetValues;

//text objects and array for storing cubes for a budget
@property (nonatomic,retain) SCNNode *myYearLabel;
@property (nonatomic,retain) NSMutableArray<SCNNode *> *myBudgetLabels;
@property (nonatomic,retain) NSMutableArray<SCNNode *> *myMoneyLabels;
@property (nonatomic, retain) NSMutableArray<Cube *> *cubes;
@property (nonatomic, retain) NSMutableArray<Cube *> *lastPositions;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSMutableArray *> *budgetCubes;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSNumber *> *budgetXmin;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSNumber *> *budgetYmin;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSNumber *> *budgetZmin;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSNumber *> *budgetXmax;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSNumber *> *budgetYmax;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSNumber *> *budgetZmax;
@property (nonatomic, retain) NSMutableDictionary<NSString *, NSNumber *> *animationCounts;
@property BOOL isDisplayed;
@property BOOL isCollapsed;
@property BOOL readyToDisplay;
@property int animationCount;
@property float xMin,xMax,yMin,yMax,zMin,zMax;
@property SCNVector3 initialPosition;
@end
#endif /* BudgetData_h */
