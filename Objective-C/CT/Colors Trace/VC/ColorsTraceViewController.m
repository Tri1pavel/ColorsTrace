//
//  ViewController.m
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "ColorsTraceViewController.h"
#import "ColorsTraceHandler.h"

@interface ColorsTraceViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *colorButtons;
@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) ColorsTraceHandler *handler;
@end

@implementation ColorsTraceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateSelectedColorBarButtonItemByColor: nil];
        
    self.handler = [[ColorsTraceHandler alloc] initWithColorButtons:self.colorButtons withColorWasChangedHandler:^(UIColor *color) {
        [self updateSelectedColorBarButtonItemByColor: color];
    }];
}

- (void)updateSelectedColorBarButtonItemByColor:(UIColor *) color {
    UIBarButtonItem *barButtonItem;
    
    if (color) {
        CGFloat size = 32.0;
        UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, size, size)];
        view.layer.cornerRadius = size * 0.5;
        view.backgroundColor = color;
        barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (IBAction)buttonWasTapped:(UIButton *)sender {
    [self.handler colorWasChanged: sender];
}

@end
