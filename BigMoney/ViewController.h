//
//  ViewController.h
//  arkit-by-example
//
//  Created by md on 6/8/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ModelIO/ModelIO.h>
#import <SceneKit/ModelIO.h>
#import <ARKit/ARKit.h>
#import "Plane.h"
//#import "Cube.h"
#import "Config.h"
#import "MessageView.h"
#import "BudgetData.h"
#import "ScaleCube.h"





@interface ViewController : UIViewController<UIPopoverPresentationControllerDelegate>

- (void)createBudgetData;
- (void)setupScene;
- (void)setupLights;
- (void)setupPhysics;
- (void)setupRecognizers;
- (void)updateConfig;
- (void)updateBudgetConfig;
- (void)hidePlanes;
- (void)refresh;
- (void)disableTracking:(BOOL)disabled;
- (void)insertBudget:(ARHitTestResult *)hitResult;
- (void)insertScalingCube:(ARHitTestResult *)hitResult;

- (void)insertCubeFrom: (UITapGestureRecognizer *)recognizer;
- (void)geometryConfigFrom: (UITapGestureRecognizer *)recognizer;
- (void)toggleBudgetDetail:(UILongPressGestureRecognizer *)recognizer;

- (void)insertBudgetBlocks:(BudgetData *)bd withBudgetValue:(float)bValue withPosition:(SCNVector3)position;
- (void)insertBudgetBlocks:(BudgetData *)bd withBudgetValue:(float)bValue withBudgetName:(NSString *)bname withPosition:(SCNVector3)position;

- (void)insertBudgetCubes:(BudgetData *)bd withPosition:(SCNVector3)position;
- (void)insertBudgetCubesNoAnimate:(BudgetData *)bd withPosition:(SCNVector3)position;
- (void)AnimateBudget:(BudgetData *)bd;
- (void)AnimateBudget:(BudgetData *)bd withName:(NSString *)bname withCount:(int)cnt;
- (void)AnimateCube:(BudgetData *)bd withEndPosition:(SCNVector3)endPos;

- (void)AnimateAllBudgets;
- (BudgetData *)GetAnimationBudget:(BudgetType)bType;
- (void)ResetActiveBudgetAnimationCounts;
- (void)fontNames;

- (void)refreshCubes;
- (void)refreshCubesNoAnimate;

//- (void)CreateCubes;
- (IBAction)settingsUnwind:(UIStoryboardSegue *)segue;
- (IBAction)detectPlanesChanged:(id)sender;
- (IBAction)detectYearChanged:(id)sender;

- (IBAction)detectAnimateBudgets:(id)sender;

//Budgets
@property (nonatomic, retain) BudgetData *defense;
@property (nonatomic, retain) BudgetData *internationalAffairs;
@property (nonatomic, retain) BudgetData *energy;
@property (nonatomic, retain) BudgetData *naturalResources;
@property (nonatomic, retain) BudgetData *spaceTech;
@property (nonatomic, retain) BudgetData *agriculture;
@property (nonatomic, retain) BudgetData *commerceHousing;
@property (nonatomic, retain) BudgetData *transportation;
@property (nonatomic, retain) BudgetData *commDev;
@property (nonatomic, retain) BudgetData *educationSocial;
@property (nonatomic, retain) BudgetData *health;
@property (nonatomic, retain) BudgetData *medicare;
@property (nonatomic, retain) BudgetData *incomeSecurity;
@property (nonatomic, retain) BudgetData *socialSecurity;
@property (nonatomic, retain) BudgetData *veterans;
@property (nonatomic, retain) BudgetData *justice;

//scaling cube
@property (nonatomic, retain) ScaleCube *myScalingCube;

@property (nonatomic, retain) NSMutableDictionary<NSString *, NSMutableArray *> *sectorBudgetData;
@property (nonatomic, retain) NSMutableArray<BudgetData *> *myBudgets;
@property (nonatomic, retain) NSMutableDictionary<NSUUID *, Plane *> *planes;
@property (nonatomic, retain) NSMutableArray<Cube *> *cubes;
//@property (nonatomic, retain) NSMutableArray<NSValue *> *posCubes;
@property (nonatomic, retain) Config *config;
@property (nonatomic, retain) ARWorldTrackingConfiguration *arConfig;
@property (weak, nonatomic) IBOutlet MessageView *messageViewer;
@property (nonatomic) ARTrackingState currentTrackingState;
@property (nonatomic, retain) SCNNode *movedObject;
@property SCNVector3 prevPosition;
@property int countX,countY,countZ,blockCount;
@property int cubeCount;
@property float unitScalex,unitScaley,unitScalez,scale,blockSize;
@property uint numberOfDisplayedBudgets,currentYear,currentAnimBudget;
@property (nonatomic, retain) NSMutableArray<NSNumber *> *labelPositionsX;
@property (nonatomic, retain) NSMutableArray<NSNumber *> *labelPositionsY;
@property (nonatomic, retain) NSMutableArray<NSNumber *> *labelPositionsZ;

@property (nonatomic, retain) SCNScene *money;

@property BOOL animateAllBudgets;
@end
