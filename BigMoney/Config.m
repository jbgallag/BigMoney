//
//  Config.m
//  arkit-by-example
//
//  Created by md on 6/16/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"

@implementation Config

- (instancetype)init {
    self = [super init];
    if (self) {
        self.activeBudgets = [NSMutableArray new];
    }
    return self;
}

- (void)findActiveBudgets
{
    [self.activeBudgets removeAllObjects];
    if(_showDefense) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Defense]];
    }
    if(_showEnergy) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Energy]];
    }
    if(_showInternationalAffairs) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:InternationalAffairs]];
    }
    if(_showNaturalResources) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:NaturalResources]];
    }
    if(_showMedicare) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Medicare]];
    }
    if(_showSpaceTech) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:SpaceTech]];
    }
    if(_showAgriculture) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Agriculture]];
    }
    if(_showCommerce) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:CommerceHousing]];
    }
    if(_showTransportation) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Transportation]];
    }
    if(_showCommDev) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:CommDev]];
    }
    if(_showEducationSocial) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:EducationSocial]];
    }
    if(_showHealth) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Health]];
    }
    if(_showIncomeSecurity) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:IncomeSecurity]];
    }
    if(_showSocialSecurity) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:SocialSecurity]];
    }
    if(_showVeterans) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Veterans]];
    }
    if(_showJustice) {
        _budgetsOn += 1;
        [self.activeBudgets addObject:[NSNumber numberWithInt:Justice]];
    }
}

- (void)findBudgetsOn
{
    _budgetsOn = 0;
    if(_showDefense)
        _budgetsOn += 1;
    if(_showEnergy)
        _budgetsOn += 1;
    if(_showInternationalAffairs)
        _budgetsOn += 1;
    if(_showNaturalResources)
        _budgetsOn += 1;
    if(_showMedicare)
        _budgetsOn += 1;
    if(_showSpaceTech)
        _budgetsOn += 1;
    if(_showAgriculture)
        _budgetsOn += 1;
    if(_showCommerce)
        _budgetsOn += 1;
    if(_showTransportation)
        _budgetsOn += 1;
    if(_showCommDev)
        _budgetsOn += 1;
    if(_showEducationSocial)
        _budgetsOn += 1;
    if(_showHealth)
        _budgetsOn += 1;
    if(_showIncomeSecurity)
        _budgetsOn += 1;
    if(_showSocialSecurity)
        _budgetsOn += 1;
    if(_showVeterans)
        _budgetsOn += 1;
    if(_showJustice)
        _budgetsOn += 1;
}
@end
