//
//  GraphSegue.m
//  Capstone2
//
//  Created by Matt Hartenbower on 10/21/15.
//  Copyright © 2015 Johnathan Cornella. All rights reserved.
//

#import "GraphSegue.h"

@implementation GraphSegue

-(void) perform
{
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.2
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
}
@end
