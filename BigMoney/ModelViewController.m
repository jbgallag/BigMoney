//
//  ModelViewController.m
//  arkit-by-example
//
//  Created by Jonathan Gallagher on 11/30/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import "ModelViewController.h"

@interface ModelViewController ()

@end

@implementation ModelViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set the initial values
    Config *config = self.config;
    self.SearsTower.on = config.showSearsTower;
    self.ChicagoBungalow.on = config.showChicagoBungalow;
}


@end
