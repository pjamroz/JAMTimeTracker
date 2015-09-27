//
//  ViewController.m
//  TimeTrackerDemo
//
//  Created by Piotr Jamróz on 27.09.2015.
//  Copyright © 2015 Piotr Jamróz. All rights reserved.
//

#import "ViewController.h"
#import "JAMTimeTrackerView.h"
#import "JAMTimeTrackerManager.h"

@interface ViewController () <TimeTrackerView, TimerTrackerManager>

@property (strong, nonatomic) JAMTimeTrackerManager *timeTrackerManager;
@property (weak, nonatomic) IBOutlet JAMTimeTrackerView *timeTrackerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.timeTrackerManager = [[JAMTimeTrackerManager alloc] init];
    
    self.timeTrackerManager.delegate = self;
    self.timeTrackerView.delegate = self;
    
    [self.timeTrackerView showStartButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <TimeTrackerView>

- (void)tStarted:(JAMTimeTrackerView *)sender {
    
    [self.timeTrackerManager startTimer];
}

- (void)tStopped:(JAMTimeTrackerView *)sender {
    
    [self.timeTrackerManager stopTimer];
}

#pragma mark - TimerTrackerManager

- (void)tUpdate:(JAMTimeTrackerManager *)sender {
    
    if (self.timeTrackerView.isTimerVisible) {
        [self.timeTrackerView updateElapsedTimeLabelWith:self.timeTrackerManager.elapsedTime];
    }
}

@end
