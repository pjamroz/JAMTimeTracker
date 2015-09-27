//
//  JAMTimeTrackerView.m
//  TimeTrackerDemo
//
//  Created by Piotr Jamróz on 27.09.2015.
//  Copyright © 2015 Piotr Jamróz. All rights reserved.
//

#import "JAMTimeTrackerView.h"

#import "JAMTimeTrackerView.h"

@interface JAMTimeTrackerView()

@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UILabel *elapsedTimeLabel;
@property (strong, nonatomic) UIButton *stopButton;
@property (strong, nonatomic) UIButton *resetButton;

@end

@implementation JAMTimeTrackerView

#pragma mark - Init

- (instancetype)init {
    
    if (self = [super init]) {
        self.isTimerVisible = NO;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        self.isTimerVisible = NO;
        
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.startButton.frame = CGRectMake(0.0, 0.0, self.bounds.size.width/2, self.bounds.size.height);
    self.startButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.elapsedTimeLabel.frame = CGRectMake(0.0, 0.0, (self.bounds.size.width/3)*2, self.bounds.size.height);
}

#pragma mark - Public

- (void)showStartButton {
    
    __weak JAMTimeTrackerView *weakself = self;
    
    //remove reset button and elapsed time label if present
    [UIView animateWithDuration:0.3 animations:^{
        weakself.elapsedTimeLabel.alpha = 0;
        weakself.resetButton.alpha = 0;
    } completion:^(BOOL finished) {
        [weakself.elapsedTimeLabel removeFromSuperview];
        [weakself.resetButton removeFromSuperview];
        weakself.isTimerVisible = NO;
    }];
    
    // add start button
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.startButton addTarget:self action:@selector(startButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton setTitle:@"START" forState:UIControlStateNormal];
    self.startButton.alpha = 0;
    
    //debuging
    self.startButton.layer.borderColor = [UIColor greenColor].CGColor;
    self.startButton.layer.borderWidth = 2;
    
    [self addSubview:self.startButton];
    [UIView animateWithDuration:0.4 animations:^{
        weakself.startButton.alpha = 1.0;
    }];
}

- (void)showTimer {
    
    CGRect oldFrame = self.startButton.frame;
    
    __weak JAMTimeTrackerView *weakself = self;
    
    // remove start button
    [UIView animateWithDuration:0.3 animations:^{
        self.startButton.alpha = 0;
    } completion:^(BOOL finished) {
        [weakself.startButton removeFromSuperview];
    }];
    
    self.isTimerVisible = YES;
    
    // add stop button
    self.stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.stopButton.frame = oldFrame;
    
    // animate moving stop button to right side of the frame
    [UIView animateWithDuration:0.3 animations:^{
        self.stopButton.frame = CGRectMake((self.bounds.size.width/3)*2, 0.0, self.bounds.size.width/3, self.bounds.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            weakself.elapsedTimeLabel.alpha = 1.0;
        }];
    }];
    
    [self.stopButton addTarget:self action:@selector(stopButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton setTitle:@"STOP" forState:UIControlStateNormal];
    [self addSubview:self.stopButton];
    
    // add elapsed time label
    self.elapsedTimeLabel = [[UILabel alloc] init];
    self.elapsedTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.elapsedTimeLabel.alpha = 0;
    
    //debuging
    self.elapsedTimeLabel.layer.borderColor = [UIColor blueColor].CGColor;
    self.elapsedTimeLabel.layer.borderWidth = 1;
    
    [self addSubview:self.elapsedTimeLabel];
    [UIView animateWithDuration:0.3 animations:^{
        weakself.elapsedTimeLabel.alpha = 1.0;
    }];
    
    self.elapsedTimeLabel.text = @"00:00:00";
    
}

- (void)updateElapsedTimeLabelWith:(NSString *)elapsedTime
{
    self.elapsedTimeLabel.text = elapsedTime;
}

#pragma mark - Private

- (void)startButtonTapped:(UIButton *)sender {
    [self showTimer];
    
    //[self.almostDelegate timerStarted];
    
    [self.delegate tStarted:self];
}

- (void)stopButtonTapped:(UIButton *)sender {
    [self.delegate tStopped:self];
    
    __weak JAMTimeTrackerView *weakself = self;
    
    [UIView animateWithDuration:1 animations:^{
        [weakself.stopButton removeFromSuperview];
    }];
    
    self.resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.resetButton addTarget:self action:@selector(showStartButton) forControlEvents:UIControlEventTouchUpInside];
    [self.resetButton setTitle:@"RESTART" forState:UIControlStateNormal];
    self.resetButton.frame = CGRectMake((self.bounds.size.width/3)*2, 0.0, self.bounds.size.width/3, self.bounds.size.height);
    [self addSubview:self.resetButton];
}


@end
