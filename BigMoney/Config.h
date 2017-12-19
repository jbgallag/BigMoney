//
//  Config.h
//  arkit-by-example
//
//  Created by md on 6/16/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//
#include "BudgetTypeEnum.h"
@interface Config: NSObject

@property BOOL showWorldOrigin;
@property BOOL showFeaturePoints;
@property BOOL showStatistics;
@property BOOL showPhysicsBodies;
@property BOOL showBudgetOne;
@property BOOL showBudgetTwo;
@property BOOL detectPlanes;

@property BOOL showDefense;
@property BOOL showInternationalAffairs;
@property BOOL showEnergy;
@property BOOL showNaturalResources;
@property BOOL showSpaceTech;
@property BOOL showAgriculture;
@property BOOL showCommerce;
@property BOOL showTransportation;
@property BOOL showCommDev;
@property BOOL showEducationSocial;
@property BOOL showHealth;
@property BOOL showMedicare;
@property BOOL showIncomeSecurity;
@property BOOL showSocialSecurity;
@property BOOL showVeterans;
@property BOOL showJustice;
@property BOOL showSearsTower;
@property BOOL showChicagoBungalow;

@property uint budgetsOn;
@property (nonatomic,retain) NSMutableArray<NSNumber *> *activeBudgets;
- (instancetype)init;
- (void)findBudgetsOn;
- (void)findActiveBudgets;

@end
