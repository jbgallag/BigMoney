//
//  BudgetData.m
//  arkit-by-example
//
//  Created by Jonathan Gallagher on 11/16/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//
#import "BudgetData.h"

@implementation BudgetData

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize self
        _budgetName = [NSString new];
        _budgetValues = [NSMutableDictionary new];
        _budgetSubCategories = [NSMutableArray new];
        _subBudgetValues = [NSMutableDictionary new];
        self.cubes = [NSMutableArray new];
        self.budgetCubes = [NSMutableDictionary new];
        self.budgetXmin = [NSMutableDictionary new];
        self.budgetYmin = [NSMutableDictionary new];
        self.budgetZmin = [NSMutableDictionary new];
        self.budgetXmax = [NSMutableDictionary new];
        self.budgetYmax = [NSMutableDictionary new];
        self.budgetZmax = [NSMutableDictionary new];
        
        self.animationCounts = [NSMutableDictionary new];
        
        self.lastPositions = [NSMutableArray new];
        self.myBudgetLabels = [NSMutableArray new];
        self.myMoneyLabels = [NSMutableArray new];
        self.animationCount = 0;
        self.xMin = 999999.0;
        self.xMax = -999999.0;
        self.yMin = 999999.0;
        self.yMax = -999999.0;
        self.zMin = 999999.0;
        self.zMax = -999999.0;
    }
    return self;
}

- (void)MakeLabels
{
    //main budget name/money label
    SCNScene *label = [SCNScene sceneNamed:@"MainLabel1.scn"];
    SCNNode *rnode = [[label rootNode] childNodeWithName:@"MainLabel1" recursively:YES];
    SCNText *chgText = (SCNText *)rnode.geometry;
    [chgText setString:self.budgetName];
    [self.myBudgetLabels addObject:rnode];
    SCNScene *label2 = [SCNScene sceneNamed:@"MainLabel1.scn"];
    SCNNode *rnode2 = [[label2 rootNode] childNodeWithName:@"MainLabel1" recursively:YES];
    SCNText *chgText2 = (SCNText *)rnode2.geometry;
    [chgText2 setString:@"Billion"];
    [self.myMoneyLabels addObject:rnode2];
    //open the scene again to create year label
    SCNScene *label3 = [SCNScene sceneNamed:@"MainLabel1.scn"];
    SCNNode *rnode3 = [[label3 rootNode] childNodeWithName:@"MainLabel1" recursively:YES];
    SCNText *chgText3 = (SCNText *)rnode3.geometry;
    [chgText3 setString:@"1962"];
    self.myYearLabel = rnode3;
    
    [self.budgetCubes setObject:[NSMutableArray new] forKey:self.budgetName];
    [self.animationCounts setObject:[NSNumber numberWithInt:0] forKey:self.budgetName];
    //sub budget names/money labels
    for(NSString *subName in self.budgetSubCategories) {
        SCNScene *label = [SCNScene sceneNamed:@"MainLabel1.scn"];
        SCNNode *rnode = [[label rootNode] childNodeWithName:@"MainLabel1" recursively:YES];
        SCNText *chgText = (SCNText *)rnode.geometry;
        [chgText setString:subName];
        [self.myBudgetLabels addObject:rnode];
        SCNScene *label2 = [SCNScene sceneNamed:@"MainLabel1.scn"];
        SCNNode *rnode2 = [[label2 rootNode] childNodeWithName:@"MainLabel1" recursively:YES];
        SCNText *chgText2 = (SCNText *)rnode2.geometry;
        [chgText2 setString:@"Billion"];
        [self.myMoneyLabels addObject:rnode2];
        [self.budgetCubes setObject:[NSMutableArray new] forKey:subName];
        [self.animationCounts setObject:[NSNumber numberWithInt:0] forKey:subName];
    }
}

- (void)RemoveAllLabels
{
    for(SCNNode *labelNode in self.myBudgetLabels) {
        [labelNode removeFromParentNode];
    }
    for(SCNNode *labelNode in self.myMoneyLabels) {
        [labelNode removeFromParentNode];
    }
    
}
- (void)SetMoneyLabel:(int)idx withValue:(float)val
{
    SCNNode *node = [self.myMoneyLabels objectAtIndex:idx];
    SCNText *chgText = (SCNText *)node.geometry;
    [chgText setString:[NSString stringWithFormat:@"%04.1f Billion",val]];
}

- (void)SetYearLabel:(uint)aYear
{
    SCNText *chgText = (SCNText *)self.myYearLabel.geometry;
    [chgText setString:[NSString stringWithFormat:@"%d",aYear]];
}

- (void)GetMinMaxExtents
{
    self.xMin = 999999.0;
    self.xMax = -999999.0;
    self.yMin = 999999.0;
    self.yMax = -999999.0;
    self.zMin = 999999.0;
    self.zMax = -999999.0;
    
    for(Cube *aCube in self.cubes) {
        //x
        if([[aCube node] position].x < self.xMin)
            self.xMin = [[aCube node] position].x;
        if([[aCube node] position].x > self.xMax)
            self.xMax = [[aCube node] position].x;
        //y
        if([[aCube node] position].y < self.yMin)
            self.yMin = [[aCube node] position].y;
        if([[aCube node] position].y > self.yMax)
            self.yMax = [[aCube node] position].y;
        //z
        if([[aCube node] position].z < self.zMin)
            self.zMin = [[aCube node] position].z;
        if([[aCube node] position].z > self.zMax)
            self.zMax = [[aCube node] position].z;
    }
}

- (void)GetMinMaxExtents:(NSString *)bname
{
    [self.budgetXmin setObject:[NSNumber numberWithFloat:999999.0] forKey:bname];
    [self.budgetXmax setObject:[NSNumber numberWithFloat:-999999.0] forKey:bname];
    [self.budgetYmin setObject:[NSNumber numberWithFloat:999999.0] forKey:bname];
    [self.budgetYmax setObject:[NSNumber numberWithFloat:-999999.0] forKey:bname];
    [self.budgetZmin setObject:[NSNumber numberWithFloat:999999.0] forKey:bname];
    [self.budgetZmax setObject:[NSNumber numberWithFloat:-999999.0] forKey:bname];
    
    for(Cube *aCube in [self.budgetCubes objectForKey:bname]) {
        //x
        if([[aCube node] position].x < [[self.budgetXmin objectForKey:bname] floatValue])
            [self.budgetXmin setObject:[NSNumber numberWithFloat:[[aCube node] position].x] forKey:bname];
        if([[aCube node] position].x > [[self.budgetXmax objectForKey:bname] floatValue])
            [self.budgetXmax setObject:[NSNumber numberWithFloat:[[aCube node] position].x] forKey:bname];
        //y
        if([[aCube node] position].y < [[self.budgetYmin objectForKey:bname] floatValue])
            [self.budgetYmin setObject:[NSNumber numberWithFloat:[[aCube node] position].y] forKey:bname];
        if([[aCube node] position].y > [[self.budgetYmax objectForKey:bname] floatValue])
            [self.budgetYmax setObject:[NSNumber numberWithFloat:[[aCube node] position].y] forKey:bname];
        //z
        if([[aCube node] position].z < [[self.budgetZmin objectForKey:bname] floatValue])
            [self.budgetZmin setObject:[NSNumber numberWithFloat:[[aCube node] position].z] forKey:bname];
        if([[aCube node] position].z > [[self.budgetZmax objectForKey:bname] floatValue])
            [self.budgetZmax setObject:[NSNumber numberWithFloat:[[aCube node] position].z] forKey:bname];
    }
    
}

@end


