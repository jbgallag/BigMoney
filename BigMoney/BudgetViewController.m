//
//  BudgetViewController.m
//  arkit-by-example
//
//  Created by Jonathan Gallagher on 11/16/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import "BudgetViewController.h"

@implementation BudgetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set the initial values
    Config *config = self.config;
    self.Defense.on = config.showDefense;
    self.InternationalAffairs.on = config.showInternationalAffairs;
    self.Energy.on = config.showEnergy;
    self.naturalResources.on = config.showNaturalResources;
    self.spaceTech.on = config.showSpaceTech;
    self.agriculture.on = config.showAgriculture;
    self.commerceHousing.on = config.showCommerce;
    self.transportation.on = config.showTransportation;
    self.commDev.on = config.showCommDev;
    self.educationSocial.on = config.showEducationSocial;
    self.health.on = config.showHealth;
    self.medicare.on = config.showMedicare;
    self.incomeSecurity.on = config.showIncomeSecurity;
    self.socialSecurity.on = config.showSocialSecurity;
    self.veterans.on = config.showVeterans;
    self.justice.on = config.showJustice;
}

@end

