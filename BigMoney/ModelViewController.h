//
//  ModelViewController.h
//  arkit-by-example
//
//  Created by Jonathan Gallagher on 11/30/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Config.h"

@interface ModelViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *SearsTower;
@property (weak, nonatomic) IBOutlet UISwitch *ChicagoBungalow;

@property (nonatomic, retain) Config *config;
@end
