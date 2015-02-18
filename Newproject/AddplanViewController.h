//
//  AddplanViewController.h
//  KontractWorkOrder
//
//  Created by Riya on 1/28/15.
//  Copyright (c) 2015 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScafldingViewController.h"

@interface AddplanViewController : UIViewController
{
    UINavigationController *modalViewNavController;
}
@property(strong,nonatomic)ScafldingViewController *scaffoldctrl;
- (IBAction)clsebtn:(id)sender;
- (IBAction)serviceselection:(id)sender;
@property(strong,nonatomic)IBOutlet UIPopoverController *popoverctrlr;
@property(strong,nonatomic)IBOutlet UITableView *PopOvertableview;
@property(strong,nonatomic)IBOutlet UITableViewCell *scaffoldcell;
@property (strong, nonatomic) IBOutlet UIView *scafoldtitle;
@property(strong,nonatomic)IBOutlet UITableView *scaffoldtable;
@property (strong, nonatomic) IBOutlet UITextView *detailstextview;
@property (strong, nonatomic) IBOutlet UITextView *Workperformtextview;
@property (strong, nonatomic) IBOutlet UIButton *servicebtn;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
- (IBAction)addscaffoldaction:(id)sender;

@end
