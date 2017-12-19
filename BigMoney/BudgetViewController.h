//
//  BudgetViewController.h
//  arkit-by-example
//
//  Created by Jonathan Gallagher on 11/16/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Config.h"

@interface BudgetViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *Defense;
@property (weak, nonatomic) IBOutlet UISwitch *InternationalAffairs;
@property (weak, nonatomic) IBOutlet UISwitch *Energy;
@property (weak, nonatomic) IBOutlet UISwitch *naturalResources;
@property (weak, nonatomic) IBOutlet UISwitch *spaceTech;
@property (weak, nonatomic) IBOutlet UISwitch *agriculture;
@property (weak, nonatomic) IBOutlet UISwitch *commerceHousing;
@property (weak, nonatomic) IBOutlet UISwitch *transportation;
@property (weak, nonatomic) IBOutlet UISwitch *commDev;
@property (weak, nonatomic) IBOutlet UISwitch *educationSocial;
@property (weak, nonatomic) IBOutlet UISwitch *health;
@property (weak, nonatomic) IBOutlet UISwitch *medicare;
@property (weak, nonatomic) IBOutlet UISwitch *incomeSecurity;
@property (weak, nonatomic) IBOutlet UISwitch *socialSecurity;
@property (weak, nonatomic) IBOutlet UISwitch *veterans;
@property (weak, nonatomic) IBOutlet UISwitch *justice;

@property (nonatomic, retain) Config *config;
@end
