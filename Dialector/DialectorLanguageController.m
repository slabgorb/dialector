//
//  DialectorLanguageController.m
//  Dialector
//
//  Created by Keith Avery on 12/1/13.
//  Copyright (c) 2013 Keith Avery. All rights reserved.
//

#import "DialectorLanguageController.h"
#import "DialectorAppDelegate.h"

@interface DialectorLanguageController ()
@property (weak, nonatomic) IBOutlet UITextField *languageName;

@end

@implementation DialectorLanguageController
- (IBAction)saveLanguage:(id)sender {
    if ([[self.languageName text] isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Name" message:@"Please enter a name for the language." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        DialectorAppDelegate *delegate = (DialectorAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
