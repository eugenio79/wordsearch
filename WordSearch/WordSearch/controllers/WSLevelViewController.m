//
//  WSLevelViewController.m
//  WordSearch
//
//  Created by Giuseppe Morana on 08/02/15.
//  Copyright (c) 2015 Giuseppe Morana. All rights reserved.
//

#import "WSLevelViewController.h"
#import "WSCommon.h"
#import "WSGridViewController.h"

@interface WSLevelViewController () {
    WSGameLevel _gameLevel;
}

@property (weak, nonatomic) IBOutlet UIView *easyView;
@property (weak, nonatomic) IBOutlet UIView *mediumView;
@property (weak, nonatomic) IBOutlet UIView *hardView;

@end

@implementation WSLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(easyView_tapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.easyView addGestureRecognizer:tapGestureRecognizer];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mediumView_tapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.mediumView addGestureRecognizer:tapGestureRecognizer];
    
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hardView_tapped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.hardView addGestureRecognizer:tapGestureRecognizer];
}

- (void)easyView_tapped {
    
    _gameLevel = WSGameLevelEasy;
    [self performSegueWithIdentifier:@"showGridSegue" sender:self];
}

- (void)mediumView_tapped {
    
    _gameLevel = WSGameLevelMedium;
    [self performSegueWithIdentifier:@"showGridSegue" sender:self];
}

- (void)hardView_tapped {

    _gameLevel = WSGameLevelHard;
    [self performSegueWithIdentifier:@"showGridSegue" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGridSegue"]) {
        if ([[segue destinationViewController] isKindOfClass:[WSGridViewController class]]) {
            WSGridViewController *controller = (WSGridViewController *)[segue destinationViewController];
            controller.gameLevel = _gameLevel;
        }
    }
}

@end
