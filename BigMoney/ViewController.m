//
//  ViewController.m
//  arkit-by-example
//
//  Created by md on 6/8/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKitTypes.h>
#import "CollisionCategory.h"
#import "PBRMaterial.h"
#import "ConfigViewController.h"
#import "BudgetViewController.h"
#import "ModelViewController.h"


@interface ViewController () <ARSCNViewDelegate, UIGestureRecognizerDelegate, SCNPhysicsContactDelegate>
@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

@implementation ViewController

-(void)fontNames{
    
    NSArray *familyNames = [UIFont familyNames];
    [familyNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        NSLog(@"* %@",obj);
        NSArray *fontNames = [UIFont fontNamesForFamilyName:obj];
        [fontNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            NSLog(@"--- %@",obj);
        }];
    }];
    
}
- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Used to keep track of the current tracking state of the ARSession
  self.currentTrackingState = ARTrackingStateNormal;
  
  [self setupScene];
  [self setupLights];
  [self setupPhysics];
  [self setupRecognizers];
  
  // Create a ARSession confi object we can re-use
  self.arConfig = [ARWorldTrackingConfiguration new];
  self.arConfig.lightEstimationEnabled = YES;
  self.arConfig.planeDetection = ARPlaneDetectionHorizontal;
  
  Config *config = [Config new];
  config.showStatistics = NO;
  config.showWorldOrigin = YES;
  config.showFeaturePoints = NO;
  config.showPhysicsBodies = NO;
  config.detectPlanes = YES;
  
    
    self.animateAllBudgets = false;
    self.currentAnimBudget = 0;
    _prevPosition.x = 0.0;
    _prevPosition.y = 0.0;
    _prevPosition.z = 0.0;
    _countX = 0;
    _countY = 0;
    _countZ = 0;
    _blockCount = 0;
    _cubeCount = 0;
//scale data
    _blockSize = 1.0;
    _scale = 0.01;
    
    _unitScalex = _scale * 1.067;
    _unitScaley = _scale * 1.016;
    _unitScalez = _scale * 1.016;
//others
    self.currentYear = 1962;
 //   self.sceneView.scene.physicsWorld.speed = 0.05;
  self.config = config;
  [self updateConfig];
  
   
   // self.yourtextfield.inputView = yourpicker;
  // Stop the screen from dimming while we are using the app
  [UIApplication.sharedApplication setIdleTimerDisabled:YES];
    
    self.sectorBudgetData = [NSMutableDictionary new];
    
    
    //budgets
    _defense = [[BudgetData alloc] init];
    self.internationalAffairs = [[BudgetData alloc] init];
    self.energy = [[BudgetData alloc] init];
    self.naturalResources = [[BudgetData alloc] init];
    self.spaceTech = [[BudgetData alloc] init];
    self.agriculture = [[BudgetData alloc] init];
    self.commerceHousing = [[BudgetData alloc] init];
    self.transportation = [[BudgetData alloc] init];
    self.commDev = [[BudgetData alloc] init];
    self.educationSocial = [[BudgetData alloc] init];
    self.health = [[BudgetData alloc] init];
    self.medicare = [[BudgetData alloc] init];;
    self.incomeSecurity = [[BudgetData alloc] init];
    self.socialSecurity = [[BudgetData alloc] init];
    self.veterans = [[BudgetData alloc] init];;
    self.justice = [[BudgetData alloc] init];
    [self createBudgetData];
   // [self CreateCubes];
   // [self fontNames];
    
    //create a scaling cube
    SCNVector3 position = SCNVector3Make(0.0, 0.0, 0.0);
    
    
   // NSBundle *mBund = [NSBundle mainBundle];
    //[mBund pathForResource:@"Resources" ofType:@"obj"];
   // NSURL *modelUrl = [[NSURL alloc] initFileURLWithPath:@"SearsTower.obj"];
   // MDLAsset *objMode = [[MDLAsset alloc] initWithURL:modelUrl];
//    SCNScene *sears = [SCNScene sceneNamed:@"$100,000,000.scn"];
   // MDLAsset *st = [MDLAsset ass]
    //SCNNode *searsNode = [SCNNode nodeWithGeometry:[[sears rootNode] geometry]];
    
    self.money = [SCNScene sceneNamed:@"SearsTower.scn"];
    if(self.money == nil)
        printf("BAD SCENE\n");
    

}
/*- (void)CreateCubes
{
    SCNVector3 zposition = SCNVector3Make(0.0, 0.0, 0.0);
    for(int i=0; i<6000; i++) {
 Cube *cube = [[Cube alloc] initAtPosition:zposition withmass:1.0 withbtype:0 withScale:0.025 withMaterial:[Cube currentMaterial]];
        [self.cubes addObject:cube];
        //[self.sceneView.scene.rootNode addChildNode:cube];
    }
}*/

- (void)createBudgetData
{
    int aYear = 1962;
    [_defense setMyType:Defense];
    [_defense setBudgetName:@"Defense"];
    [[_defense budgetSubCategories] addObject:@"Personnel"];
    [[_defense budgetSubCategories] addObject:@"Operations"];
    [[_defense budgetSubCategories] addObject:@"Procurement"];
    [[_defense budgetSubCategories] addObject:@"Research"];
    [[_defense budgetSubCategories] addObject:@"Construction"];
    [[_defense budgetSubCategories] addObject:@"Family Housing"];
    [[_defense budgetSubCategories] addObject:@"Other"];
    [[_defense budgetSubCategories] addObject:@"Atomic"];
    [[_defense budgetSubCategories] addObject:@"Misc"];
    //now we can add scenkit 3d text labels
    [_defense MakeLabels];
    aYear = 1962;
     const int TotalNationalDefense[] = {52345,53400,54757,50620,58111,71417,81926,82497,81692,78872,79174,76681,79347,86509,89619,22269,97241,104495,116342,133995,157513,185309,209903,227411,252743,273373,281996,290360,303555,299321,273285,298346,291084,281640,272063,265748,270502,268194,274769,294363,304732,348456,404733,455813,495294,521820,551258,616066,661012,693485,705554,677852,633446,603457,589659,593372,602783,652570,675117,679832,677802,672853};
    const int MilitaryPersonnel[] =  {16331,16256,17422,17913,20009,22952,25118,26914,29032,29079,29571,29773,30409,32162,32546,8268,33672,35553,37345,40897,47941,55170,60886,64158,67842,71511,72020,76337,80676,75622,83439,81171,75904,73137,70809,66669,69724,68976,69503,75950,73977,86799,106744,113576,127463,127543,127544,138940,147348,155690,161608,152266,150825,148923,145206,147905,145728,152493,0,0,0,0};
    const int OperationandMaintenance[] = {11594,11874,11932,12349,14710,19000,20578,22227,21609,20941,21675,21069,22478,26297,27837,7232,30587,33580,36440,44788,51878,59673,64881,67329,72336,75255,76167,84436,86960,88294,101715,91939,94036,87868,91017,88711,92408,93412,96344,105812,111964,130005,151408,174045,188118,203789,216631,244836,259312,275988,291038,282297,259662,244481,247239,243198,244629,253006,0,0,0,0};
    const int Procurement[] = {14532,16632,15351,11839,14339,19012,23283,23988,21584,18858,17131,15654,15241,16042,15964,3766,18178,19976,25404,29021,35191,43271,53624,61879,70381,76517,80743,77164,81619,80972,82028,74880,69935,61768,54981,48913,47690,48206,48826,51696,54986,62515,67926,76216,82294,89757,99647,117398,129218,133603,128003,124712,114912,107485,101342,102656,105046,113456,0,0,0,0};
    const int ResearchDevelopmentTestandEvaluation[] = {6319,6376,7021,6236,6259,7160,7747,7457,7166,7303,7881,8157,8582,8866,8923,2206,9795,10508,11152,13127,15278,17729,20552,23113,27099,32279,33592,34788,36997,37454,34585,34628,36964,34759,34590,36490,37011,37416,37359,37602,40455,44389,53098,60759,65694,68629,73136,75120,79030,76990,74871,70396,66892,64928,64124,64873,66426,76492,0,0,0,0};
    const int MilitaryConstruction[] = {1347,1144,1026,1007,1334,1536,1281,1389,1168,1095,1108,1119,1407,1462,2019,376,1914,1932,2080,2450,2458,2922,3524,3705,4260,5067,5853,5874,5275,5080,3497,4262,4831,4979,6823,6683,6187,6044,5521,5109,4977,5052,5851,6312,5331,6245,7899,11563,17614,21169,19917,14553,12318,9823,8114,6677,7172,8231,0,0,0,0};
    const int FamilyHousing[] = {259,563,550,563,569,485,495,574,614,598,688,729,884,1124,1192,296,1358,1405,1468,1680,1721,1993,2126,2413,2642,2819,2908,3082,3257,3501,3296,3271,3255,3316,3571,3828,4003,3871,3692,3413,3516,3736,3784,3905,3720,3717,3473,3590,2721,3173,3432,2331,1829,1354,1198,1304,1236,1244,0,0,0,0};
    const int OtherMil[] = {-271,-1696,-717,-1127,-590,-76,1853,-1777,-1050,-376,-409,-1468,-1137,-1101,-563,-338,-357,-694,-284,-1050,-605,-65,-1236,-1734,548,1993,2637,209,46,-1228,-46236,-3317,-6429,2727,-2418,1836,1228,-2132,-47,1447,310,-651,-1675,1626,1451,-383,218,3185,1499,90,-805,4296,1357,903,-4724,-1243,2773,16759,0,0,0,0};
    const int Atomicenergydefenseactivities[] = {2074,2041,1902,1620,1466,1277,1336,1389,1415,1385,1373,1409,1486,1506,1565,435,1936,2070,2541,2878,3398,4309,5171,6120,7098,7445,7451,7913,8119,8988,9998,10613,11011,11884,11769,11637,11267,11262,12221,12138,12931,14795,16018,16605,18031,17465,17042,17122,17546,19308,20410,19246,17634,17416,18692,19387,19986,22779,23377,23283,23026,23483};
    const int Defenserelatedactivities[] = {160,212,270,220,16,71,235,337,154,-10,156,240,-3,151,137,27,158,166,196,206,253,307,375,428,535,487,626,557,606,639,964,899,1577,1202,921,981,984,1139,1350,1196,1616,1816,1579,2769,3192,5058,5668,4312,6724,7474,7080,7755,8017,8144,8468,8615,9787,8110,8775,9015,9084,8931};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[_defense budgetValues] setObject:[NSNumber numberWithDouble:TotalNationalDefense[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[_defense budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:MilitaryPersonnel[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:OperationandMaintenance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Procurement[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:ResearchDevelopmentTestandEvaluation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 4)
                    [subValues setObject:[NSNumber numberWithDouble:MilitaryConstruction[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 5)
                    [subValues setObject:[NSNumber numberWithDouble:FamilyHousing[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 6)
                    [subValues setObject:[NSNumber numberWithDouble:OtherMil[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 7)
                    [subValues setObject:[NSNumber numberWithDouble:Atomicenergydefenseactivities[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 8)
                    [subValues setObject:[NSNumber numberWithDouble:Defenserelatedactivities[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[_defense subBudgetValues] setObject:subValues forKey:[[_defense budgetSubCategories] objectAtIndex:i]];
    }
    //international affairs
    [self.internationalAffairs setMyType:InternationalAffairs];
    [self.internationalAffairs setBudgetName:@"International Affairs"];
    [[self.internationalAffairs budgetSubCategories] addObject:@"Development/Humanitarian"];
    [[self.internationalAffairs budgetSubCategories] addObject:@"Security"];
    [[self.internationalAffairs budgetSubCategories] addObject:@"Foreign Affairs"];
    [[self.internationalAffairs budgetSubCategories] addObject:@"Information Exchange"];
    [[self.internationalAffairs budgetSubCategories] addObject:@"Financial Programs"];
    //now we can add scenkit 3d text labels
    [self.internationalAffairs MakeLabels];
    aYear = 1962;
    const int Internationaldevelopmentandhumanitarianassistance[] = {2883,3079,3367,3357,3478,3085,2879,2484,2341,2296,2394,1741,2430,3134,2636,1119,2823,2647,2910,3626,4131,3772,3955,4478,5408,4967,4319,4703,4836,5498,5141,6132,5825,7048,7598,6160,6003,5395,5653,6516,7185,7812,10324,13807,17696,16693,15524,14074,22095,19014,21255,21882,22551,23534,24087,24129,25663,23893,19342,16773,15238,13815};
    const int Internationalsecurityassistance[] = {1958,2185,1830,1599,1590,1530,1051,1102,1094,1367,1446,1427,1824,2535,2683,1470,3075,3926,3655,4763,5095,5416,6613,7924,9391,10499,7106,4500,1467,8652,9823,7490,7639,6642,5252,4565,4632,5135,5531,6387,6560,7907,8620,8369,7895,7811,7982,9480,6247,11363,12042,11464,9954,11381,12907,11305,13289,14940,12009,10211,9008,8468};
    const int Conductofforeignaffairs[] = {249,346,231,336,354,369,354,370,398,405,452,476,609,659,727,263,982,1128,1310,1366,1343,1625,1761,1869,2038,2266,2206,2726,2885,3045,3279,3879,4298,4544,4189,3753,3917,3259,4160,4708,5048,7035,6681,7895,9148,8559,8379,10388,12152,13557,12486,13548,13038,12859,13246,13874,14747,12981,11763,9514,8419,7880};
    const int Foreigninformationandexchangeactivities[] = {197,201,207,224,228,245,253,237,235,241,274,295,320,348,382,115,386,423,465,534,528,575,607,688,802,915,998,1049,1105,1102,1252,1279,1351,1397,1416,1186,1171,1158,1226,817,804,906,959,1140,1129,1162,1220,1330,1330,1485,1575,1556,1519,1464,1531,1546,1648,1392,1180,1076,1076,1076};
    const int Internationalfinancialprograms[] = {353,-503,-690,-242,-69,338,765,407,261,-150,215,211,527,421,4,-509,-913,-642,-881,2425,2007,911,-1089,910,-1471,-4501,-2985,-2513,-710,-4539,-3648,-2689,-1896,-2564,-2026,-2177,-550,-1893,-1331,-1215,-3112,-1345,-5385,-4341,-1303,-4726,-4623,-6415,-4295,-224,-1673,-1266,-831,-2552,-3195,-5548,1066,2267,1664,921,48,-575};
    const int TotalInternationalAffairs[] = {5639,5308,4945,5273,5580,5566,5301,4600,4330,4159,4781,4149,5710,7097,6433,2458,6353,7482,7459,12714,13104,12300,11848,15869,16169,14146,11645,10466,9583,13758,15846,16090,17218,17067,16429,13487,15173,13054,15239,17213,16485,22315,21199,26870,34565,29499,28482,28857,37529,45195,45685,47184,46231,46686,48576,45306,56413,55473,45958,38495,33789,30664};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.internationalAffairs budgetValues] setObject:[NSNumber numberWithDouble:TotalInternationalAffairs[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.internationalAffairs budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Internationaldevelopmentandhumanitarianassistance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Internationalsecurityassistance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Conductofforeignaffairs[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Foreigninformationandexchangeactivities[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 4)
                    [subValues setObject:[NSNumber numberWithDouble:Internationalfinancialprograms[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.internationalAffairs subBudgetValues] setObject:subValues forKey:[[self.internationalAffairs budgetSubCategories] objectAtIndex:i]];
    }
    //energy
    [self.energy setMyType:Energy];
    [self.energy setBudgetName:@"Energy"];
    [[self.energy budgetSubCategories] addObject:@"Supply"];
    [[self.energy budgetSubCategories] addObject:@"Conservation"];
    [[self.energy budgetSubCategories] addObject:@"Emergency Preparedness"];
    [[self.energy budgetSubCategories] addObject:@"Policy"];
    //now we can add scenkit 3d text labels
    [self.energy MakeLabels];
    aYear = 1962;
    const int Energysupply[] = {533,451,485,602,510,673,918,887,856,880,1089,1007,969,2446,3530,913,4841,6075,7165,8367,10202,8263,6143,3255,2615,2839,2318,746,1230,1976,1945,3226,3286,3899,3584,1649,626,181,-118,-1818,-1145,-803,-2051,-1536,-929,234,-1983,-413,2051,5801,8084,9017,9038,4056,4707,2019,4906,2326,-1601,-275,-231,31};
    const int Energyconservation[] = {0,0,0,0,0,0,0,0,0,0,0,0,3,48,51,38,143,221,252,569,730,516,477,527,491,515,281,342,333,365,386,468,521,582,671,624,572,621,586,666,760,878,897,926,883,747,580,409,1432,4997,6736,4941,1240,910,1187,967,927,996,849,660,380,380};
    const int Emergencyenergypreparedness[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,33,65,32,123,897,1021,342,3280,3877,1855,2518,1838,597,788,568,621,442,-235,319,336,275,223,141,23,233,225,162,159,169,182,158,162,-441,195,179,754,199,-3263,375,217,-140,449,234,-579,-1258,-845,-485,-1322,-1623};
    const int Energyinformationpolicyandregulation[] = {71,80,87,97,101,109,118,122,142,155,207,231,331,389,558,146,664,798,742,877,954,871,878,773,664,739,684,640,521,558,340,486,176,462,458,425,254,235,218,229,235,231,247,305,324,245,356,456,518,621,617,525,547,444,495,499,766,667,543,542,542,542};
    const int TotalEnergy[] = {604,530,572,699,612,782,1037,1010,997,1035,1296,1237,1303,2916,4204,1129,5770,7991,9179,10156,15166,13527,9353,7073,5608,4690,4072,2296,2705,3341,2436,4499,4319,5218,4936,2839,1475,1270,911,-761,9,475,-725,-147,440,785,-852,631,4755,11618,12174,14858,11042,5270,6838,3719,6020,2731,-1054,442,-631,-670};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.energy budgetValues] setObject:[NSNumber numberWithDouble:TotalEnergy[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.energy budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Energysupply[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Energyconservation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Emergencyenergypreparedness[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Energyinformationpolicyandregulation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.energy subBudgetValues] setObject:subValues forKey:[[self.energy budgetSubCategories] objectAtIndex:i]];
    }

    //energy
    [self.naturalResources setMyType:NaturalResources];
    [self.naturalResources setBudgetName:@"Natural Resources/Environment"];
    [[self.naturalResources budgetSubCategories] addObject:@"Water"];
    [[self.naturalResources budgetSubCategories] addObject:@"Conservation"];
    [[self.naturalResources budgetSubCategories] addObject:@"Recreation"];
    [[self.naturalResources budgetSubCategories] addObject:@"Pollution"];
    [[self.naturalResources budgetSubCategories] addObject:@"Other"];
    //now we can add scenkit 3d text labels
    [self.naturalResources MakeLabels];
    aYear = 1962;
    const int Waterresources[] = {1290,1448,1461,1546,1704,1685,1644,1591,1514,1768,1948,2221,2200,2608,2742,805,3213,3431,3853,4223,4132,3948,3904,4070,4122,4041,3783,4034,4271,4401,4366,4559,4258,4488,4625,4536,4411,4647,4725,5078,5237,5570,5492,5571,5726,8030,5104,6074,8068,11662,11621,9178,7675,7912,7760,7379,8574,8104,7848,7884,7740,7393};
    const int Conservationandlandmanagement[] = {376,357,364,384,351,417,457,323,436,553,522,403,243,761,744,193,736,1229,1070,1348,1490,1365,1787,1615,1860,1749,1822,2589,3792,4030,4646,5268,5498,5789,5958,5980,5669,6204,6367,6762,7109,9797,9739,9758,6226,7813,9646,8718,9813,10783,11955,11101,10723,9707,10519,12305,12013,11836,11825,12173,11999,11376};
    const int Recreationalresources[] = {123,148,167,175,189,222,269,315,303,397,439,464,551,696,739,207,838,1207,1239,1372,1297,1154,1170,1263,1230,1141,1206,1268,1336,1388,1531,1681,1890,1871,1998,1933,2029,2092,2657,2540,2311,2735,2843,2944,2990,3042,2956,3208,3550,3911,4157,3752,3506,3362,3501,3688,3997,4105,4053,4185,4090,4062};
    const int Pollutioncontrolandabatement[] = {70,87,117,134,158,190,249,303,384,702,764,1122,2035,2523,3067,1091,4279,3965,4707,5510,5170,5012,4263,4044,4465,4831,4869,4832,4878,5156,5854,6073,6066,6042,6502,6180,6284,6417,6891,7395,7502,7602,8201,8473,8065,8565,8410,8079,8270,10841,10946,10813,9624,8634,7241,8619,8674,6631,5682,5743,5792,5859};
    const int Othernaturalresources[] = {186,212,255,292,317,354,370,368,428,495,567,565,668,757,891,228,966,1151,1266,1405,1478,1519,1548,1595,1668,1866,1675,1878,1890,2080,2148,2420,2512,2811,2806,2874,2808,2918,3303,3228,3373,3722,3392,3948,4976,5575,5605,5741,5872,6470,6794,6787,6617,6556,7013,7543,7357,6870,6576,6638,6551,6425};
    const int TotalNaturalResourcesandEnvironment[] = {2044,2251,2364,2531,2719,2869,2988,2900,3065,3915,4241,4775,5697,7346,8184,2524,10032,10983,12135,13858,13568,12998,12672,12586,13345,13628,13355,14601,16169,17055,18544,20001,20224,21000,21889,21503,21201,22278,23943,25003,25532,29426,29667,30694,27983,33025,31721,31820,35573,43667,45473,41631,38145,36171,36034,39534,40615,37546,35984,36623,36172,35115};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.naturalResources budgetValues] setObject:[NSNumber numberWithDouble:TotalNaturalResourcesandEnvironment[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.naturalResources budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Waterresources[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Conservationandlandmanagement[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Recreationalresources[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Pollutioncontrolandabatement[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 4)
                    [subValues setObject:[NSNumber numberWithDouble:Othernaturalresources[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.naturalResources subBudgetValues] setObject:subValues forKey:[[self.naturalResources budgetSubCategories] objectAtIndex:i]];
    }
    //spaceTech
    [self.spaceTech setMyType:SpaceTech];
    [self.spaceTech setBudgetName:@"Space & Technology"];
    [[self.spaceTech budgetSubCategories] addObject:@"Research"];
    [[self.spaceTech budgetSubCategories] addObject:@"Space"];
    //now we can add scenkit 3d text labels
    [self.spaceTech MakeLabels];
    aYear = 1962;
    const int Generalscienceandbasicresearch[] = {497,534,766,789,858,897,930,938,947,1009,979,961,1017,1038,1034,292,1078,1160,1297,1381,1476,1606,1644,1842,2015,2207,2243,2407,2626,2818,3136,3551,3914,3825,4099,3991,4080,5306,5638,6167,6520,7261,7951,8392,8819,9093,9149,9573,10020,11730,12434,12458,12479,12011,11719,11950,12558,11829,11984,11789,11623,11470};
    const int Spaceflightresearchandsupportingactivities[] = {1226,2516,4131,5034,5858,5336,4594,4082,3564,3172,3196,3071,2963,2953,3338,871,3657,3766,3937,4451,4992,5593,6290,6469,6607,6756,6957,8413,10196,11609,12957,12838,13092,12363,12593,12693,13056,12866,12446,12427,13233,13473,12880,14637,14778,14491,15258,17200,18397,18370,17032,16602,16429,16559,17693,18224,18543,18816,18513,18584,18597,18597};
    const int TotalGeneralScienceSpaceandTechnology[] = {1723,3051,4897,5823,6717,6233,5524,5020,4511,4182,4175,4032,3980,3991,4373,1162,4736,4926,5234,5831,6468,7199,7934,8311,8622,8962,9200,10820,12821,14426,16092,16389,17006,16189,16692,16684,17136,18172,18084,18594,19753,20734,20831,23029,23597,23584,24407,26773,28417,30100,29466,29060,28908,28570,29412,30174,31101,30645,30497,30373,30220,30067};

    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.spaceTech budgetValues] setObject:[NSNumber numberWithDouble:TotalGeneralScienceSpaceandTechnology[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.spaceTech budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Generalscienceandbasicresearch[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Spaceflightresearchandsupportingactivities[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.spaceTech subBudgetValues] setObject:subValues forKey:[[self.spaceTech budgetSubCategories] objectAtIndex:i]];
    }
    //agriculture
    [self.agriculture setMyType:Agriculture];
    [self.agriculture setBudgetName:@"Agriculture"];
    [[self.agriculture budgetSubCategories] addObject:@"Farm Income Support"];
    [[self.agriculture budgetSubCategories] addObject:@"Research/Services"];
    //now we can add scenkit 3d text labels
    [self.agriculture MakeLabels];
    aYear = 1962;
    const int Farmincomestabilization[] = {3222,4047,4241,3551,2004,2515,4032,5304,4589,3651,4553,4099,1458,2160,2249,743,5735,10228,9895,7441,9783,14344,21316,11828,23702,29570,24697,15223,14699,9550,12743,12499,17557,12219,7037,6478,6261,9313,20039,33442,22746,18371,18302,11182,22043,21405,13089,13756,17628,16478,15876,13061,25213,20012,13424,13418,15766,21552,14905,12665,15541,14120};
    const int Agriculturalresearchandservices[] = {340,337,368,404,444,475,512,521,577,639,675,722,736,837,860,229,998,1073,1281,1333,1458,1522,1491,1649,1725,1749,1770,1865,1999,2087,2143,2423,2524,2575,2634,2557,2628,2764,2840,3016,3506,3594,4194,4257,4522,4564,4573,4631,4609,4878,4786,4730,4465,4374,5076,4924,5334,5080,4299,4184,4083,3961};
    const int TotalAgriculture[] = {3562,4384,4609,3954,2447,2990,4544,5826,5166,4290,5227,4821,2194,2997,3109,972,6734,11301,11176,8774,11241,15866,22807,13477,25427,31319,26466,17088,16698,11637,14886,14922,20081,14795,9671,9035,8889,12077,22879,36458,26252,21965,22496,15439,26565,25969,17662,18387,22237,21356,20662,17791,29678,24386,18500,18342,21100,26632,19204,16849,19624,18081};

    
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.agriculture budgetValues] setObject:[NSNumber numberWithDouble:TotalAgriculture[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.agriculture budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Farmincomestabilization[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Agriculturalresearchandservices[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.agriculture subBudgetValues] setObject:subValues forKey:[[self.agriculture budgetSubCategories] objectAtIndex:i]];
    }
    //commerce housing
    [self.commerceHousing setMyType:CommerceHousing];
    [self.commerceHousing setBudgetName:@"Commerce/Housing"];
    [[self.commerceHousing budgetSubCategories] addObject:@"Mortgage Credit"];
    [[self.commerceHousing budgetSubCategories] addObject:@"Postal Service"];
    [[self.commerceHousing budgetSubCategories] addObject:@"Deposit Insurance"];
    [[self.commerceHousing budgetSubCategories] addObject:@"Commerce Advancement"];
    //now we can add scenkit 3d text labels
    [self.commerceHousing MakeLabels];
    aYear = 1962;
    const int Mortgagecredit[] = {650,-592,-54,277,2494,2846,3261,-720,590,74,550,-399,2119,5463,4336,562,2609,4553,3991,5887,6063,6056,5135,4382,3054,934,-67,4992,4978,3845,5362,4320,1554,-501,-1038,-5025,-4006,-2934,364,-3335,-1164,-7015,-4591,2659,-862,-619,-4986,17,99760,35804,14158,-8143,-87854,-84300,-35658,-34721,-27321,-30784,-28557,-28867,-27815,-27011};
    const int Postalservice[] = {797,770,578,805,888,1141,1080,920,1510,2183,1772,1567,2471,2989,2805,212,2094,1282,896,1246,1432,154,1111,1239,1351,758,1593,2229,127,2116,1828,1169,1602,1233,-1839,-58,77,303,1050,2129,2395,207,-5169,-4070,-1223,-971,-3161,-3074,-978,-682,909,2744,-1839,-2453,-1610,-1265,1315,-1787,-3588,-2616,-1979,-1670};
    const int Depositinsurance[] = {-394,-423,-436,-389,-486,-401,-522,-603,-501,-383,-597,-805,-611,511,-573,-63,-2788,-988,-1745,-285,-1371,-2056,-1253,-616,-2198,1394,3106,10020,21996,57891,66232,2518,-27957,-7570,-17827,-8394,-14384,-4371,-5280,-3053,-1569,-1026,-1430,-1976,-1371,-1110,-1492,18760,22573,-32033,-8697,6666,4292,-13823,-12812,-13052,-11444,-11717,-6403,-6521,-5938,-1571};
    const int Otheradvancementofcommerce[] = {371,307,331,465,348,394,462,284,513,492,497,568,726,984,1051,221,1178,1406,1545,2542,2083,2101,1688,1954,2130,1973,1802,1922,2608,3747,2848,2911,2949,2609,2896,2999,3673,8009,6507,7466,6069,7427,11917,8652,11022,8887,10126,12167,170180,-85405,-18934,39380,2202,5715,12175,14961,19775,19443,17973,20259,14706,12369};
    const int TotalCommerceandHousingCredit[] = {1424,62,418,1157,3245,3979,4280,-119,2112,2366,2222,931,4705,9947,7619,931,3093,6254,4686,9390,8206,6256,6681,6959,4337,5058,6434,19163,29709,67599,76270,10918,-21853,-4228,-17808,-10478,-14640,1007,2641,3207,5731,-407,727,5265,7566,6187,487,27870,291535,-82316,-12564,40647,-83199,-94861,-37905,-34077,-17675,-24845,-20575,-17745,-21026,-17883};
    
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.commerceHousing budgetValues] setObject:[NSNumber numberWithDouble:TotalCommerceandHousingCredit[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.commerceHousing budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Mortgagecredit[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Postalservice[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Depositinsurance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Otheradvancementofcommerce[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.commerceHousing subBudgetValues] setObject:subValues forKey:[[self.commerceHousing budgetSubCategories] objectAtIndex:i]];
    }
    //transportation
    [self.transportation setMyType:Transportation];
    [self.transportation setBudgetName:@"Transportation"];
    [[self.transportation budgetSubCategories] addObject:@"Ground"];
    [[self.transportation budgetSubCategories] addObject:@"Air"];
    [[self.transportation budgetSubCategories] addObject:@"Water"];
    [[self.transportation budgetSubCategories] addObject:@"Other"];
    //now we can add scenkit 3d text labels
    [self.transportation MakeLabels];
    aYear = 1962;
    const int Groundtransportation[] = {2855,3090,3715,4105,4072,4139,4378,4443,4678,5182,5356,5641,5583,7027,9602,2336,10226,10431,12662,15274,17074,14321,14265,16158,17606,18725,17150,18148,17946,18954,19545,20347,21251,23940,25297,25650,26795,26004,28052,31697,35804,40158,37491,40744,42317,45209,46818,49978,54103,60784,60902,61308,60005,60827,59126,62136,62045,59985,60936,59961,60068,55741};
    const int Airtransportation[] = {818,851,882,941,961,1042,1084,1206,1408,1807,1907,2159,2216,2387,2531,578,2786,3243,3355,3723,3814,3526,4000,4415,4895,5287,5520,5897,6622,7234,8184,9313,10049,10146,10020,10135,10138,10622,10720,10571,13975,16538,23343,16743,18807,18005,18096,19399,20799,21431,21353,21725,21464,20923,20033,20028,21537,20506,19304,19173,10183,8836};
    const int Watertransportation[] = {617,655,646,717,695,749,841,857,895,1027,1094,1211,1316,1430,1542,415,1741,1787,1969,2229,2381,2687,2969,3010,3201,3964,3461,3111,2916,3151,3148,3429,3423,3648,3732,3460,3554,3518,3546,4394,4401,5041,5907,6898,6439,6688,7695,8121,9093,9351,10359,9650,9774,9759,9994,10064,9643,10841,10993,10881,10809,10790};
    const int Othertransportation[] = {0,0,0,0,3,6,13,21,26,37,36,56,57,74,65,28,76,61,93,104,110,90,99,85,137,136,91,116,124,146,223,244,281,333,301,320,280,199,214,191,267,96,328,242,331,342,296,118,294,406,352,336,430,406,380,338,555,495,443,462,469,455};
    const int TotalTransportation[] = {4290,4596,5242,5763,5730,5936,6316,6526,7008,8052,8392,9066,9172,10918,13739,3358,14829,15521,18079,21329,23379,20625,21334,23669,25838,28113,26222,27272,27608,29485,31099,33332,35004,38066,39350,39565,40767,40343,42532,46853,54447,61833,67069,64627,67894,70244,72905,77616,84289,91972,92966,93019,91673,91915,89533,92566,93780,91827,91676,90477,81529,75822};
    
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.transportation budgetValues] setObject:[NSNumber numberWithDouble:TotalTransportation[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.transportation budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Groundtransportation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Airtransportation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Watertransportation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Othertransportation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.transportation subBudgetValues] setObject:subValues forKey:[[self.transportation budgetSubCategories] objectAtIndex:i]];
    }
    
    //Community Development
    [self.commDev setMyType:CommDev];
    [self.commDev setBudgetName:@"Community Development"];
    [[self.commDev budgetSubCategories] addObject:@"Community"];
    [[self.commDev budgetSubCategories] addObject:@"Area and Regional"];
    [[self.commDev budgetSubCategories] addObject:@"Disater Relief"];
    //now we can add scenkit 3d text labels
    [self.commDev MakeLabels];
    aYear = 1962;
    const int Communitydevelopment[] = {266,233,316,413,423,580,649,833,1449,1728,2100,2044,2108,2318,2772,896,3411,3298,4000,4907,5070,4608,4353,4520,4598,4094,3679,3448,3693,3530,3543,3643,3681,4133,4744,4860,4962,5118,5116,5480,5313,5998,6346,6167,5861,5845,11834,10198,7719,9901,9605,8769,7814,7896,7817,7095,7778,8028,6208,3284,2284,2101};
    const int Areaandregionaldevelopment[] = {179,307,592,648,448,450,613,679,685,835,928,981,1339,1607,2149,563,2961,5672,4868,4303,3818,3841,3212,3034,3113,2723,1599,2075,1894,2902,2745,2317,2541,2337,2723,2727,2741,2512,2327,2538,2634,2633,2397,2351,2745,2580,2514,2584,3221,3249,4050,4424,1540,3027,3861,2451,2992,3353,2760,2467,1940,2083};
    const int Disasterreliefandinsurance[] = {23,34,25,53,234,78,120,40,257,353,396,1580,782,398,522,111,649,2871,1611,2043,1680,-102,-1,119,-35,416,-229,-230,-226,2098,522,876,2924,4150,3279,3154,3346,2141,4422,2605,3826,4350,10107,7302,17656,46040,15219,11170,16736,10744,10228,11939,22982,9747,8991,10594,11297,11746,15415,14172,13824,10396};
    const int TotalCommunityandRegionalDevelopment[] = {469,574,933,1114,1105,1108,1382,1552,2392,2917,3423,4605,4229,4322,5442,1569,7021,11841,10480,11252,10568,8347,7564,7673,7676,7233,5049,5293,5362,8531,6810,6836,9146,10620,10746,10741,11049,9771,11865,10623,11773,12981,18850,15820,26262,54465,29567,23952,27676,23894,23883,25132,32336,20670,20669,20140,22067,23127,24383,19923,18048,14580};
    
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.commDev budgetValues] setObject:[NSNumber numberWithDouble:TotalCommunityandRegionalDevelopment[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.commDev budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Communitydevelopment[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Areaandregionaldevelopment[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Disasterreliefandinsurance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.commDev subBudgetValues] setObject:subValues forKey:[[self.commDev budgetSubCategories] objectAtIndex:i]];
    }
    //educatrion social services
    [self.educationSocial setMyType:EducationSocial];
    [self.educationSocial setBudgetName:@"Education/Social Services"];
    [[self.educationSocial budgetSubCategories] addObject:@"Elementary"];
    [[self.educationSocial budgetSubCategories] addObject:@"Higher"];
    [[self.educationSocial budgetSubCategories] addObject:@"Research"];
    [[self.educationSocial budgetSubCategories] addObject:@"Training"];
    [[self.educationSocial budgetSubCategories] addObject:@"Other"];
    [[self.educationSocial budgetSubCategories] addObject:@"Social Services"];
    //now we can add scenkit 3d text labels
    [self.educationSocial MakeLabels];
    aYear = 1962;
    const int Elementarysecondaryandvocationaleducation[] = {482,553,579,719,1627,2310,2516,2470,2893,3333,3686,3573,3573,4349,4200,1074,4638,5186,6123,6893,7099,6722,6258,6483,7598,7802,7869,8377,9150,9918,11372,12402,13481,14258,14694,14871,15073,16606,17589,20578,22858,25879,31473,34360,38271,39710,38427,38918,53206,73261,66476,47492,42407,40813,40022,39779,40995,40450,37755,37041,36654,36654};
    const int Highereducation[] = {328,426,382,413,706,1161,1394,1234,1387,1435,1448,1534,1451,2182,2813,744,3200,3710,5030,6723,8767,7116,7184,7318,8156,8359,7361,8244,10584,11107,11961,11268,14474,7875,14172,12191,12298,12070,10672,10115,9568,17049,22697,25264,31442,50471,24637,23566,-3258,20908,1108,12113,-525,20104,51341,38764,72001,26455,29768,27651,27769,25939};
    const int Researchandgeneraleducationaids[] = {58,55,62,92,122,156,240,210,355,295,319,429,621,790,783,180,894,1033,1157,1212,1171,1211,1155,1330,1228,1265,1358,1368,1507,1572,1775,1995,2053,2098,2128,2228,2150,2280,2333,2543,2728,2950,2992,3031,3124,2998,3153,3194,3456,3631,3710,3704,3705,3552,3493,3529,3529,3034,2859,2810,2795,2790};
    const int Trainingandemployment[] = {189,203,291,528,983,1233,1582,1560,1602,1952,2894,3283,2910,4063,6288,1912,6877,10784,10833,10345,9241,5464,5295,4644,4972,5257,5084,5215,5292,5619,5934,6479,6700,7097,7430,7030,6681,6636,6783,6777,7192,8354,8379,7918,6852,7199,7080,7181,7652,9854,9139,7779,7271,7013,7103,7027,7573,7088,5680,5250,5155,5048};
    const int Otherlaborservices[] = {74,84,72,97,101,107,112,122,135,157,184,202,219,259,301,83,374,410,488,551,587,589,599,639,678,672,675,739,786,810,788,884,948,958,965,925,1009,1036,1076,1194,1268,1433,1473,1546,1615,1631,1635,1623,1646,1765,1869,1868,1888,1834,1799,1878,1963,1862,1818,1797,1802,1790};
    const int Socialservices[] = {110,137,169,291,823,1486,1791,1952,2263,2677,3998,3723,3682,4380,4526,1176,5121,5584,6588,6111,6281,5508,5703,6503,5957,6418,6572,6984,8007,8141,9401,9708,9718,10994,11631,11066,11761,11884,12152,12557,13480,14901,15573,15855,16251,16473,16724,16805,17047,19179,18931,17867,18062,17299,18303,18760,20935,17575,16798,16668,16437,16328};
    const int TotalEducationTrainingEmploymentandSocialServices[] = {1241,1458,1555,2140,4363,6453,7634,7548,8634,9849,12529,12744,12455,16022,18910,5169,21104,26706,30218,31835,33146,26609,26194,26916,28589,29773,28918,30928,35325,37167,41231,42735,47374,43281,51020,48311,48972,50512,50605,53764,57094,70566,82587,87974,97555,118482,91656,91287,79749,128598,101233,90823,72808,90615,122061,109737,146996,96464,94678,91217,90612,88549};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.educationSocial budgetValues] setObject:[NSNumber numberWithDouble:TotalEducationTrainingEmploymentandSocialServices[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.educationSocial budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Elementarysecondaryandvocationaleducation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Highereducation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Researchandgeneraleducationaids[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Trainingandemployment[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 4)
                    [subValues setObject:[NSNumber numberWithDouble:Otherlaborservices[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 5)
                    [subValues setObject:[NSNumber numberWithDouble:Socialservices[j]] forKey:[NSNumber numberWithInteger:aYear]];
            }
            aYear = aYear + 1;
        }
        //add category to dictionary
        [[self.educationSocial subBudgetValues] setObject:subValues forKey:[[self.educationSocial budgetSubCategories] objectAtIndex:i]];
    }
    //spaceTech
    [self.health setMyType:Health];
    [self.health setBudgetName:@"Health"];
    [[self.health budgetSubCategories] addObject:@"Care Services"];
    [[self.health budgetSubCategories] addObject:@"Research"];
    [[self.health budgetSubCategories] addObject:@"Safety"];
    //now we can add scenkit 3d text labels
    [self.health MakeLabels];
    aYear = 1962;
    const int Healthcareservices[] = {528,623,740,881,1486,2004,2694,3360,3993,4766,6205,6527,7707,9519,11725,2945,13031,13928,15988,18003,21205,21786,23008,24522,26984,28848,32614,36016,39158,47641,60722,77717,86858,94259,101912,106609,109962,116321,124494,136201,151874,172550,192573,210080,219559,220800,233878,247739,300013,330710,332210,308160,321849,374581,446367,474779,504744,494890,516065,474303,452243,454088};
    const int Healthresearchandtraining[] = {580,722,925,780,918,1184,1517,1599,1688,1801,2085,2423,2497,2779,3323,811,3524,3752,3607,4161,4615,4618,4552,4767,5375,5920,6153,7182,7865,8596,8886,10012,10781,10986,11569,10827,11847,13073,14383,15979,17926,21356,24044,27099,28050,28828,29279,29883,30570,34214,36198,34502,32881,30911,31400,31851,36143,32977,30212,28387,27992,27319};
    const int Consumerandoccupationalhealthandsafety[] = {89,106,123,130,138,163,179,203,226,277,383,406,529,632,686,168,747,844,899,1006,1047,1041,1081,1129,1182,1165,1197,1285,1356,1462,1560,1757,1762,1863,1918,1929,2023,2031,2171,2324,2433,2591,2924,2943,2939,3111,3225,2977,3752,4144,4096,4080,3585,3957,4463,4687,4778,4185,4119,4056,4024,3985};
    const int TotalHealth[] = {1198,1451,1788,1791,2543,3351,4390,5162,5907,6843,8674,9356,10733,12930,15734,3924,17302,18524,20494,23169,26866,27445,28641,30417,33541,35933,39964,44483,48380,57699,71168,89486,99401,107107,115399,119365,123832,131425,141048,154504,172233,196497,219541,240122,250548,252739,266382,280599,334335,369068,372504,346742,358315,409449,482230,511317,545665,532052,550396,506746,484259,485392};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.health budgetValues] setObject:[NSNumber numberWithDouble:TotalHealth[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.health budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Healthcareservices[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Healthresearchandtraining[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Consumerandoccupationalhealthandsafety[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.health subBudgetValues] setObject:subValues forKey:[[self.health budgetSubCategories] objectAtIndex:i]];
    }
    //spaceTech
    [self.medicare setMyType:Medicare];
    [self.medicare setBudgetName:@"Medicare"];
    //now we can add scenkit 3d text labels
    printf("Making labels\n");
    [self.medicare MakeLabels];
    aYear = 1962;
    const int Medicare[] = {64,64,64,64,64,2748,4649,5695,6213,6622,7479,8052,9639,12875,15834,4264,19345,22768,26495,32090,39149,46567,52588,57540,65822,70164,75120,78878,84964,98102,104489,119024,130552,144747,159855,174225,190016,192822,190447,197113,217384,230855,249433,269360,298638,329868,375407,390758,430093,451636,485653,471793,497826,511688,546202,594536,599677,588411,652362,706368,762248,858033};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.medicare budgetValues] setObject:[NSNumber numberWithDouble:Medicare[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    printf("MEDICARE DONE.\n");
    //incomeSecurity
    [self.incomeSecurity setMyType:IncomeSecurity];
    [self.incomeSecurity setBudgetName:@"Income Security"];
    [[self.incomeSecurity budgetSubCategories] addObject:@"Retirement and Disability"];
    [[self.incomeSecurity budgetSubCategories] addObject:@"Federal Retirement/Disability"];
    [[self.incomeSecurity budgetSubCategories] addObject:@"Unemployment"];
    [[self.incomeSecurity budgetSubCategories] addObject:@"Housing"];
    [[self.incomeSecurity budgetSubCategories] addObject:@"Food assistance"];
    [[self.incomeSecurity budgetSubCategories] addObject:@"Other"];
    //now we can add scenkit 3d text labels
    [self.incomeSecurity MakeLabels];
    aYear = 1962;
    const int Generalretirementanddisabilityinsurance[] = {661,632,682,668,736,731,944,1035,1032,1613,1812,2596,2750,4689,3248,1166,3558,3365,4373,5083,5439,5571,5581,5441,5617,5330,5565,5294,5650,5148,4945,5483,4347,5720,5106,5234,4721,4632,1878,5189,5761,5741,7047,6573,6976,4592,7829,8899,8218,6564,6697,7760,6969,8776,7805,3777,7333,2760,2977,3257,4430,5326};
    const int Federalemployeeretirementanddisability[] = {1959,2240,2554,2865,3326,3802,4285,4782,5545,6585,7684,8902,10783,13238,15484,4269,17735,19853,22676,26611,31296,34345,36530,38080,38621,41392,43782,46920,49202,52037,56151,57646,60093,62540,65882,68071,71539,73485,75146,77152,80972,83361,85154,88729,93351,98296,103916,108998,118119,119867,124447,122388,131739,134613,139166,144757,140802,139659,148210,152025,155708,165265};
    const int Unemploymentcompensation[] = {3809,3344,3178,2577,2215,2263,2527,2577,3359,6166,7072,5354,6065,13459,19453,4004,15315,11847,10813,18051,19656,23728,31464,18421,17475,17753,17080,15271,15616,18889,27084,39466,37802,28729,23638,24898,22888,22070,23631,23012,30242,53267,57054,44994,35435,33814,35107,45340,122537,160145,120556,93771,70729,45717,34978,35159,35857,37514,37913,41202,42939,44688};
    const int Housingassistance[] = {165,179,150,231,238,271,312,383,499,764,1125,1633,1826,2059,2499,662,2968,3682,4372,5640,7757,8741,10001,11273,25266,12386,12658,13909,14717,15907,17198,18944,21582,23941,27590,26837,27881,28828,27799,28949,30250,33251,35525,36790,37899,38295,39715,40556,50913,58651,55440,47948,46687,47615,47823,49076,49051,47887,46014,43588,42784,42081};
    const int Foodandnutritionassistance[] = {275,284,308,299,363,418,505,587,960,2179,3218,3641,4433,6643,7959,1824,8527,8926,10787,14016,16205,15581,17959,18103,18590,18652,18987,20132,21353,24131,28649,32787,35312,36892,37594,37933,36061,33585,33147,32483,34053,38150,42526,46012,50833,53928,54458,60673,79080,95110,103199,106871,109706,102936,104797,102300,102784,97813,97966,92826,92257,90517};
    const int Otherincomesecurity[] = {2338,2633,2785,2828,2799,2776,3243,3712,4260,5640,6740,6153,7856,10088,12156,3060,12957,13837,13361,17163,19951,20192,21506,22085,23464,25173,26065,28903,31050,32725,38605,45406,51002,59468,63996,66773,71945,75150,80877,86939,88496,98950,107326,109961,121353,123552,124950,166847,154357,181873,187010,162606,170681,173987,174274,179070,178083,170256,172991,176218,180333,188894};
    const int TotalIncomeSecurity[] = {9207,9311,9657,9469,9678,10261,11816,13076,15655,22946,27650,28278,33714,50176,60799,14985,61060,61509,66382,86565,100304,108158,123041,113405,129032,120685,124137,130430,137589,148838,172633,199732,210137,217290,223806,229746,235035,237750,242478,253724,269774,312720,334632,333059,345847,352477,365975,431313,533224,622210,597349,541344,536511,513644,508843,514139,513910,495889,506071,509116,518451,536771};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.incomeSecurity budgetValues] setObject:[NSNumber numberWithDouble:TotalIncomeSecurity[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.incomeSecurity budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Generalretirementanddisabilityinsurance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Federalemployeeretirementanddisability[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Unemploymentcompensation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Housingassistance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 4)
                    [subValues setObject:[NSNumber numberWithDouble:Foodandnutritionassistance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 5)
                    [subValues setObject:[NSNumber numberWithDouble:Otherincomesecurity[j]] forKey:[NSNumber numberWithInteger:aYear]];
            }
            aYear = aYear + 1;
        }
        //add category to dictionary
        [[self.incomeSecurity subBudgetValues] setObject:subValues forKey:[[self.incomeSecurity budgetSubCategories] objectAtIndex:i]];
    }
    //veterans
    [self.veterans setMyType:Veterans];
    [self.veterans setBudgetName:@"Veterans Benifits"];
    [[self.veterans budgetSubCategories] addObject:@"Income Security"];
    [[self.veterans budgetSubCategories] addObject:@"Education/Rehabilitation"];
    [[self.veterans budgetSubCategories] addObject:@"Hospital/Medical Care"];
    [[self.veterans budgetSubCategories] addObject:@"Housing"];
    [[self.veterans budgetSubCategories] addObject:@"Other"];
    //now we can add scenkit 3d text labels
    [self.veterans MakeLabels];
    aYear = 1962;
    const int Veteranseducationtrainingandrehabilitation[] = {151,95,71,52,51,300,470,691,1002,1644,1942,2781,3233,4561,5498,777,3683,3337,2725,2310,2226,1917,1598,1333,1029,496,424,424,426,245,393,746,788,1075,1082,1073,1113,1058,1222,1285,1193,1726,2106,2562,2790,2638,2713,2730,3495,8089,10683,10402,12893,13506,13383,14354,14568,14539,15382,16132,16828,17596};
    const int Hospitalandmedicalcareforveterans[] = {1084,1145,1229,1269,1318,1390,1468,1562,1798,2034,2423,2710,3004,3663,4044,1038,4706,5252,5611,6513,6964,7517,8272,8860,9546,9871,10266,10841,11342,12133,12889,14091,14812,15677,16428,16586,17093,17545,18168,19516,20959,22290,24082,26859,28754,29888,32294,36974,41882,45714,50062,50558,52521,56205,61897,65248,68004,72837,76459,77263,77223,77574};
    const int Veteranshousing[] = {242,-104,49,5,173,308,215,107,62,-171,-310,-368,-4,39,-58,-47,-131,43,176,-4,217,120,17,257,230,128,344,1305,892,530,100,917,1314,212,344,80,-327,853,580,364,-904,-1006,505,-1982,860,-1242,-868,-419,-578,540,1262,1413,1328,2143,743,804,-715,440,494,590,636,672};
    const int Otherveteransbenefitsandservices[] = {172,171,179,173,188,190,212,230,255,287,310,340,347,444,565,107,536,571,609,649,645,662,673,712,718,772,717,816,780,865,913,966,947,957,1015,989,969,935,1001,917,1228,1199,1200,1458,1949,2756,2995,4030,4678,4878,6435,6323,6306,6856,7355,7314,7844,8153,8045,7973,7907,7899};
    const int TotalVeteransBenefitsandServices[] = {5619,5514,5675,5716,5916,6735,7032,7631,8669,9768,10720,12003,13374,16584,18419,3960,18022,18961,19914,21169,22973,23938,24824,25575,26251,26314,26729,29367,30003,29034,31275,34037,35642,37559,37862,36956,39283,41741,43155,46989,44974,50929,56984,59746,70120,69811,72818,84653,95429,108384,127189,124595,138938,149616,159738,174516,174957,177897,194583,201913,209275,226248};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.veterans budgetValues] setObject:[NSNumber numberWithDouble:TotalVeteransBenefitsandServices[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.veterans budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Veteranseducationtrainingandrehabilitation[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Hospitalandmedicalcareforveterans[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Veteranshousing[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Otherveteransbenefitsandservices[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 4)
                    [subValues setObject:[NSNumber numberWithDouble:TotalVeteransBenefitsandServices[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.veterans subBudgetValues] setObject:subValues forKey:[[self.veterans budgetSubCategories] objectAtIndex:i]];
    }
    //social security
    //veterans
    [self.socialSecurity setMyType:SocialSecurity];
    [self.socialSecurity setBudgetName:@"Social Security"];
    //now we can add scenkit 3d text labels
    [self.socialSecurity MakeLabels];
    aYear = 1962;
    const int Socialsecurity[] = {14365,15788,16620,17460,20694,21725,23854,27298,30270,35872,40157,49090,55867,64658,73899,19763,85061,93861,104073,118547,139584,155964,170724,178223,188623,198756,207352,219341,232542,248623,269014,287584,304585,319565,335846,349671,365251,379215,390037,409423,432958,455980,474680,495548,523305,548549,586153,617027,682963,706737,730811,773290,813551,850533,887753,916067,951854,1010388,1075081,1142437,1210446,1284389};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.socialSecurity budgetValues] setObject:[NSNumber numberWithDouble:Socialsecurity[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //administration of justice
    [self.justice setMyType:Justice];
    [self.justice setBudgetName:@"Justice"];
    [[self.justice budgetSubCategories] addObject:@"Law Enforcement"];
    [[self.justice budgetSubCategories] addObject:@"Litigative and Judicial"];
    [[self.justice budgetSubCategories] addObject:@"Correctional"];
    [[self.justice budgetSubCategories] addObject:@"Criminal Justice Assistance"];
    //now we can add scenkit 3d text labels
    [self.justice MakeLabels];
    aYear = 1962;
    const int Federallawenforcementactivities[] = {269,288,306,333,355,389,409,470,571,693,843,1020,1129,1426,1604,436,1772,1944,2109,2357,2582,2667,3033,3356,3675,3764,4272,5235,4889,4840,5872,6687,6912,6873,6646,7324,8528,10420,11459,12121,12542,15408,15745,19131,19912,20039,20735,25574,28584,28713,29802,28977,27295,26106,26937,28886,34006,34293,34768,35641,37097,37968};
    const int Federallitigativeandjudicialactivities[] = {111,124,131,146,153,165,178,202,245,287,347,390,426,550,697,213,842,943,1130,1347,1491,1517,1627,1825,2064,2176,2482,2880,3255,3577,4352,5054,5336,5469,6115,6067,6317,6682,7427,7762,8298,9139,9889,10444,10658,11157,12110,13014,13372,14494,15076,16211,14764,14224,14717,14892,18444,16993,15678,15580,15315,15338};
    const int Federalcorrectionalactivities[] = {49,53,53,57,55,58,63,65,79,94,115,140,179,200,208,57,240,307,337,342,361,364,418,494,537,614,711,930,1044,1291,1600,2114,2124,2315,2749,3013,2939,2682,3204,3707,4206,4746,4580,4750,4845,5052,5172,5655,6009,6327,6546,6753,6761,6751,7049,6952,6953,7175,7185,7191,7197,7197};
    const int Criminaljusticeassistance[] = {0,0,0,0,1,6,8,29,65,233,380,624,770,853,921,213,847,729,710,656,473,294,167,136,150,181,250,352,455,477,663,795,822,859,998,1494,2833,3575,4446,4909,5155,5768,5126,11251,4604,4768,4345,3854,4616,4849,4632,4336,3781,3376,3203,5038,8405,6523,6399,5839,5287,5094};
    const int TotalAdministrationofJustice[] = {429,465,489,536,564,618,659,766,959,1307,1684,2174,2505,3028,3430,918,3701,3923,4286,4702,4908,4842,5246,5811,6426,6735,7715,9397,9644,10185,12486,14650,15193,15516,16508,17898,20617,23359,26536,28499,30201,35061,35340,45576,40019,41016,42362,48097,52581,54383,56056,56277,52601,50457,51906,55768,67808,64984,64030,64251,64896,65597};
    for(int i=0; i<62; i++) {
        if(i != 15) {
            [[self.justice budgetValues] setObject:[NSNumber numberWithDouble:TotalAdministrationofJustice[i]] forKey:[NSNumber numberWithInteger:aYear]];
            aYear = aYear + 1;
        }
    }
    //go over each subcategory
    for(int i=0; i<[[self.justice budgetSubCategories] count]; i++) {
        NSMutableDictionary *subValues = [NSMutableDictionary new];
        aYear = 1962;
        for(int j=0; j<62; j++) {
            if(j != 15) {
                if(i == 0)
                    [subValues setObject:[NSNumber numberWithDouble:Federallawenforcementactivities[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 1)
                    [subValues setObject:[NSNumber numberWithDouble:Federallitigativeandjudicialactivities[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 2)
                    [subValues setObject:[NSNumber numberWithDouble:Federalcorrectionalactivities[j]] forKey:[NSNumber numberWithInteger:aYear]];
                if(i == 3)
                    [subValues setObject:[NSNumber numberWithDouble:Criminaljusticeassistance[j]] forKey:[NSNumber numberWithInteger:aYear]];
                aYear = aYear + 1;
            }
        }
        //add category to dictionary
        [[self.justice subBudgetValues] setObject:subValues forKey:[[self.justice budgetSubCategories] objectAtIndex:i]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES animated:NO];
  
  // Run the view's session
  [self.sceneView.session runWithConfiguration: self.arConfig options: 0];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
    
  // Pause the view's session
  [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

- (void)setupScene {
  // Setup the ARSCNViewDelegate - this gives us callbacks to handle new
  // geometry creation
  self.sceneView.delegate = self;
  
  // A dictionary of all the current planes being rendered in the scene
  self.planes = [NSMutableDictionary new];
  
  // A list of all the cubes being rendered in the scene
  self.cubes = [NSMutableArray new];
  //self.posCubes = [NSMutableArray new];
  // Make things look pretty :)
  self.sceneView.antialiasingMode = SCNAntialiasingModeMultisampling4X;
  
  // This is the object that we add all of our geometry to, if you want
  // to render something you need to add it here
  SCNScene *scene = [SCNScene new];
  self.sceneView.scene = scene;
}

- (void)setupPhysics {
  
  // For our physics interactions, we place a large node a couple of meters below the world
  // origin, after an explosion, if the geometry we added has fallen onto this surface which
  // is place way below all of the surfaces we would have detected via ARKit then we consider
  // this geometry to have fallen out of the world and remove it
    
    
  SCNBox *bottomPlane = [SCNBox boxWithWidth:1000 height:0.5 length:1000 chamferRadius:0];
  SCNMaterial *bottomMaterial = [SCNMaterial new];
  
  // Make it transparent so you can't see it
  bottomMaterial.diffuse.contents = [UIColor colorWithWhite:1.0 alpha:0.0];
  bottomPlane.materials = @[bottomMaterial];
  SCNNode *bottomNode = [SCNNode nodeWithGeometry:bottomPlane];
  
  // Place it way below the world origin to catch all falling cubes
  bottomNode.position = SCNVector3Make(0, -2, 0);
  bottomNode.physicsBody = [SCNPhysicsBody
                            bodyWithType:SCNPhysicsBodyTypeKinematic
                            shape: nil];
  bottomNode.physicsBody.categoryBitMask = CollisionCategoryBottom;
  bottomNode.physicsBody.contactTestBitMask = CollisionCategoryCube;
  
  SCNScene *scene = self.sceneView.scene;
  [scene.rootNode addChildNode:bottomNode];
  scene.physicsWorld.contactDelegate = self;
    
}

- (void)setupLights {
  // Turn off all the default lights SceneKit adds since we are handling it ourselves
  self.sceneView.autoenablesDefaultLighting = NO;
  self.sceneView.automaticallyUpdatesLighting = NO;
  
  UIImage *env = [UIImage imageNamed: @"./Assets.scnassets/Environment/spherical.jpg"];
  self.sceneView.scene.lightingEnvironment.contents = env;
  
  //TODO: wantsHdr
}

- (void)setupRecognizers {
  // Single tap will insert a new piece of geometry into the scene
  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insertCubeFrom:)];
  tapGestureRecognizer.numberOfTapsRequired = 1;
  [self.sceneView addGestureRecognizer:tapGestureRecognizer];
  
  // Press and hold will open a config menu for the selected geometry
  UILongPressGestureRecognizer *materialGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(geometryConfigFrom:)];
  materialGestureRecognizer.minimumPressDuration = 0.5;
  [self.sceneView addGestureRecognizer:materialGestureRecognizer];
  
    //for budget detail (does not work)
    //UILongPressGestureRecognizer *toggleBudgetDetail = [[UILongPressGestureRecognizer alloc] initWithTarget:self  action:@selector(toggleBudgetDetail:)];
    //toggleBudgetDetail.minimumPressDuration = 0.5;
    //[self.sceneView addGestureRecognizer:toggleBudgetDetail];
    
}

- (void)toggleBudgetDetail:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    // Perform a hit test using the screen coordinates to see if the user pressed on
    // any 3D geometry in the scene, if so we will open a config menu for that
    // geometry to customize the appearance
    
    CGPoint holdPoint = [recognizer locationInView:self.sceneView];
    NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:holdPoint
                                                          options:@{SCNHitTestBoundingBoxOnlyKey: @YES, SCNHitTestFirstFoundOnlyKey: @YES}];
    if (result.count == 0) {
        
        return;
    }
    
    SCNHitTestResult * hitResult = [result firstObject];
    SCNNode *node = hitResult.node;
    
    // We add all the geometry as children of the Plane/Cube SCNNode object, so we can
    // get the parent and see what type of geometry this is
    SCNNode *parentNode = node.parentNode;
    if ([parentNode isKindOfClass:[Cube class]]) {
        Cube *hitCube = (Cube*)parentNode;
        if(hitCube.myBType == Defense) {
            if([self.defense isCollapsed]) {
                [self.defense setIsCollapsed:false];
                [self refreshCubes];
                [self.defense RemoveAllLabels];
            } else {
                [self.defense setIsCollapsed:true];
                [self refreshCubes];
                [self.defense RemoveAllLabels];
            }
            
        }
        
        //[((Cube *)parentNode) changeMaterial];
    }
    if([parentNode isKindOfClass:[ScaleCube class]]) {
        ScaleCube *scCube = (ScaleCube*)parentNode;
        if(![scCube locked]) {
            [scCube setLocked:true];
            //printf("LOCKED SCALE CUBE!\n");
        } else {
            [scCube setLocked:false];
           // printf("UNLOCKED SCALE CUBE!\n");
        }
    }
    if([parentNode isKindOfClass:[Plane class]]) {
       // NSLog(@"PLANE CHANGE MTRL.");
        //make sure this isn't drop off floor
        [((Plane *)parentNode) changeMaterial];
    }
}


- (void)insertCubeFrom: (UITapGestureRecognizer *)recognizer {
  // Take the screen space tap coordinates and pass them to the hitTest method on the ARSCNView instance
  CGPoint tapPoint = [recognizer locationInView:self.sceneView];
  NSArray<ARHitTestResult *> *result = [self.sceneView hitTest:tapPoint types:ARHitTestResultTypeExistingPlane];
  
  // If the intersection ray passes through any plane geometry they will be returned, with the planes
  // ordered by distance from the camera
  if (result.count == 0) {
    return;
  }
  
  // If there are multiple hits, just pick the closest plane
  ARHitTestResult * hitResult = [result firstObject];
    if([self.config budgetsOn] == 0) {
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
       // SCNScene *money = [SCNScene sceneNamed:@"$100,000,000.scn"];
        SCNNode *mnode = [[self.money rootNode] childNodeWithName:@"SearsTower" recursively:YES];
        [mnode setPosition:position];
        
       // [[self.money rootNode] setPosition:position];
       // [mnode setScale:SCNVector3Make(self.scale*(3./14.),self.scale*(3./14.),self.scale*(3./14.))];
        [mnode setScale:SCNVector3Make(self.scale*(3./14.),self.scale*(3./14.),self.scale*(3./14.))];
        [self.sceneView.scene.rootNode addChildNode:mnode];
        
        //[self insertScalingCube:hitResult];
        
    } else {
        [self insertBudget:hitResult];
    }
}


- (void)geometryConfigFrom: (UILongPressGestureRecognizer *)recognizer {
  if (recognizer.state != UIGestureRecognizerStateBegan) {
    return;
  }
  
  // Perform a hit test using the screen coordinates to see if the user pressed on
  // any 3D geometry in the scene, if so we will open a config menu for that
  // geometry to customize the appearance
  
  CGPoint holdPoint = [recognizer locationInView:self.sceneView];
  NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:holdPoint
                                                        options:@{SCNHitTestBoundingBoxOnlyKey: @YES, SCNHitTestFirstFoundOnlyKey: @YES}];
  if (result.count == 0) {
      
    return;
  }
  
  SCNHitTestResult * hitResult = [result firstObject];
  SCNNode *node = hitResult.node;
  
  // We add all the geometry as children of the Plane/Cube SCNNode object, so we can
  // get the parent and see what type of geometry this is
  SCNNode *parentNode = node.parentNode;
  if ([parentNode isKindOfClass:[Cube class]]) {
      
    [((Cube *)parentNode) changeMaterial];
  } else {
      
    [((Plane *)parentNode) changeMaterial];
  }
}

- (void)hidePlanes {
  for(NSUUID *planeId in self.planes) {
    [self.planes[planeId] hide];
  }
}

- (void)disableTracking:(BOOL)disabled {
  // Stop detecting new planes or updating existing ones.
  
  if (disabled) {
    self.arConfig.planeDetection = ARPlaneDetectionNone;
      
  } else {
    self.arConfig.planeDetection = ARPlaneDetectionHorizontal;
  }
  
  [self.sceneView.session runWithConfiguration:self.arConfig];
}


- (void)insertBudgetBlocks:(BudgetData *)bd withBudgetValue:(float)bValue withBudgetName:(NSString *)bname withPosition:(SCNVector3)position
{
    int cubeCount = 0;
    int count = 0;
    SCNVector3 keepPosition;
    SCNVector3 firstPosition;
    keepPosition.x = position.x;
    keepPosition.y = position.y;
    keepPosition.z = position.z;
    Cube *keepCube;
    
    //NSMutableArray *theseCubes = [NSMutableArray new];
    
    double latestBudget = bValue;
    if(latestBudget < 0.0)
        latestBudget = latestBudget * -1.0;
    latestBudget = ((latestBudget*1000000.0)/100000000.0);
    if(latestBudget/27 > 1.0) {
        _blockSize = 3.0;
    } else {
        _blockSize = 1.0;
    }
    // if(latestBudget/1000.0 > 1.0) {
    //_blockSize = 3.0;
    //  }
    if(_blockSize == 1.0) {
        float partSize = latestBudget - floor(latestBudget);
        int numBlocks = 0;
        if(partSize > 0.0) {
            numBlocks = (int)latestBudget + 1;
        }
        count = 0;
        for(int y=0; y<3; y++) {
            for(int z=0; z<3; z++) {
                for(int x=0; x<3; x++) {
                    if(count < numBlocks) {
                        Cube *cube;
                        if(count == numBlocks-1) {
                            position.x = keepPosition.x + (_unitScalex*x*partSize);
                            position.y = keepPosition.y + (_unitScaley*y*partSize);
                            position.z = keepPosition.z + (_unitScalez*z*partSize);
                            cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize*partSize withMaterial:[Cube currentMaterial]];
                        } else {
                            position.x = keepPosition.x + (_unitScalex*x);
                            position.y = keepPosition.y + (_unitScaley*y);
                            position.z = keepPosition.z + (_unitScalez*z);
                            cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize withMaterial:[Cube currentMaterial]];
                        }
                        [cube setMyBType:[bd myType]];
                        [[[bd budgetCubes] objectForKey:bname] addObject:cube];
                        cubeCount++;
                        keepCube = cube;
                    }
                    count++;
                }
            }
        }
        [[bd lastPositions] addObject:keepCube];
    }
    if(_blockSize == 3.0) {
        
        float yHeight = latestBudget/(float)(_blockSize*_blockSize*_blockSize);
        float yLayers = yHeight/(float)(_blockSize*_blockSize);
        int yBlocks = 0;
        int lastTopBlocks = 0;
        float leftOver = 0.0;
        int numBigBlocks = 0;
        if(yLayers > 1.0 + (1.0/(_blockSize*_blockSize))) {
            yBlocks = (int)floor(yLayers);
            lastTopBlocks = (int)floor(yHeight) - ((int)floor(yLayers)*(_blockSize*_blockSize));
            leftOver = latestBudget - (floor(yHeight)*(_blockSize*_blockSize*_blockSize));
            numBigBlocks = yBlocks*(_blockSize*_blockSize);
        } else {
            yBlocks = 1;
            lastTopBlocks = 0;
            leftOver = latestBudget - (floor(yHeight)*(_blockSize*_blockSize*_blockSize));
            numBigBlocks = (int)floor(yHeight);
        }
        
        
        count = 0;
        
        for(int y=0; y<yBlocks; y++) {
            for(int z=0; z<3; z++) {
                for(int x=0; x<3; x++) {
                    if(count < numBigBlocks) {
                        position.x = keepPosition.x + (_unitScalex*x*_blockSize);
                        position.y = keepPosition.y + (_unitScaley*y*_blockSize);
                        position.z = keepPosition.z + (_unitScalez*z*_blockSize);
                        if(count == 0 && lastTopBlocks == 0) {
                            //this case will happen with budgets that don't make full _blockSize*_blockSize square
                            //there will be leftover that needs to know where firstblock was (mainly will happen in detail mode)
                            firstPosition.x = position.x;
                            firstPosition.y = position.y;
                            firstPosition.z = position.z;
                        }
                        Cube *cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize withMaterial:[Cube currentMaterial]];
                        [cube setMyBType:[bd myType]];
                        [[[bd budgetCubes] objectForKey:bname] addObject:cube];
                        cubeCount++;
                        keepCube = cube;
                    }
                    count++;
                }
            }
        }
        //   [[bd lastPositions] addObject:keepCube];
        SCNVector3 topStart;
        topStart.x = position.x - (_unitScalex*_blockSize*(_blockSize-1));
        topStart.y = position.y;
        topStart.z = position.z - (_unitScalez*_blockSize*(_blockSize-1));
        int tpc = 0;
        SCNVector3 nextPosition;
        if(lastTopBlocks > 0) {
            for(int y=1; y<2; y++) {
                for(int z=0; z<3; z++) {
                    for(int x=0; x<3; x++) {
                        if(tpc < lastTopBlocks) {
                            position.x = topStart.x + (_unitScalex*x*_blockSize);
                            position.y = topStart.y + (_unitScaley*y*_blockSize);
                            position.z = topStart.z + (_unitScalez*z*_blockSize);
                            Cube *cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize withMaterial:[Cube currentMaterial]];
                            [cube setMyBType:[bd myType]];
                            [[[bd budgetCubes] objectForKey:bname] addObject:cube];
                            cubeCount++;
                            keepCube = cube;
                            //compute next position for leftOver nested blocks
                            if(z < 2) {
                                if(x < 2) {
                                    //got to next x pos
                                    nextPosition.x = topStart.x + (_unitScalex*(x+1)*_blockSize);
                                    nextPosition.y = topStart.y + (_unitScaley*y*_blockSize);
                                    nextPosition.z = topStart.z + (_unitScalez*z*_blockSize);
                                } else {
                                    //go to next z pos
                                    nextPosition.x = topStart.x;
                                    nextPosition.y = topStart.y + (_unitScaley*y*_blockSize);
                                    nextPosition.z = topStart.z + (_unitScalez*(z+1)*_blockSize);
                                }
                            } else {
                                //got to next x pos
                                nextPosition.x = topStart.x + (_unitScalex*(x+1)*_blockSize);
                                nextPosition.y = topStart.y + (_unitScaley*y*_blockSize);
                                nextPosition.z = topStart.z + (_unitScalez*z*_blockSize);
                            }
                            tpc = tpc + 1;
                        }
                    }
                }
            }
            // [[bd lastPositions] addObject:keepCube];
        }
        //figure out Z size by taking square root of lastTopBlocks
        SCNVector3 newStartPos;
        if(lastTopBlocks > 0) {
            newStartPos.x = nextPosition.x - (_unitScalex*_blockSize)*0.333333;//((_unitScalex*_blockSize));
            newStartPos.y = nextPosition.y - (_unitScaley*_blockSize)*0.333333;
            newStartPos.z = nextPosition.z - (_unitScalez*_blockSize)*0.333333;//((_unitScalez*_blockSize));
        } else {
            newStartPos.x = firstPosition.x - (_unitScalex*_blockSize)*0.333333;
            newStartPos.y = firstPosition.y + 2.0*((_unitScaley*_blockSize)*0.333333);
            newStartPos.z = firstPosition.z - (_unitScalez*_blockSize)*0.333333;
        }
        count = 0;
        for(int y=0; y<3; y++) {
            for(int z=0; z<3; z++) {
                for(int x=0; x<3; x++) {
                    if(count < (int)leftOver) {
                        position.x = newStartPos.x + (_unitScalex*x);
                        position.y = newStartPos.y + (_unitScaley*y);
                        position.z = newStartPos.z + (_unitScalez*z);
                        
                        Cube *cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:1 withMaterial:[Cube currentMaterial]];
                        [cube setMyBType:[bd myType]];
                        [[[bd budgetCubes] objectForKey:bname] addObject:cube];
                        cubeCount++;
                        keepCube = cube;
                    }
                    count++;
                }
            }
        }
        [[bd lastPositions] addObject:keepCube];
    }
    
    //[[bd budgetCubes] setObject:theseCubes forKey:bname];
    // [bd setAnimationCount:0];
    // [self AnimateBudget:bd];
}


- (void)insertBudgetBlocks:(BudgetData *)bd withBudgetValue:(float)bValue withPosition:(SCNVector3)position
{
    int cubeCount = 0;
    int count = 0;
    SCNVector3 keepPosition;
    SCNVector3 firstPosition;
    keepPosition.x = position.x;
    keepPosition.y = position.y;
    keepPosition.z = position.z;
    Cube *keepCube;
    
    double latestBudget = bValue;
    if(latestBudget < 0.0)
        latestBudget = latestBudget * -1.0;
    latestBudget = ((latestBudget*1000000.0)/100000000.0);
    if(latestBudget/27 > 1.0) {
        _blockSize = 3.0;
    } else {
        _blockSize = 1.0;
    }
    // if(latestBudget/1000.0 > 1.0) {
    //_blockSize = 3.0;
    //  }
    if(_blockSize == 1.0) {
        float partSize = latestBudget - floor(latestBudget);
        int numBlocks = 0;
        if(partSize > 0.0) {
            numBlocks = (int)latestBudget + 1;
        }
        count = 0;
        for(int y=0; y<3; y++) {
            for(int z=0; z<3; z++) {
                for(int x=0; x<3; x++) {
                    if(count < numBlocks) {
                        Cube *cube;
                        if(count == numBlocks-1) {
                            position.x = keepPosition.x + (_unitScalex*x*partSize);
                            position.y = keepPosition.y + (_unitScaley*y*partSize);
                            position.z = keepPosition.z + (_unitScalez*z*partSize);
                            cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize*partSize withMaterial:[Cube currentMaterial]];
                        } else {
                            position.x = keepPosition.x + (_unitScalex*x);
                            position.y = keepPosition.y + (_unitScaley*y);
                            position.z = keepPosition.z + (_unitScalez*z);
                            cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize withMaterial:[Cube currentMaterial]];
                        }
                        [cube setMyBType:[bd myType]];
                        [[bd cubes] insertObject:cube atIndex:cubeCount];
                    
                        cubeCount++;
                        keepCube = cube;
                    }
                    count++;
                }
            }
        }
        [[bd lastPositions] addObject:keepCube];
    }
    if(_blockSize == 3.0) {
       
        float yHeight = latestBudget/(float)(_blockSize*_blockSize*_blockSize);
        float yLayers = yHeight/(float)(_blockSize*_blockSize);
        int yBlocks = 0;
        int lastTopBlocks = 0;
        float leftOver = 0.0;
        int numBigBlocks = 0;
        if(yLayers > 1.0 + (1.0/(_blockSize*_blockSize))) {
            yBlocks = (int)floor(yLayers);
            lastTopBlocks = (int)floor(yHeight) - ((int)floor(yLayers)*(_blockSize*_blockSize));
            leftOver = latestBudget - (floor(yHeight)*(_blockSize*_blockSize*_blockSize));
            numBigBlocks = yBlocks*(_blockSize*_blockSize);
        } else {
            yBlocks = 1;
            lastTopBlocks = 0;
            leftOver = latestBudget - (floor(yHeight)*(_blockSize*_blockSize*_blockSize));
            numBigBlocks = (int)floor(yHeight);
        }
       
        
        count = 0;
        
        for(int y=0; y<yBlocks; y++) {
            for(int z=0; z<3; z++) {
                for(int x=0; x<3; x++) {
                    if(count < numBigBlocks) {
                        position.x = keepPosition.x + (_unitScalex*x*_blockSize);
                        position.y = keepPosition.y + (_unitScaley*y*_blockSize);
                        position.z = keepPosition.z + (_unitScalez*z*_blockSize);
                        if(count == 0 && lastTopBlocks == 0) {
                            //this case will happen with budgets that don't make full _blockSize*_blockSize square
                            //there will be leftover that needs to know where firstblock was (mainly will happen in detail mode)
                            firstPosition.x = position.x;
                            firstPosition.y = position.y;
                            firstPosition.z = position.z;
                        }
                        Cube *cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize withMaterial:[Cube currentMaterial]];
                        [cube setMyBType:[bd myType]];
                        [[bd cubes] insertObject:cube atIndex:cubeCount];
                        cubeCount++;
                        keepCube = cube;
                    }
                    count++;
                }
            }
        }
     //   [[bd lastPositions] addObject:keepCube];
        SCNVector3 topStart;
        topStart.x = position.x - (_unitScalex*_blockSize*(_blockSize-1));
        topStart.y = position.y;
        topStart.z = position.z - (_unitScalez*_blockSize*(_blockSize-1));
        int tpc = 0;
        SCNVector3 nextPosition;
        if(lastTopBlocks > 0) {
        for(int y=1; y<2; y++) {
            for(int z=0; z<3; z++) {
                for(int x=0; x<3; x++) {
                    if(tpc < lastTopBlocks) {
                        position.x = topStart.x + (_unitScalex*x*_blockSize);
                        position.y = topStart.y + (_unitScaley*y*_blockSize);
                        position.z = topStart.z + (_unitScalez*z*_blockSize);
                        Cube *cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:_blockSize withMaterial:[Cube currentMaterial]];
                        [cube setMyBType:[bd myType]];
                        [[bd cubes] insertObject:cube atIndex:cubeCount];
                        cubeCount++;
                        keepCube = cube;
                        //compute next position for leftOver nested blocks
                        if(z < 2) {
                            if(x < 2) {
                                //got to next x pos
                                nextPosition.x = topStart.x + (_unitScalex*(x+1)*_blockSize);
                                nextPosition.y = topStart.y + (_unitScaley*y*_blockSize);
                                nextPosition.z = topStart.z + (_unitScalez*z*_blockSize);
                            } else {
                                //go to next z pos
                                nextPosition.x = topStart.x;
                                nextPosition.y = topStart.y + (_unitScaley*y*_blockSize);
                                nextPosition.z = topStart.z + (_unitScalez*(z+1)*_blockSize);
                            }
                        } else {
                            //got to next x pos
                            nextPosition.x = topStart.x + (_unitScalex*(x+1)*_blockSize);
                            nextPosition.y = topStart.y + (_unitScaley*y*_blockSize);
                            nextPosition.z = topStart.z + (_unitScalez*z*_blockSize);
                        }
                        tpc = tpc + 1;
                    }
                }
            }
        }
           // [[bd lastPositions] addObject:keepCube];
        }
        //figure out Z size by taking square root of lastTopBlocks
        SCNVector3 newStartPos;
        if(lastTopBlocks > 0) {
            newStartPos.x = nextPosition.x - (_unitScalex*_blockSize)*0.333333;//((_unitScalex*_blockSize));
            newStartPos.y = nextPosition.y - (_unitScaley*_blockSize)*0.333333;
            newStartPos.z = nextPosition.z - (_unitScalez*_blockSize)*0.333333;//((_unitScalez*_blockSize));
        } else {
            newStartPos.x = firstPosition.x - (_unitScalex*_blockSize)*0.333333;
            newStartPos.y = firstPosition.y + 2.0*((_unitScaley*_blockSize)*0.333333);
            newStartPos.z = firstPosition.z - (_unitScalez*_blockSize)*0.333333;
        }
        count = 0;
        for(int y=0; y<3; y++) {
            for(int z=0; z<3; z++) {
                for(int x=0; x<3; x++) {
                    if(count < (int)leftOver) {
                        position.x = newStartPos.x + (_unitScalex*x);
                        position.y = newStartPos.y + (_unitScaley*y);
                        position.z = newStartPos.z + (_unitScalez*z);
                        
                        Cube *cube = [[Cube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:_scale withBlockSize:1 withMaterial:[Cube currentMaterial]];
                        [cube setMyBType:[bd myType]];
                        [[bd cubes] insertObject:cube atIndex:cubeCount];
                        cubeCount++;
                        keepCube = cube;
                    }
                    count++;
                }
            }
        }
        [[bd lastPositions] addObject:keepCube];
    }
   // [bd setAnimationCount:0];
   // [self AnimateBudget:bd];
}

- (void)insertBudgetCubesNoAnimate:(BudgetData *)bd withPosition:(SCNVector3)position
{
    if([bd isCollapsed]) {
        NSNumber *lt = [[bd budgetValues] objectForKey:[NSNumber numberWithInteger:self.currentYear]];
        double latestBudget = [lt doubleValue];
        // [self insertBudgetBlocks:bd withBudgetValue:latestBudget withPosition:position];
        [self insertBudgetBlocks:bd withBudgetValue:latestBudget withBudgetName:[bd budgetName] withPosition:position];
        [bd GetMinMaxExtents:[bd budgetName]];
        
        // [bd setAnimationCount:0];
        [[bd animationCounts] setObject:[NSNumber numberWithInt:0] forKey:[bd budgetName]];
    }
}

- (void)insertBudgetCubes:(BudgetData *)bd withPosition:(SCNVector3)position
{
    if([bd isCollapsed]) {
        NSNumber *lt = [[bd budgetValues] objectForKey:[NSNumber numberWithInteger:self.currentYear]];
        double latestBudget = [lt doubleValue];
       // [self insertBudgetBlocks:bd withBudgetValue:latestBudget withPosition:position];
        [self insertBudgetBlocks:bd withBudgetValue:latestBudget withBudgetName:[bd budgetName] withPosition:position];
        [bd GetMinMaxExtents:[bd budgetName]];
        
       // [bd setAnimationCount:0];
        [[bd animationCounts] setObject:[NSNumber numberWithInt:0] forKey:[bd budgetName]];
        [self AnimateBudget:bd withName:[bd budgetName] withCount:0];
    } else {
        
        float squareCats = sqrt((double)[[bd budgetSubCategories] count]);
        squareCats = ceil(squareCats);
        int count = 0;
        //float keepPositionZ = 0.0;
        for(int i=0; i<(int)squareCats; i++) {
            if(i > 0) {
                position.z = [[[bd budgetZmax] objectForKey:[[bd budgetSubCategories] objectAtIndex:count-1]] floatValue] + (4.0*(_unitScalez));
                position.x = [[[bd budgetXmin] objectForKey:[[bd budgetSubCategories] objectAtIndex:0]] floatValue] + (4.0*(_unitScalex));
            }
            for(int j=0; j<(int)squareCats; j++) {
                if(count < [[bd budgetSubCategories] count]) {
                    NSMutableDictionary *subDict = [[bd subBudgetValues] objectForKey:[[bd budgetSubCategories] objectAtIndex:count]];
                    NSNumber *lt = [subDict objectForKey:[NSNumber numberWithInteger:self.currentYear]];
                    double latestBudget = [lt doubleValue];
                    [self insertBudgetBlocks:bd withBudgetValue:latestBudget withBudgetName:[[bd budgetSubCategories] objectAtIndex:count] withPosition:position];
                    [bd GetMinMaxExtents:[[bd budgetSubCategories] objectAtIndex:count]];
                    position.x = [[[bd budgetXmax] objectForKey:[[bd budgetSubCategories] objectAtIndex:count]] floatValue] + (4.0*(_unitScalex));
                   
                
                    [[bd animationCounts] setObject:[NSNumber numberWithInt:0] forKey:[[bd budgetSubCategories] objectAtIndex:count]];
                    [self AnimateBudget:bd withName:[[bd budgetSubCategories] objectAtIndex:count] withCount:count];
                }
                count++;
            }
        }
    }
 
}

- (void)insertScalingCube:(ARHitTestResult *)hitResult
{
    SCNVector3 position = SCNVector3Make(
                                         hitResult.worldTransform.columns[3].x,
                                         hitResult.worldTransform.columns[3].y,
                                         hitResult.worldTransform.columns[3].z
                                         );
    self.myScalingCube = [[ScaleCube alloc] initAtPosition:position withmass:1.0 withbtype:0 withScale:0.1 withBlockSize:_blockSize withMaterial:[ScaleCube currentMaterial]];
    [self.myScalingCube setLocked:false];
    [self.myScalingCube setMyBType:ScalerCube];
    [self.sceneView.scene.rootNode addChildNode:self.myScalingCube];
    
}

- (void)insertBudget:(ARHitTestResult *)hitResult
{
    
    if([_defense readyToDisplay]) {
        
        [_defense setReadyToDisplay:false];
        [_defense setIsDisplayed:true];
        [_defense setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.defense setInitialPosition:position];
        [self insertBudgetCubes:_defense withPosition:position];
    } else if([_internationalAffairs readyToDisplay]) {
    
        
        [_internationalAffairs setReadyToDisplay:false];
        [_internationalAffairs setIsDisplayed:true];
        [_internationalAffairs setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.internationalAffairs setInitialPosition:position];
        [self insertBudgetCubes:_internationalAffairs withPosition:position];
    } else if([_energy readyToDisplay]) {
        
        [_energy setReadyToDisplay:false];
        [_energy setIsDisplayed:true];
        [_energy setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.energy setInitialPosition:position];
        [self insertBudgetCubes:_energy withPosition:position];
    } else if([_naturalResources readyToDisplay]) {
        
        [_naturalResources setReadyToDisplay:false];
        [_naturalResources setIsDisplayed:true];
        [_naturalResources setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.naturalResources setInitialPosition:position];
        [self insertBudgetCubes:_naturalResources withPosition:position];
    } else if ([_spaceTech readyToDisplay]) {
        [_spaceTech setReadyToDisplay:false];
        [_spaceTech setIsDisplayed:true];
        [_spaceTech setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.spaceTech setInitialPosition:position];
        [self insertBudgetCubes:_spaceTech withPosition:position];
    } else if([_agriculture readyToDisplay]) {
        [_agriculture setReadyToDisplay:false];
        [_agriculture setIsDisplayed:true];
        [_agriculture setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.agriculture setInitialPosition:position];
        [self insertBudgetCubes:_agriculture withPosition:position];
    } else if([_commerceHousing readyToDisplay]) {
        [_commerceHousing setReadyToDisplay:false];
        [_commerceHousing setIsDisplayed:true];
        [_commerceHousing setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.commerceHousing setInitialPosition:position];
        [self insertBudgetCubes:_commerceHousing withPosition:position];
    } else if([_transportation readyToDisplay]) {
        [_transportation setReadyToDisplay:false];
        [_transportation setIsDisplayed:true];
        [_transportation setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.transportation setInitialPosition:position];
        [self insertBudgetCubes:_transportation withPosition:position];
    } else if([_commDev readyToDisplay]) {
        [_commDev setReadyToDisplay:false];
        [_commDev setIsDisplayed:true];
        [_commDev setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.commDev setInitialPosition:position];
        [self insertBudgetCubes:_commDev withPosition:position];
    } else if([_educationSocial readyToDisplay]) {
        [_educationSocial setReadyToDisplay:false];
        [_educationSocial setIsDisplayed:true];
        [_educationSocial setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.educationSocial setInitialPosition:position];
        [self insertBudgetCubes:_educationSocial withPosition:position];
    } else if([_health readyToDisplay]) {
        [_health setReadyToDisplay:false];
        [_health setIsDisplayed:true];
        [_health setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.health setInitialPosition:position];
        [self insertBudgetCubes:_health withPosition:position];
    } else if([_medicare readyToDisplay]) {
        [_medicare setReadyToDisplay:false];
        [_medicare setIsDisplayed:true];
        [_medicare setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.medicare setInitialPosition:position];
        [self insertBudgetCubes:_medicare withPosition:position];
    } else if([_incomeSecurity readyToDisplay]) {
        [_incomeSecurity setReadyToDisplay:false];
        [_incomeSecurity setIsDisplayed:true];
        [_incomeSecurity setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.incomeSecurity setInitialPosition:position];
        [self insertBudgetCubes:_incomeSecurity withPosition:position];
    } else if([_socialSecurity readyToDisplay]) {
        [_socialSecurity setReadyToDisplay:false];
        [_socialSecurity setIsDisplayed:true];
        [_socialSecurity setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.socialSecurity setInitialPosition:position];
        [self insertBudgetCubes:_socialSecurity withPosition:position];
    } else if([_veterans readyToDisplay]) {
        [_veterans setReadyToDisplay:false];
        [_veterans setIsDisplayed:true];
        [_veterans setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.veterans setInitialPosition:position];
        [self insertBudgetCubes:_veterans withPosition:position];
    } else if([_justice readyToDisplay]) {
        [_justice setReadyToDisplay:false];
        [_justice setIsDisplayed:true];
        [_justice setIsCollapsed:true];
        
        SCNVector3 position = SCNVector3Make(
                                             hitResult.worldTransform.columns[3].x,
                                             hitResult.worldTransform.columns[3].y,
                                             hitResult.worldTransform.columns[3].z
                                             );
        [self.justice setInitialPosition:position];
        [self insertBudgetCubes:_justice withPosition:position];
    }
}

- (void)ResetActiveBudgetAnimationCounts
{
    for(NSNumber *bdType in [self.config activeBudgets]) {
        uint bdv = [bdType intValue];
        BudgetData *bd = [self GetAnimationBudget:bdv];
        [[bd animationCounts] setObject:[NSNumber numberWithInt:0] forKey:[bd budgetName]];
    }
}

- (BudgetData *)GetAnimationBudget:(BudgetType)bType
{
    BudgetData *aBudget = nil;
    switch (bType) {
        case Defense:
            aBudget = self.defense;
            break;
        case InternationalAffairs:
            aBudget = self.internationalAffairs;
            break;
        case Energy:
            aBudget = self.energy;
            break;
        case NaturalResources:
            aBudget = self.naturalResources;
            break;
        case SpaceTech:
            aBudget = self.spaceTech;
            break;
        case Agriculture:
            aBudget = self.agriculture;
            break;
        case CommerceHousing:
            aBudget = self.commerceHousing;
            break;
        case Transportation:
            aBudget = self.transportation;
            break;
        case CommDev:
            aBudget = self.commDev;
            break;
        case EducationSocial:
            aBudget = self.educationSocial;
            break;
        case Health:
            aBudget = self.health;
            break;
        case Medicare:
            aBudget = self.medicare;
            break;
        case IncomeSecurity:
            aBudget = self.incomeSecurity;
            break;
        case SocialSecurity:
            aBudget = self.socialSecurity;
            break;
        case Veterans:
            aBudget = self.veterans;
            break;
        case Justice:
            aBudget = self.justice;
            break;
        default:
            break;
    }
    
    return aBudget;
}
- (void)AnimateAllBudgets
{
    
    if(self.animateAllBudgets) {
    BudgetType budgetId = [[[self.config activeBudgets] objectAtIndex:self.currentAnimBudget] intValue];
    BudgetData *bd = [self GetAnimationBudget:budgetId];
    NSString *bname = [bd budgetName];
   //     NSLog(@"ANimating budget: %d %@ and %d\n",budgetId,bname,[[[bd animationCounts] objectForKey:bname] intValue]);
    uint cnt = 0;
    if([[[bd animationCounts] objectForKey:bname] intValue] < [[[bd budgetCubes] objectForKey:bname] count]) {
        // Cube *aCube = [[bd cubes] objectAtIndex:[bd animationCount]];
        Cube *aCube = [[[bd budgetCubes] objectForKey:bname] objectAtIndex:[[[bd animationCounts] objectForKey:bname] intValue]];
        SCNVector3 startPos = SCNVector3Make([[aCube node] position].x, [[aCube node] position].y-(_unitScaley*_blockSize), [[aCube node] position].z);
        SCNVector3 keepPosition  = SCNVector3Make([[aCube node] position].x, [[aCube node] position].y, [[aCube node] position].z);
        
        [[aCube node] setPosition:startPos];
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.1];
        [SCNTransaction setCompletionBlock: ^{ [self AnimateAllBudgets];}];
        [self.sceneView.scene.rootNode addChildNode:aCube];
        [[aCube node] setPosition:keepPosition];
        [SCNTransaction commit];
        int animCount = [[[bd animationCounts] objectForKey:bname] intValue];
        // printf("ANIMCOUNT: %d numCubes: %d\n",animCount,[[[bd budgetCubes] objectForKey:bname] count]);
        [[bd animationCounts] setObject:[NSNumber numberWithInt:animCount+1] forKey:bname];
        // [bd setAnimationCount:[bd animationCount] + 1];
        //} else {
        if([[[bd animationCounts] objectForKey:bname] intValue] == 1) {
            int lc = 0;
            double latestBudget;
            if([bd isCollapsed]) {
                lc = 1;
                NSNumber *lt = [[bd budgetValues] objectForKey:[NSNumber numberWithInteger:self.currentYear]];
                latestBudget = [lt doubleValue];
                latestBudget = ((latestBudget*1000000.0)/1000000000.0);
                [bd SetYearLabel:self.currentYear];
                [bd SetMoneyLabel:0 withValue:latestBudget];
                SCNNode *myNode = [[bd myBudgetLabels] objectAtIndex:0];
                SCNNode *myMoneyNode = [[bd myMoneyLabels] objectAtIndex:0];
                // Cube *aCube = [[bd lastPositions] objectAtIndex:0];
                //Cube *aCube = [[bd budgetCubes] objectForKey:[bd budgetName]];
                [bd GetMinMaxExtents:[bd budgetName]];
                float labelX = ([[[bd budgetXmax] objectForKey:[bd budgetName]] floatValue] + [[[bd budgetXmin] objectForKey:[bd budgetName]] floatValue])/2.0;
                float labelY = [[[bd budgetYmax] objectForKey:[bd budgetName]] floatValue] + (4.0*(_unitScaley*_blockSize));
                float labelZ = ([[[bd budgetZmax] objectForKey:[bd budgetName]] floatValue] + [[[bd budgetZmin] objectForKey:[bd budgetName]] floatValue])/2.0;
                // SCNVector3 textPos = SCNVector3Make([[self.labelPositionsX objectAtIndex:0] floatValue],[[self.labelPositionsY objectAtIndex:0] floatValue],[[self.labelPositionsZ objectAtIndex:0] floatValue]);
                SCNVector3 textPos = SCNVector3Make(labelX,labelY,labelZ);
                
                //textPos.y = textPos.y + 0.5*(maxBound.y-minBound.y);
                textPos.y = textPos.y + (self.scale*self.unitScaley);
                [myMoneyNode setPosition:textPos];
                textPos.y = textPos.y + ((self.scale*self.unitScaley)*200);
                [myNode setPosition:textPos];
                textPos.y = textPos.y + ((self.scale*self.unitScaley)*200);
                [[bd myYearLabel] setPosition:textPos];
                [myNode setScale:SCNVector3Make(0.002, 0.002, 0.002)];
                [myMoneyNode setScale:SCNVector3Make(0.002, 0.002, 0.002)];
                [[bd myYearLabel] setScale:SCNVector3Make(0.002, 0.002, 0.002)];
                [self.sceneView.scene.rootNode addChildNode:myNode];
                [self.sceneView.scene.rootNode addChildNode:myMoneyNode];
                [self.sceneView.scene.rootNode addChildNode:[bd myYearLabel]];
                
            } else {
                //for(int i=0; i<[[bd budgetSubCategories] count]; i++) {
                NSMutableDictionary *subDict = [[bd subBudgetValues] objectForKey:bname];
                NSNumber *lt = [subDict objectForKey:[NSNumber numberWithInteger:self.currentYear]];
                //  NSLog(@"Sub Bud Name: %@ %d\n",[[bd budgetSubCategories] objectAtIndex:i],i);
                latestBudget = [lt doubleValue];
                latestBudget = ((latestBudget*1000000.0)/1000000000.0);
                [bd SetYearLabel:self.currentYear];
                [bd SetMoneyLabel:cnt withValue:latestBudget];
                
                //get node from BudgetData object
                SCNNode *myNode = [[bd myBudgetLabels] objectAtIndex:cnt+1];
                SCNNode *myMoneyNode = [[bd myMoneyLabels] objectAtIndex:cnt+1];
                [bd GetMinMaxExtents:bname];
                float labelX = ([[[bd budgetXmax] objectForKey:bname] floatValue] + [[[bd budgetXmin] objectForKey:bname] floatValue])/2.0;
                float labelY = [[[bd budgetYmax] objectForKey:bname] floatValue] + (4.0*(_unitScaley));
                float labelZ = ([[[bd budgetZmax] objectForKey:bname] floatValue] + [[[bd budgetZmin] objectForKey:bname] floatValue])/2.0;
                // Cube *aCube = [[bd lastPositions] objectAtIndex:cnt];
                
                SCNVector3 textPos = SCNVector3Make(labelX,labelY,labelZ);
                
                // SCNVector3 textPos = SCNVector3Make([[self.labelPositionsX objectAtIndex:i] floatValue],[[self.labelPositionsY objectAtIndex:i] floatValue],[[self.labelPositionsZ objectAtIndex:i] floatValue]);
                //textPos.y = textPos.y + 0.5*(maxBound.y-minBound.y);
                textPos.y = textPos.y + (self.scale*self.unitScaley);
                [myMoneyNode setPosition:textPos];
                textPos.y = textPos.y + ((self.scale*self.unitScaley)*100);
                [myNode setPosition:textPos];
                textPos.y = textPos.y + ((self.scale*self.unitScaley)*100);
                [[bd myYearLabel] setPosition:textPos];
                [myNode setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                [myMoneyNode setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                [[bd myYearLabel] setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                [self.sceneView.scene.rootNode addChildNode:myNode];
                [self.sceneView.scene.rootNode addChildNode:myMoneyNode];
                [self.sceneView.scene.rootNode addChildNode:[bd myYearLabel]];
                //}
                
            }
        }
        
    } else {
        self.currentAnimBudget = self.currentAnimBudget + 1;
        if(self.currentAnimBudget == [[self.config activeBudgets] count]) {
            self.currentAnimBudget = 0;
            if(self.currentYear != 2016) {
                self.currentYear = self.currentYear+1;
            } else {
                self.currentYear = 1962;
            }
            [self refreshCubesNoAnimate];
        }
        if(self.animateAllBudgets)
            [self AnimateAllBudgets];
    }
    }//end self.animateAllBudgets;
}

- (void)AnimateBudget:(BudgetData *)bd withName:(NSString *)bname withCount:(int)cnt
{
    if([[[bd animationCounts] objectForKey:bname] intValue] < [[[bd budgetCubes] objectForKey:bname] count]) {
        // Cube *aCube = [[bd cubes] objectAtIndex:[bd animationCount]];
        Cube *aCube = [[[bd budgetCubes] objectForKey:bname] objectAtIndex:[[[bd animationCounts] objectForKey:bname] intValue]];
        SCNVector3 startPos = SCNVector3Make([[aCube node] position].x, [[aCube node] position].y-(_unitScaley*_blockSize), [[aCube node] position].z);
        SCNVector3 keepPosition  = SCNVector3Make([[aCube node] position].x, [[aCube node] position].y, [[aCube node] position].z);
        
        [[aCube node] setPosition:startPos];
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.1];
        [SCNTransaction setCompletionBlock: ^{ [self AnimateBudget:bd withName:bname withCount:cnt];}];
        [self.sceneView.scene.rootNode addChildNode:aCube];
        [[aCube node] setPosition:keepPosition];
        [SCNTransaction commit];
        int animCount = [[[bd animationCounts] objectForKey:bname] intValue];
       // printf("ANIMCOUNT: %d numCubes: %d\n",animCount,[[[bd budgetCubes] objectForKey:bname] count]);
        [[bd animationCounts] setObject:[NSNumber numberWithInt:animCount+1] forKey:bname];
       // [bd setAnimationCount:[bd animationCount] + 1];
        //} else {
        if([[[bd animationCounts] objectForKey:bname] intValue] == 1) {
            int lc = 0;
            double latestBudget;
            if([bd isCollapsed]) {
                lc = 1;
                NSNumber *lt = [[bd budgetValues] objectForKey:[NSNumber numberWithInteger:self.currentYear]];
                latestBudget = [lt doubleValue];
                latestBudget = ((latestBudget*1000000.0)/1000000000.0);
                [bd SetYearLabel:self.currentYear];
                [bd SetMoneyLabel:0 withValue:latestBudget];
                SCNNode *myNode = [[bd myBudgetLabels] objectAtIndex:0];
                SCNNode *myMoneyNode = [[bd myMoneyLabels] objectAtIndex:0];
                // Cube *aCube = [[bd lastPositions] objectAtIndex:0];
                //Cube *aCube = [[bd budgetCubes] objectForKey:[bd budgetName]];
                [bd GetMinMaxExtents:[bd budgetName]];
                float labelX = ([[[bd budgetXmax] objectForKey:[bd budgetName]] floatValue] + [[[bd budgetXmin] objectForKey:[bd budgetName]] floatValue])/2.0;
                float labelY = [[[bd budgetYmax] objectForKey:[bd budgetName]] floatValue] + (4.0*(_unitScaley*_blockSize));
                float labelZ = ([[[bd budgetZmax] objectForKey:[bd budgetName]] floatValue] + [[[bd budgetZmin] objectForKey:[bd budgetName]] floatValue])/2.0;
                // SCNVector3 textPos = SCNVector3Make([[self.labelPositionsX objectAtIndex:0] floatValue],[[self.labelPositionsY objectAtIndex:0] floatValue],[[self.labelPositionsZ objectAtIndex:0] floatValue]);
                SCNVector3 textPos = SCNVector3Make(labelX,labelY,labelZ);
                
                //textPos.y = textPos.y + 0.5*(maxBound.y-minBound.y);
                textPos.y = textPos.y + (self.scale*self.unitScaley);
                [myMoneyNode setPosition:textPos];
                textPos.y = textPos.y + ((self.scale*self.unitScaley)*200);
                [myNode setPosition:textPos];
                textPos.y = textPos.y + ((self.scale*self.unitScaley)*200);
                [[bd myYearLabel] setPosition:textPos];
                [myNode setScale:SCNVector3Make(0.002, 0.002, 0.002)];
                [myMoneyNode setScale:SCNVector3Make(0.002, 0.002, 0.002)];
                [[bd myYearLabel] setScale:SCNVector3Make(0.002, 0.002, 0.002)];
                [self.sceneView.scene.rootNode addChildNode:myNode];
                [self.sceneView.scene.rootNode addChildNode:myMoneyNode];
                [self.sceneView.scene.rootNode addChildNode:[bd myYearLabel]];
                
            } else {
                //for(int i=0; i<[[bd budgetSubCategories] count]; i++) {
                    NSMutableDictionary *subDict = [[bd subBudgetValues] objectForKey:bname];
                    NSNumber *lt = [subDict objectForKey:[NSNumber numberWithInteger:self.currentYear]];
                  //  NSLog(@"Sub Bud Name: %@ %d\n",[[bd budgetSubCategories] objectAtIndex:i],i);
                    latestBudget = [lt doubleValue];
                    latestBudget = ((latestBudget*1000000.0)/1000000000.0);
                    [bd SetYearLabel:self.currentYear];
                    [bd SetMoneyLabel:cnt withValue:latestBudget];
                    
                    //get node from BudgetData object
                    SCNNode *myNode = [[bd myBudgetLabels] objectAtIndex:cnt+1];
                    SCNNode *myMoneyNode = [[bd myMoneyLabels] objectAtIndex:cnt+1];
                    [bd GetMinMaxExtents:bname];
                    float labelX = ([[[bd budgetXmax] objectForKey:bname] floatValue] + [[[bd budgetXmin] objectForKey:bname] floatValue])/2.0;
                    float labelY = [[[bd budgetYmax] objectForKey:bname] floatValue] + (4.0*(_unitScaley));
                    float labelZ = ([[[bd budgetZmax] objectForKey:bname] floatValue] + [[[bd budgetZmin] objectForKey:bname] floatValue])/2.0;
                   // Cube *aCube = [[bd lastPositions] objectAtIndex:cnt];
                
                    SCNVector3 textPos = SCNVector3Make(labelX,labelY,labelZ);
                
                    // SCNVector3 textPos = SCNVector3Make([[self.labelPositionsX objectAtIndex:i] floatValue],[[self.labelPositionsY objectAtIndex:i] floatValue],[[self.labelPositionsZ objectAtIndex:i] floatValue]);
                    //textPos.y = textPos.y + 0.5*(maxBound.y-minBound.y);
                    textPos.y = textPos.y + (self.scale*self.unitScaley);
                    [myMoneyNode setPosition:textPos];
                    textPos.y = textPos.y + ((self.scale*self.unitScaley)*100);
                    [myNode setPosition:textPos];
                    textPos.y = textPos.y + ((self.scale*self.unitScaley)*100);
                    [[bd myYearLabel] setPosition:textPos];
                    [myNode setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                    [myMoneyNode setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                    [[bd myYearLabel] setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                    [self.sceneView.scene.rootNode addChildNode:myNode];
                    [self.sceneView.scene.rootNode addChildNode:myMoneyNode];
                    [self.sceneView.scene.rootNode addChildNode:[bd myYearLabel]];
                //}
                
            }
        }
        
    } /*else {
        if(self.animateAllBudgets && self.currentYear != 2016) {
         self.currentYear = self.currentYear+1;
         [self refreshCubes];
         }
    }*/
}
- (void)AnimateBudget:(BudgetData *)bd
{
    if([bd animationCount] < [[[bd budgetCubes] objectForKey:[bd budgetName]] count]) {
       // Cube *aCube = [[bd cubes] objectAtIndex:[bd animationCount]];
        Cube *aCube = [[[bd budgetCubes] objectForKey:[bd budgetName]] objectAtIndex:[bd animationCount]];
        SCNVector3 startPos = SCNVector3Make([[aCube node] position].x, [[aCube node] position].y-(_unitScaley*_blockSize), [[aCube node] position].z);
        SCNVector3 keepPosition  = SCNVector3Make([[aCube node] position].x, [[aCube node] position].y, [[aCube node] position].z);
      
        [[aCube node] setPosition:startPos];
        [SCNTransaction begin];
        [SCNTransaction setAnimationDuration:0.01];
        [SCNTransaction setCompletionBlock: ^{ [self AnimateBudget:bd];}];
        [self.sceneView.scene.rootNode addChildNode:aCube];
        [[aCube node] setPosition:keepPosition];
        [SCNTransaction commit];
        [bd setAnimationCount:[bd animationCount] + 1];
    //} else {
        if([bd animationCount] == 1) {
        int lc = 0;
        double latestBudget;
        if([bd isCollapsed]) {
            lc = 1;
            NSNumber *lt = [[_defense budgetValues] objectForKey:[NSNumber numberWithInteger:self.currentYear]];
            latestBudget = [lt doubleValue];
            latestBudget = ((latestBudget*1000000.0)/1000000000.0);
            [bd SetYearLabel:self.currentYear];
            [bd SetMoneyLabel:0 withValue:latestBudget];
            SCNNode *myNode = [[bd myBudgetLabels] objectAtIndex:0];
            SCNNode *myMoneyNode = [[bd myMoneyLabels] objectAtIndex:0];
           // Cube *aCube = [[bd lastPositions] objectAtIndex:0];
            //Cube *aCube = [[bd budgetCubes] objectForKey:[bd budgetName]];
            [bd GetMinMaxExtents:[bd budgetName]];
            float labelX = ([[[bd budgetXmax] objectForKey:[bd budgetName]] floatValue] + [[[bd budgetXmin] objectForKey:[bd budgetName]] floatValue])/2.0;
            float labelY = [[[bd budgetYmax] objectForKey:[bd budgetName]] floatValue];
            float labelZ = ([[[bd budgetZmax] objectForKey:[bd budgetName]] floatValue] + [[[bd budgetZmin] objectForKey:[bd budgetName]] floatValue])/2.0;
           // SCNVector3 textPos = SCNVector3Make([[self.labelPositionsX objectAtIndex:0] floatValue],[[self.labelPositionsY objectAtIndex:0] floatValue],[[self.labelPositionsZ objectAtIndex:0] floatValue]);
            SCNVector3 textPos = SCNVector3Make(labelX,labelY,labelZ);
            //textPos.y = textPos.y + 0.5*(maxBound.y-minBound.y);
            textPos.y = textPos.y + (self.scale*self.unitScaley);
            [myMoneyNode setPosition:textPos];
            textPos.y = textPos.y + ((self.scale*self.unitScaley)*200);
            [myNode setPosition:textPos];
            [myNode setScale:SCNVector3Make(0.002, 0.002, 0.002)];
            [myMoneyNode setScale:SCNVector3Make(0.002, 0.002, 0.002)];
            [self.sceneView.scene.rootNode addChildNode:myNode];
            [self.sceneView.scene.rootNode addChildNode:myMoneyNode];
            
        } else {
            for(int i=0; i<[[bd budgetSubCategories] count]; i++) {
                NSMutableDictionary *subDict = [[bd subBudgetValues] objectForKey:[[bd budgetSubCategories] objectAtIndex:i]];
                NSNumber *lt = [subDict objectForKey:[NSNumber numberWithInteger:self.currentYear]];
                latestBudget = [lt doubleValue];
                latestBudget = ((latestBudget*1000000.0)/1000000000.0);
                [bd SetYearLabel:self.currentYear];
                [bd SetMoneyLabel:i withValue:latestBudget];
                
                //get node from BudgetData object
                SCNNode *myNode = [[bd myBudgetLabels] objectAtIndex:i+1];
                SCNNode *myMoneyNode = [[bd myMoneyLabels] objectAtIndex:i+1];
                Cube *aCube = [[bd lastPositions] objectAtIndex:i];
                SCNVector3 textPos = SCNVector3Make([[aCube node] position].x, [[aCube node] position].y, [[aCube node] position].z);
                // SCNVector3 textPos = SCNVector3Make([[self.labelPositionsX objectAtIndex:i] floatValue],[[self.labelPositionsY objectAtIndex:i] floatValue],[[self.labelPositionsZ objectAtIndex:i] floatValue]);
                //textPos.y = textPos.y + 0.5*(maxBound.y-minBound.y);
                textPos.y = textPos.y + (self.scale*self.unitScaley);
                [myMoneyNode setPosition:textPos];
                textPos.y = textPos.y + ((self.scale*self.unitScaley)*100);
                [myNode setPosition:textPos];
                [myNode setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                [myMoneyNode setScale:SCNVector3Make(0.001, 0.001, 0.001)];
                [self.sceneView.scene.rootNode addChildNode:myNode];
                [self.sceneView.scene.rootNode addChildNode:myMoneyNode];
            }

        }
        }
        
    } else {
        if(self.animateAllBudgets && self.currentYear != 2016) {
            self.currentYear = self.currentYear+1;
            [self refreshCubes];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  // Called just before we transition to the config screen
    if([[segue identifier] isEqualToString:@"configView"]) {
        ConfigViewController *configController = (ConfigViewController *)segue.destinationViewController;
  
        // NOTE: I am using a popover so that we do't get the viewWillAppear method called when
        // we close the popover, if that gets called (like if you did a modal settings page), then
        // the session configuration is updated and we lose tracking. By default it shouldn't but
        // it still seems to.
        configController.modalPresentationStyle = UIModalPresentationPopover;
        configController.popoverPresentationController.delegate = self;
        configController.config = self.config;
    }
    if([[segue identifier] isEqualToString:@"budgetView"]) {
        BudgetViewController *budgetController = (BudgetViewController *)segue.destinationViewController;
        
        // NOTE: I am using a popover so that we do't get the viewWillAppear method called when
        // we close the popover, if that gets called (like if you did a modal settings page), then
        // the session configuration is updated and we lose tracking. By default it shouldn't but
        // it still seems to.
        budgetController.modalPresentationStyle = UIModalPresentationPopover;
        budgetController.popoverPresentationController.delegate = self;
        budgetController.config = self.config;
    }
    if([[segue identifier] isEqualToString:@"modelView"]) {
        ModelViewController *modelController = (ModelViewController *)segue.destinationViewController;
        
        // NOTE: I am using a popover so that we do't get the viewWillAppear method called when
        // we close the popover, if that gets called (like if you did a modal settings page), then
        // the session configuration is updated and we lose tracking. By default it shouldn't but
        // it still seems to.
        modelController.modalPresentationStyle = UIModalPresentationPopover;
        modelController.popoverPresentationController.delegate = self;
        modelController.config = self.config;
    }
    
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
  return UIModalPresentationNone;
}

- (IBAction)settingsUnwind:(UIStoryboardSegue *)segue {
  // Called after we navigate back from the config screen
    if([[segue identifier] isEqualToString:@"configView"]) {
        ConfigViewController *configView = (ConfigViewController *)segue.sourceViewController;
        Config *config = self.config;
  
        config.showPhysicsBodies = configView.physicsBodies.on;
        config.showFeaturePoints = configView.featurePoints.on;
        config.showWorldOrigin = configView.worldOrigin.on;
        config.showStatistics = configView.statistics.on;
        [self updateConfig];
    }
    if([[segue identifier] isEqualToString:@"budgetView"]) {
        BudgetViewController *budgetView = (BudgetViewController *)segue.sourceViewController;
        Config *config = self.config;
        config.showDefense = budgetView.Defense.on;
        config.showInternationalAffairs = budgetView.InternationalAffairs.on;
        config.showEnergy = budgetView.Energy.on;
        config.showNaturalResources = budgetView.naturalResources.on;
        config.showSpaceTech = budgetView.spaceTech.on;
        config.showAgriculture = budgetView.agriculture.on;
        config.showCommerce = budgetView.commerceHousing.on;
        config.showTransportation = budgetView.transportation.on;
        config.showCommDev = budgetView.commDev.on;
        config.showEducationSocial = budgetView.educationSocial.on;
        config.showHealth = budgetView.health.on;
        config.showMedicare = budgetView.medicare.on;
        config.showIncomeSecurity = budgetView.incomeSecurity.on;
        config.showSocialSecurity = budgetView.socialSecurity.on;
        config.showVeterans = budgetView.veterans.on;
        config.showJustice = budgetView.justice.on;
        
       // config.showMedicare = budgetView.Medicare.on;
        
        [self updateBudgetConfig];
    }
    
    if([[segue identifier] isEqualToString:@"modelView"]) {
        ModelViewController *modelView = (ModelViewController *)segue.sourceViewController;
        Config *config = self.config;
        config.showSearsTower = modelView.SearsTower.on;
        config.showChicagoBungalow = modelView.ChicagoBungalow.on;
    }
}

- (IBAction)detectPlanesChanged:(id)sender {
  BOOL enabled = ((UISwitch *)sender).on;
  
  if (enabled == self.config.detectPlanes) {
    return;
  }
  
  self.config.detectPlanes = enabled;
  if (enabled) {
    [self disableTracking: NO];
  } else {
    [self disableTracking: YES];
  }
}

- (IBAction)detectAnimateBudgets:(id)sender {
    self.animateAllBudgets = ((UISwitch *)sender).on;
    if(self.animateAllBudgets) {
        [self ResetActiveBudgetAnimationCounts];
        //increment year once and call refreshCubeNoAnimation
        if(self.currentYear != 2016) {
            self.currentYear = self.currentYear + 1;
        } else {
            self.currentYear = 1962;
        }
        [self refreshCubesNoAnimate];
        [self AnimateAllBudgets];
    } else {
        //call refresh cubes
        [self refreshCubes];
    }
}

- (void)refreshCubes
{
    if([_defense isDisplayed]) {
        for(Cube *cube in [[_defense budgetCubes] objectForKey:[_defense budgetName]]) {
                [cube remove];
        }
        [[[_defense budgetCubes] objectForKey:[_defense budgetName]] removeAllObjects];
      
        [[_defense lastPositions] removeAllObjects];
        [[_defense myYearLabel] removeFromParentNode];
        if([_defense isCollapsed]) {
            [[[_defense myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_defense myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_defense budgetSubCategories] count]; i++) {
                [[[_defense myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_defense myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_defense withPosition:[self.defense initialPosition]];
       // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_internationalAffairs isDisplayed]) {
        for(Cube *cube in [[_internationalAffairs budgetCubes] objectForKey:[_internationalAffairs budgetName]]) {
            [cube remove];
        }
        [[[_internationalAffairs budgetCubes] objectForKey:[_internationalAffairs budgetName]] removeAllObjects];
        
        [[_internationalAffairs lastPositions] removeAllObjects];
        [[_internationalAffairs myYearLabel] removeFromParentNode];
        if([_internationalAffairs isCollapsed]) {
            [[[_internationalAffairs myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_internationalAffairs myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_internationalAffairs budgetSubCategories] count]; i++) {
                [[[_internationalAffairs myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_internationalAffairs myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_internationalAffairs withPosition:[self.internationalAffairs initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_energy isDisplayed]) {
        for(Cube *cube in [[_energy budgetCubes] objectForKey:[_energy budgetName]]) {
            [cube remove];
        }
        [[[_energy budgetCubes] objectForKey:[_energy budgetName]] removeAllObjects];
        
        [[_energy lastPositions] removeAllObjects];
        [[_energy myYearLabel] removeFromParentNode];
        if([_energy isCollapsed]) {
            [[[_energy myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_energy myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_energy budgetSubCategories] count]; i++) {
                [[[_energy myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_energy myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_energy withPosition:[self.energy initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_naturalResources isDisplayed]) {
        for(Cube *cube in [[_naturalResources budgetCubes] objectForKey:[_naturalResources budgetName]]) {
            [cube remove];
        }
        [[[_naturalResources budgetCubes] objectForKey:[_naturalResources budgetName]] removeAllObjects];
        
        [[_naturalResources lastPositions] removeAllObjects];
        [[_naturalResources myYearLabel] removeFromParentNode];
        if([_naturalResources isCollapsed]) {
            [[[_naturalResources myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_naturalResources myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_naturalResources budgetSubCategories] count]; i++) {
                [[[_naturalResources myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_naturalResources myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_naturalResources withPosition:[self.naturalResources initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_spaceTech isDisplayed]) {
        for(Cube *cube in [[_spaceTech budgetCubes] objectForKey:[_spaceTech budgetName]]) {
            [cube remove];
        }
        [[[_spaceTech budgetCubes] objectForKey:[_spaceTech budgetName]] removeAllObjects];
        
        [[_spaceTech lastPositions] removeAllObjects];
        [[_spaceTech myYearLabel] removeFromParentNode];
        if([_spaceTech isCollapsed]) {
            [[[_spaceTech myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_spaceTech myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_spaceTech budgetSubCategories] count]; i++) {
                [[[_spaceTech myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_spaceTech myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_spaceTech withPosition:[self.spaceTech initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_agriculture isDisplayed]) {
        for(Cube *cube in [[_agriculture budgetCubes] objectForKey:[_agriculture budgetName]]) {
            [cube remove];
        }
        [[[_agriculture budgetCubes] objectForKey:[_agriculture budgetName]] removeAllObjects];
        
        [[_agriculture lastPositions] removeAllObjects];
        [[_agriculture myYearLabel] removeFromParentNode];
        if([_agriculture isCollapsed]) {
            [[[_agriculture myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_agriculture myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_agriculture budgetSubCategories] count]; i++) {
                [[[_agriculture myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_agriculture myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_agriculture withPosition:[self.agriculture initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_commerceHousing isDisplayed]) {
        for(Cube *cube in [[_commerceHousing budgetCubes] objectForKey:[_commerceHousing budgetName]]) {
            [cube remove];
        }
        [[[_commerceHousing budgetCubes] objectForKey:[_commerceHousing budgetName]] removeAllObjects];
        
        [[_commerceHousing lastPositions] removeAllObjects];
        [[_commerceHousing myYearLabel] removeFromParentNode];
        if([_commerceHousing isCollapsed]) {
            [[[_commerceHousing myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_commerceHousing myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_commerceHousing budgetSubCategories] count]; i++) {
                [[[_commerceHousing myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_commerceHousing myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_commerceHousing withPosition:[self.commerceHousing initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_transportation isDisplayed]) {
        for(Cube *cube in [[_transportation budgetCubes] objectForKey:[_transportation budgetName]]) {
            [cube remove];
        }
        [[[_transportation budgetCubes] objectForKey:[_transportation budgetName]] removeAllObjects];
        
        [[_transportation lastPositions] removeAllObjects];
        [[_transportation myYearLabel] removeFromParentNode];
        if([_transportation isCollapsed]) {
            [[[_transportation myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_transportation myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_transportation budgetSubCategories] count]; i++) {
                [[[_transportation myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_transportation myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_transportation withPosition:[self.transportation initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_commDev isDisplayed]) {
        for(Cube *cube in [[_commDev budgetCubes] objectForKey:[_commDev budgetName]]) {
            [cube remove];
        }
        [[[_commDev budgetCubes] objectForKey:[_commDev budgetName]] removeAllObjects];
        
        [[_commDev lastPositions] removeAllObjects];
        [[_commDev myYearLabel] removeFromParentNode];
        if([_commDev isCollapsed]) {
            [[[_commDev myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_commDev myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_commDev budgetSubCategories] count]; i++) {
                [[[_commDev myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_commDev myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_commDev withPosition:[self.commDev initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_educationSocial isDisplayed]) {
        for(Cube *cube in [[_educationSocial budgetCubes] objectForKey:[_educationSocial budgetName]]) {
            [cube remove];
        }
        [[[_educationSocial budgetCubes] objectForKey:[_educationSocial budgetName]] removeAllObjects];
        
        [[_educationSocial lastPositions] removeAllObjects];
        [[_educationSocial myYearLabel] removeFromParentNode];
        if([_educationSocial isCollapsed]) {
            [[[_educationSocial myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_educationSocial myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_educationSocial budgetSubCategories] count]; i++) {
                [[[_educationSocial myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_educationSocial myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_educationSocial withPosition:[self.educationSocial initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_health isDisplayed]) {
        for(Cube *cube in [[_health budgetCubes] objectForKey:[_health budgetName]]) {
            [cube remove];
        }
        [[[_health budgetCubes] objectForKey:[_health budgetName]] removeAllObjects];
        
        [[_health lastPositions] removeAllObjects];
        [[_health myYearLabel] removeFromParentNode];
        if([_health isCollapsed]) {
            [[[_health myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_health myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_health budgetSubCategories] count]; i++) {
                [[[_health myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_health myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_health withPosition:[self.health initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_medicare isDisplayed]) {
        for(Cube *cube in [[_medicare budgetCubes] objectForKey:[_medicare budgetName]]) {
            [cube remove];
        }
        [[[_medicare budgetCubes] objectForKey:[_medicare budgetName]] removeAllObjects];
        
        [[_medicare lastPositions] removeAllObjects];
        [[_medicare myYearLabel] removeFromParentNode];
        if([_medicare isCollapsed]) {
            [[[_medicare myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_medicare myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_medicare budgetSubCategories] count]; i++) {
                [[[_medicare myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_medicare myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_medicare withPosition:[self.medicare initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_incomeSecurity isDisplayed]) {
        for(Cube *cube in [[_incomeSecurity budgetCubes] objectForKey:[_incomeSecurity budgetName]]) {
            [cube remove];
        }
        [[[_incomeSecurity budgetCubes] objectForKey:[_incomeSecurity budgetName]] removeAllObjects];
        
        [[_incomeSecurity lastPositions] removeAllObjects];
        [[_incomeSecurity myYearLabel] removeFromParentNode];
        if([_incomeSecurity isCollapsed]) {
            [[[_incomeSecurity myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_incomeSecurity myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_incomeSecurity budgetSubCategories] count]; i++) {
                [[[_incomeSecurity myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_incomeSecurity myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_incomeSecurity withPosition:[self.incomeSecurity initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_socialSecurity isDisplayed]) {
        for(Cube *cube in [[_socialSecurity budgetCubes] objectForKey:[_socialSecurity budgetName]]) {
            [cube remove];
        }
        [[[_socialSecurity budgetCubes] objectForKey:[_socialSecurity budgetName]] removeAllObjects];
        
        [[_socialSecurity lastPositions] removeAllObjects];
        [[_socialSecurity myYearLabel] removeFromParentNode];
        if([_socialSecurity isCollapsed]) {
            [[[_socialSecurity myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_socialSecurity myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_socialSecurity budgetSubCategories] count]; i++) {
                [[[_socialSecurity myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_socialSecurity myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_socialSecurity withPosition:[self.socialSecurity initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_veterans isDisplayed]) {
        for(Cube *cube in [[_veterans budgetCubes] objectForKey:[_veterans budgetName]]) {
            [cube remove];
        }
        [[[_veterans budgetCubes] objectForKey:[_veterans budgetName]] removeAllObjects];
        
        [[_veterans lastPositions] removeAllObjects];
        [[_veterans myYearLabel] removeFromParentNode];
        if([_veterans isCollapsed]) {
            [[[_veterans myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_veterans myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_veterans budgetSubCategories] count]; i++) {
                [[[_veterans myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_veterans myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_veterans withPosition:[self.veterans initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_justice isDisplayed]) {
        for(Cube *cube in [[_justice budgetCubes] objectForKey:[_justice budgetName]]) {
            [cube remove];
        }
        [[[_justice budgetCubes] objectForKey:[_justice budgetName]] removeAllObjects];
        
        [[_justice lastPositions] removeAllObjects];
        [[_justice myYearLabel] removeFromParentNode];
        if([_justice isCollapsed]) {
            [[[_justice myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_justice myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_justice budgetSubCategories] count]; i++) {
                [[[_justice myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_justice myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubes:_justice withPosition:[self.justice initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
}

- (void)refreshCubesNoAnimate
{
    if([_defense isDisplayed]) {
        for(Cube *cube in [[_defense budgetCubes] objectForKey:[_defense budgetName]]) {
            [cube remove];
        }
        [[[_defense budgetCubes] objectForKey:[_defense budgetName]] removeAllObjects];
        
        [[_defense lastPositions] removeAllObjects];
        [[_defense myYearLabel] removeFromParentNode];
        if([_defense isCollapsed]) {
            [[[_defense myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_defense myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_defense budgetSubCategories] count]; i++) {
                [[[_defense myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_defense myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_defense withPosition:[self.defense initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_internationalAffairs isDisplayed]) {
        for(Cube *cube in [[_internationalAffairs budgetCubes] objectForKey:[_internationalAffairs budgetName]]) {
            [cube remove];
        }
        [[[_internationalAffairs budgetCubes] objectForKey:[_internationalAffairs budgetName]] removeAllObjects];
        
        [[_internationalAffairs lastPositions] removeAllObjects];
        [[_internationalAffairs myYearLabel] removeFromParentNode];
        if([_internationalAffairs isCollapsed]) {
            [[[_internationalAffairs myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_internationalAffairs myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_internationalAffairs budgetSubCategories] count]; i++) {
                [[[_internationalAffairs myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_internationalAffairs myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_internationalAffairs withPosition:[self.internationalAffairs initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_energy isDisplayed]) {
        for(Cube *cube in [[_energy budgetCubes] objectForKey:[_energy budgetName]]) {
            [cube remove];
        }
        [[[_energy budgetCubes] objectForKey:[_energy budgetName]] removeAllObjects];
        
        [[_energy lastPositions] removeAllObjects];
        [[_energy myYearLabel] removeFromParentNode];
        if([_energy isCollapsed]) {
            [[[_energy myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_energy myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_energy budgetSubCategories] count]; i++) {
                [[[_energy myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_energy myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_energy withPosition:[self.energy initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_naturalResources isDisplayed]) {
        for(Cube *cube in [[_naturalResources budgetCubes] objectForKey:[_naturalResources budgetName]]) {
            [cube remove];
        }
        [[[_naturalResources budgetCubes] objectForKey:[_naturalResources budgetName]] removeAllObjects];
        
        [[_naturalResources lastPositions] removeAllObjects];
        [[_naturalResources myYearLabel] removeFromParentNode];
        if([_naturalResources isCollapsed]) {
            [[[_naturalResources myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_naturalResources myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_naturalResources budgetSubCategories] count]; i++) {
                [[[_naturalResources myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_naturalResources myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_naturalResources withPosition:[self.naturalResources initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_spaceTech isDisplayed]) {
        for(Cube *cube in [[_spaceTech budgetCubes] objectForKey:[_spaceTech budgetName]]) {
            [cube remove];
        }
        [[[_spaceTech budgetCubes] objectForKey:[_spaceTech budgetName]] removeAllObjects];
        
        [[_spaceTech lastPositions] removeAllObjects];
        [[_spaceTech myYearLabel] removeFromParentNode];
        if([_spaceTech isCollapsed]) {
            [[[_spaceTech myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_spaceTech myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_spaceTech budgetSubCategories] count]; i++) {
                [[[_spaceTech myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_spaceTech myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_spaceTech withPosition:[self.spaceTech initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_agriculture isDisplayed]) {
        for(Cube *cube in [[_agriculture budgetCubes] objectForKey:[_agriculture budgetName]]) {
            [cube remove];
        }
        [[[_agriculture budgetCubes] objectForKey:[_agriculture budgetName]] removeAllObjects];
        
        [[_agriculture lastPositions] removeAllObjects];
        [[_agriculture myYearLabel] removeFromParentNode];
        if([_agriculture isCollapsed]) {
            [[[_agriculture myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_agriculture myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_agriculture budgetSubCategories] count]; i++) {
                [[[_agriculture myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_agriculture myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_agriculture withPosition:[self.agriculture initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_commerceHousing isDisplayed]) {
        for(Cube *cube in [[_commerceHousing budgetCubes] objectForKey:[_commerceHousing budgetName]]) {
            [cube remove];
        }
        [[[_commerceHousing budgetCubes] objectForKey:[_commerceHousing budgetName]] removeAllObjects];
        
        [[_commerceHousing lastPositions] removeAllObjects];
        [[_commerceHousing myYearLabel] removeFromParentNode];
        if([_commerceHousing isCollapsed]) {
            [[[_commerceHousing myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_commerceHousing myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_commerceHousing budgetSubCategories] count]; i++) {
                [[[_commerceHousing myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_commerceHousing myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_commerceHousing withPosition:[self.commerceHousing initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_transportation isDisplayed]) {
        for(Cube *cube in [[_transportation budgetCubes] objectForKey:[_transportation budgetName]]) {
            [cube remove];
        }
        [[[_transportation budgetCubes] objectForKey:[_transportation budgetName]] removeAllObjects];
        
        [[_transportation lastPositions] removeAllObjects];
        [[_transportation myYearLabel] removeFromParentNode];
        if([_transportation isCollapsed]) {
            [[[_transportation myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_transportation myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_transportation budgetSubCategories] count]; i++) {
                [[[_transportation myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_transportation myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_transportation withPosition:[self.transportation initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_commDev isDisplayed]) {
        for(Cube *cube in [[_commDev budgetCubes] objectForKey:[_commDev budgetName]]) {
            [cube remove];
        }
        [[[_commDev budgetCubes] objectForKey:[_commDev budgetName]] removeAllObjects];
        
        [[_commDev lastPositions] removeAllObjects];
        [[_commDev myYearLabel] removeFromParentNode];
        if([_commDev isCollapsed]) {
            [[[_commDev myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_commDev myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_commDev budgetSubCategories] count]; i++) {
                [[[_commDev myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_commDev myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_commDev withPosition:[self.commDev initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_educationSocial isDisplayed]) {
        for(Cube *cube in [[_educationSocial budgetCubes] objectForKey:[_educationSocial budgetName]]) {
            [cube remove];
        }
        [[[_educationSocial budgetCubes] objectForKey:[_educationSocial budgetName]] removeAllObjects];
        
        [[_educationSocial lastPositions] removeAllObjects];
        [[_educationSocial myYearLabel] removeFromParentNode];
        if([_educationSocial isCollapsed]) {
            [[[_educationSocial myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_educationSocial myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_educationSocial budgetSubCategories] count]; i++) {
                [[[_educationSocial myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_educationSocial myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_educationSocial withPosition:[self.educationSocial initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_health isDisplayed]) {
        for(Cube *cube in [[_health budgetCubes] objectForKey:[_health budgetName]]) {
            [cube remove];
        }
        [[[_health budgetCubes] objectForKey:[_health budgetName]] removeAllObjects];
        
        [[_health lastPositions] removeAllObjects];
        [[_health myYearLabel] removeFromParentNode];
        if([_health isCollapsed]) {
            [[[_health myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_health myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_health budgetSubCategories] count]; i++) {
                [[[_health myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_health myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_health withPosition:[self.health initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_medicare isDisplayed]) {
        for(Cube *cube in [[_medicare budgetCubes] objectForKey:[_medicare budgetName]]) {
            [cube remove];
        }
        [[[_medicare budgetCubes] objectForKey:[_medicare budgetName]] removeAllObjects];
        
        [[_medicare lastPositions] removeAllObjects];
        [[_medicare myYearLabel] removeFromParentNode];
        if([_medicare isCollapsed]) {
            [[[_medicare myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_medicare myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_medicare budgetSubCategories] count]; i++) {
                [[[_medicare myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_medicare myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_medicare withPosition:[self.medicare initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_incomeSecurity isDisplayed]) {
        for(Cube *cube in [[_incomeSecurity budgetCubes] objectForKey:[_incomeSecurity budgetName]]) {
            [cube remove];
        }
        [[[_incomeSecurity budgetCubes] objectForKey:[_incomeSecurity budgetName]] removeAllObjects];
        
        [[_incomeSecurity lastPositions] removeAllObjects];
        [[_incomeSecurity myYearLabel] removeFromParentNode];
        if([_incomeSecurity isCollapsed]) {
            [[[_incomeSecurity myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_incomeSecurity myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_incomeSecurity budgetSubCategories] count]; i++) {
                [[[_incomeSecurity myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_incomeSecurity myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_incomeSecurity withPosition:[self.incomeSecurity initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_socialSecurity isDisplayed]) {
        for(Cube *cube in [[_socialSecurity budgetCubes] objectForKey:[_socialSecurity budgetName]]) {
            [cube remove];
        }
        [[[_socialSecurity budgetCubes] objectForKey:[_socialSecurity budgetName]] removeAllObjects];
        
        [[_socialSecurity lastPositions] removeAllObjects];
        [[_socialSecurity myYearLabel] removeFromParentNode];
        if([_socialSecurity isCollapsed]) {
            [[[_socialSecurity myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_socialSecurity myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_socialSecurity budgetSubCategories] count]; i++) {
                [[[_socialSecurity myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_socialSecurity myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_socialSecurity withPosition:[self.socialSecurity initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_veterans isDisplayed]) {
        for(Cube *cube in [[_veterans budgetCubes] objectForKey:[_veterans budgetName]]) {
            [cube remove];
        }
        [[[_veterans budgetCubes] objectForKey:[_veterans budgetName]] removeAllObjects];
        
        [[_veterans lastPositions] removeAllObjects];
        [[_veterans myYearLabel] removeFromParentNode];
        if([_veterans isCollapsed]) {
            [[[_veterans myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_veterans myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_veterans budgetSubCategories] count]; i++) {
                [[[_veterans myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_veterans myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_veterans withPosition:[self.veterans initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
    if([_justice isDisplayed]) {
        for(Cube *cube in [[_justice budgetCubes] objectForKey:[_justice budgetName]]) {
            [cube remove];
        }
        [[[_justice budgetCubes] objectForKey:[_justice budgetName]] removeAllObjects];
        
        [[_justice lastPositions] removeAllObjects];
        [[_justice myYearLabel] removeFromParentNode];
        if([_justice isCollapsed]) {
            [[[_justice myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_justice myMoneyLabels] objectAtIndex:0] removeFromParentNode];
        } else {
            for(int i=0; i<[[_justice budgetSubCategories] count]; i++) {
                [[[_justice myBudgetLabels] objectAtIndex:i+1] removeFromParentNode];
                [[[_justice myMoneyLabels] objectAtIndex:i+1] removeFromParentNode];
            }
        }
        [self insertBudgetCubesNoAnimate:_justice withPosition:[self.justice initialPosition]];
        // [self insertBudgetBlocks:_defense withPosition:keepPosition];
    }
}

- (IBAction)detectYearChanged:(id)sender
{
    
    UIStepper *myStep = ((UIStepper *)sender);
    if(self.currentYear != (uint)myStep.value) {
        self.currentYear = (uint)myStep.value;
        [self refreshCubes];
    }
}

- (void)updateConfig {
  SCNDebugOptions opts = SCNDebugOptionNone;
  Config *config = self.config;
  if (config.showWorldOrigin) {
    opts |= ARSCNDebugOptionShowWorldOrigin;
  }
  if (config.showFeaturePoints) {
    opts = ARSCNDebugOptionShowFeaturePoints;
  }
  if (config.showPhysicsBodies) {
    opts |= SCNDebugOptionShowPhysicsShapes;
  }
  self.sceneView.debugOptions = opts;
  if (config.showStatistics) {
    self.sceneView.showsStatistics = YES;
  } else {
    self.sceneView.showsStatistics = NO;
  }
}

- (void)updateBudgetConfig {
    Config *config = self.config;
    //set total amount of budgets to display
    [config findBudgetsOn];
    [config findActiveBudgets];
    
    if(config.showDefense) {
        if(![_defense isDisplayed])
            [_defense setReadyToDisplay:true];
    } else {
        if([_defense isDisplayed]) {
            for(Cube *cube in [[_defense budgetCubes] objectForKey:[_defense budgetName]]) {
                [cube remove];
            }
            [[[_defense budgetCubes] objectForKey:[_defense budgetName]] removeAllObjects];
            [[[_defense myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_defense myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_defense myYearLabel] removeFromParentNode];
            [_defense setIsDisplayed:false];
        }
    }
    if(config.showInternationalAffairs) {
        if(![_internationalAffairs isDisplayed])
            [_internationalAffairs setReadyToDisplay:true];
    } else {
        if([_internationalAffairs isDisplayed]) {
            for(Cube *cube in [[_internationalAffairs budgetCubes] objectForKey:[_internationalAffairs budgetName]]) {
                [cube remove];
            }
            [[[_internationalAffairs budgetCubes] objectForKey:[_internationalAffairs budgetName]] removeAllObjects];
            [[[_internationalAffairs myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_internationalAffairs myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_internationalAffairs myYearLabel] removeFromParentNode];
            [_internationalAffairs setIsDisplayed:false];
        }
    }
    if(config.showEnergy) {
        if(![_energy isDisplayed])
            [_energy setReadyToDisplay:true];
    } else {
        if([_energy isDisplayed]) {
            for(Cube *cube in [[_energy budgetCubes] objectForKey:[_energy budgetName]]) {
                [cube remove];
            }
            [[[_energy budgetCubes] objectForKey:[_energy budgetName]] removeAllObjects];
            [[[_energy myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_energy myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_energy myYearLabel] removeFromParentNode];
            [_energy setIsDisplayed:false];
        }
    }
    if(config.showNaturalResources) {
        if(![_naturalResources isDisplayed])
            [_naturalResources setReadyToDisplay:true];
    } else {
        if([_naturalResources isDisplayed]) {
            for(Cube *cube in [[_naturalResources budgetCubes] objectForKey:[_naturalResources budgetName]]) {
                [cube remove];
            }
            [[[_naturalResources budgetCubes] objectForKey:[_naturalResources budgetName]] removeAllObjects];
            [[[_naturalResources myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_naturalResources myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_naturalResources myYearLabel] removeFromParentNode];
            [_naturalResources setIsDisplayed:false];
        }
    }
    if(config.showSpaceTech) {
        if(![_spaceTech isDisplayed])
            [_spaceTech setReadyToDisplay:true];
    } else {
        if([_spaceTech isDisplayed]) {
            for(Cube *cube in [[_spaceTech budgetCubes] objectForKey:[_spaceTech budgetName]]) {
                [cube remove];
            }
            [[[_spaceTech budgetCubes] objectForKey:[_spaceTech budgetName]] removeAllObjects];
            [[[_spaceTech myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_spaceTech myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_spaceTech myYearLabel] removeFromParentNode];
            [_spaceTech setIsDisplayed:false];
        }
    }
    
    if(config.showAgriculture) {
        if(![_agriculture isDisplayed])
            [_agriculture setReadyToDisplay:true];
    } else {
        if([_agriculture isDisplayed]) {
            for(Cube *cube in [[_agriculture budgetCubes] objectForKey:[_agriculture budgetName]]) {
                [cube remove];
            }
            [[[_agriculture budgetCubes] objectForKey:[_agriculture budgetName]] removeAllObjects];
            [[[_agriculture myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_agriculture myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_agriculture myYearLabel] removeFromParentNode];
            [_agriculture setIsDisplayed:false];
        }
    }
    
    if(config.showCommerce) {
        if(![_commerceHousing isDisplayed])
            [_commerceHousing setReadyToDisplay:true];
    } else {
        if([_commerceHousing isDisplayed]) {
            for(Cube *cube in [[_commerceHousing budgetCubes] objectForKey:[_commerceHousing budgetName]]) {
                [cube remove];
            }
            [[[_commerceHousing budgetCubes] objectForKey:[_commerceHousing budgetName]] removeAllObjects];
            [[[_commerceHousing myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_commerceHousing myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_commerceHousing myYearLabel] removeFromParentNode];
            [_commerceHousing setIsDisplayed:false];
        }
    }
    if(config.showTransportation) {
        if(![_transportation isDisplayed])
            [_transportation setReadyToDisplay:true];
    } else {
        if([_transportation isDisplayed]) {
            for(Cube *cube in [[_transportation budgetCubes] objectForKey:[_transportation budgetName]]) {
                [cube remove];
            }
            [[[_transportation budgetCubes] objectForKey:[_transportation budgetName]] removeAllObjects];
            [[[_transportation myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_transportation myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_transportation myYearLabel] removeFromParentNode];
            [_transportation setIsDisplayed:false];
        }
    }
    if(config.showCommDev) {
        if(![_commDev isDisplayed])
            [_commDev setReadyToDisplay:true];
    } else {
        if([_commDev isDisplayed]) {
            for(Cube *cube in [[_commDev budgetCubes] objectForKey:[_commDev budgetName]]) {
                [cube remove];
            }
            [[[_commDev budgetCubes] objectForKey:[_commDev budgetName]] removeAllObjects];
            [[[_commDev myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_commDev myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_commDev myYearLabel] removeFromParentNode];
            [_commDev setIsDisplayed:false];
        }
    }
    if(config.showEducationSocial) {
        if(![_educationSocial isDisplayed])
            [_educationSocial setReadyToDisplay:true];
    } else {
        if([_educationSocial isDisplayed]) {
            for(Cube *cube in [[_educationSocial budgetCubes] objectForKey:[_educationSocial budgetName]]) {
                [cube remove];
            }
            [[[_educationSocial budgetCubes] objectForKey:[_educationSocial budgetName]] removeAllObjects];
            [[[_educationSocial myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_educationSocial myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_educationSocial myYearLabel] removeFromParentNode];
            [_educationSocial setIsDisplayed:false];
        }
    }
    if(config.showHealth) {
        if(![_health isDisplayed])
            [_health setReadyToDisplay:true];
    } else {
        if([_health isDisplayed]) {
            for(Cube *cube in [[_health budgetCubes] objectForKey:[_health budgetName]]) {
                [cube remove];
            }
            [[[_health budgetCubes] objectForKey:[_health budgetName]] removeAllObjects];
            [[[_health myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_health myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_health myYearLabel] removeFromParentNode];
            [_health setIsDisplayed:false];
        }
    }
    if(config.showMedicare) {
        if(![_medicare isDisplayed])
            [_medicare setReadyToDisplay:true];
    } else {
        if([_medicare isDisplayed]) {
            for(Cube *cube in [[_medicare budgetCubes] objectForKey:[_medicare budgetName]]) {
                [cube remove];
            }
            [[[_medicare budgetCubes] objectForKey:[_medicare budgetName]] removeAllObjects];
            [[[_medicare myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_medicare myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_medicare myYearLabel] removeFromParentNode];
            [_medicare setIsDisplayed:false];
        }
    }
    if(config.showIncomeSecurity) {
        if(![_incomeSecurity isDisplayed])
            [_incomeSecurity setReadyToDisplay:true];
    } else {
        if([_incomeSecurity isDisplayed]) {
            for(Cube *cube in [[_incomeSecurity budgetCubes] objectForKey:[_incomeSecurity budgetName]]) {
                [cube remove];
            }
            [[[_incomeSecurity budgetCubes] objectForKey:[_incomeSecurity budgetName]] removeAllObjects];
            [[[_incomeSecurity myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_incomeSecurity myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_incomeSecurity myYearLabel] removeFromParentNode];
            [_incomeSecurity setIsDisplayed:false];
        }
    }
    if(config.showSocialSecurity) {
        if(![_socialSecurity isDisplayed])
            [_socialSecurity setReadyToDisplay:true];
    } else {
        if([_socialSecurity isDisplayed]) {
            for(Cube *cube in [[_socialSecurity budgetCubes] objectForKey:[_socialSecurity budgetName]]) {
                [cube remove];
            }
            [[[_socialSecurity budgetCubes] objectForKey:[_socialSecurity budgetName]] removeAllObjects];
            [[[_socialSecurity myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_socialSecurity myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_socialSecurity myYearLabel] removeFromParentNode];
            [_socialSecurity setIsDisplayed:false];
        }
    }
    if(config.showVeterans) {
        if(![_veterans isDisplayed])
            [_veterans setReadyToDisplay:true];
    } else {
        if([_veterans isDisplayed]) {
            for(Cube *cube in [[_veterans budgetCubes] objectForKey:[_veterans budgetName]]) {
                [cube remove];
            }
            [[[_veterans budgetCubes] objectForKey:[_veterans budgetName]] removeAllObjects];
            [[[_veterans myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_veterans myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_veterans myYearLabel] removeFromParentNode];
            [_veterans setIsDisplayed:false];
        }
    }
    if(config.showJustice) {
        if(![_justice isDisplayed])
            [_justice setReadyToDisplay:true];
    } else {
        if([_justice isDisplayed]) {
            for(Cube *cube in [[_justice budgetCubes] objectForKey:[_justice budgetName]]) {
                [cube remove];
            }
            [[[_justice budgetCubes] objectForKey:[_justice budgetName]] removeAllObjects];
            [[[_justice myBudgetLabels] objectAtIndex:0] removeFromParentNode];
            [[[_justice myMoneyLabels] objectAtIndex:0] removeFromParentNode];
            [[_justice myYearLabel] removeFromParentNode];
            [_justice setIsDisplayed:false];
        }
    }
    
}

- (void)refresh {
  for (NSUUID *planeId in self.planes) {
    [self.planes[planeId] remove];
  }
 // for (Cube *cube in self.cubes) {
   // [cube remove];
 // }
  [self.sceneView.session runWithConfiguration:self.arConfig options:ARSessionRunOptionResetTracking | ARSessionRunOptionRemoveExistingAnchors];
}

#pragma mark - SCNPhysicsContactDelegate

- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact {
  // Here we detect a collision between pieces of geometry in the world, if one of the pieces
  // of geometry is the bottom plane it means the geometry has fallen out of the world. just remove it
  CollisionCategory contactMask = contact.nodeA.physicsBody.categoryBitMask | contact.nodeB.physicsBody.categoryBitMask;
  
  if (contactMask == (CollisionCategoryBottom | CollisionCategoryCube)) {
    if (contact.nodeA.physicsBody.categoryBitMask == CollisionCategoryBottom) {
      [contact.nodeB removeFromParentNode];
        printf("removeb\n");
    } else {
      [contact.nodeA removeFromParentNode];
        printf("removea\n");
    }
  }
    /*if(contact.nodeA.physicsBody.categoryBitMask == CollisionCategoryCube &&
       contact.nodeB.physicsBody.categoryBitMask == CollisionCategoryCube) {
        Cube *aCube = (Cube *)contact.nodeA;
        Cube *bCube = (Cube *)contact.nodeB;
        if(aCube.firstContact || bCube.firstContact) {
            contact.nodeA.paused = true;
            contact.nodeB.paused = true;
            aCube.firstContact = false;
            bCube.firstContact = false;
            printf("HEY CUBE\n");
        } else {
            contact.nodeA.paused = false;
            contact.nodeB.paused = false;
        }
    }*/
    
}

- (void)physicsWorld:(SCNPhysicsWorld *)world didUpdateContact:(nonnull SCNPhysicsContact *)contact {
    //contact.nodeA.physicsBody.velocityFactor = SCNVector3Make(0.0, 0.0, 0.0);
    //contact.nodeB.physicsBody.velocityFactor = SCNVector3Make(0.0, 0.0, 0.0);
    //printf("UPDATE\n");
}
- (void)physicsWorld:(SCNPhysicsWorld *)world didEndContact:(nonnull SCNPhysicsContact *)contact {
    //contact.nodeA.physicsBody.velocityFactor = SCNVector3Make(0.0, 0.0, 0.0);
    //contact.nodeB.physicsBody.velocityFactor = SCNVector3Make(0.0, 0.0, 0.0);
    //printf("END\n");
}
#pragma mark - ARSCNViewDelegate

- (void)renderer:(id <SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {
  ARLightEstimate *estimate = self.sceneView.session.currentFrame.lightEstimate;
  if (!estimate) {
    return;
  }
  
  // A value of 1000 is considered neutral, lighting environment intensity normalizes
  // 1.0 to neutral so we need to scale the ambientIntensity value
  CGFloat intensity = estimate.ambientIntensity / 1000.0;
  self.sceneView.scene.lightingEnvironment.intensity = intensity;
}

/**
 Called when a new node has been mapped to the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that maps to the anchor.
 @param anchor The added anchor.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
  if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
    return;
  }
  
  // When a new plane is detected we create a new SceneKit plane to visualize it in 3D
  Plane *plane = [[Plane alloc] initWithAnchor: (ARPlaneAnchor *)anchor isHidden: NO withMaterial:[Plane currentMaterial]];
  [self.planes setObject:plane forKey:anchor.identifier];
  [node addChildNode:plane];
}

/**
 Called when a node has been updated with data from the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was updated.
 @param anchor The anchor that was updated.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
  Plane *plane = [self.planes objectForKey:anchor.identifier];
  if (plane == nil) {
    return;
  }
  
  // When an anchor is updated we need to also update our 3D geometry too. For example
  // the width and height of the plane detection may have changed so we need to update
  // our SceneKit geometry to match that
    //if(self.arConfig.planeDetection == ARPlaneDetectionHorizontal) {
     [plane update:(ARPlaneAnchor *)anchor];
   // printf("plane update\n");
    //}
}

/**
 Called when a mapped node has been removed from the scene graph for the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was removed.
 @param anchor The anchor that was removed.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
  // Nodes will be removed if planes multiple individual planes that are detected to all be
  // part of a larger plane are merged.
  [self.planes removeObjectForKey:anchor.identifier];
}

/**
 Called when a node will be updated with data from the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that will be updated.
 @param anchor The anchor that was updated.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    //printf("RENDERING...\n");
}

/**
 Implement this to provide a custom node for the given anchor.
 
 @discussion This node will automatically be added to the scene graph.
 If this method is not implemented, a node will be automatically created.
 If nil is returned the anchor will be ignored.
 @param renderer The renderer that will render the scene.
 @param anchor The added anchor.
 @return Node that will be mapped to the anchor or nil.
 */
//- (nullable SCNNode *)renderer:(id <SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
//  return nil;
//}

- (void)showMessage:(NSString *)message {
  [self.messageViewer queueMessage:message];
}

- (void)session:(ARSession *)session cameraDidChangeTrackingState:(ARCamera *)camera {
  ARTrackingState trackingState = camera.trackingState;
  if (self.currentTrackingState == trackingState) {
    return;
  }
  self.currentTrackingState = trackingState;
  
  switch(trackingState) {
    case ARTrackingStateNotAvailable:
      [self showMessage:@"Camera tracking is not available on this device"];
      break;
      
    case ARTrackingStateLimited:
      switch(camera.trackingStateReason) {
        case ARTrackingStateReasonExcessiveMotion:
          [self showMessage:@"Limited tracking: slow down the movement of the device"];
          break;
          
        case ARTrackingStateReasonInsufficientFeatures:
          [self showMessage:@"Limited tracking: too few feature points, view areas with more textures"];
          break;
          
        case ARTrackingStateReasonNone:
          NSLog(@"Tracking limited none");
          break;
      }
      break;
      
    case ARTrackingStateNormal:
      [self showMessage:@"Tracking is back to normal"];
          if(self.config.budgetsOn == 0) {
              [self showMessage:@"Tap on the surface to draw 3d model"];
          } else {
              [self showMessage:@"Tap on the surface to see a budget!"];
          }
      break;
  }
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
  // Present an error message to the user
  [self showMessage:@"session error"];
}

- (void)sessionWasInterrupted:(ARSession *)session {
  // Inform the user that the session has been interrupted, for example, by presenting an overlay, or being put in to the background
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Interruption" message:@"The tracking session has been interrupted. The session will be reset once the interruption has completed" preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
  }];
  
  [alert addAction:ok];
  [self presentViewController:alert animated:YES completion:^{
  }];
  
}

- (void)sessionInterruptionEnded:(ARSession *)session {
  // Reset tracking and/or remove existing anchors if consistent tracking is required
  [self showMessage:@"Tracking session has been reset due to interruption"];
  [self refresh];
}

@end
