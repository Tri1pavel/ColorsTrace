//
//  ViewController.m
//  CT
//
//  Created by Development on 24.06.2022.
//

#import "ColorsTraceViewController.h"

@interface ColorsTraceViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *colorButtons;
@property (strong, nonatomic) UIColor *selectedColor;
@end

@implementation ColorsTraceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateSelectedColorBarButtonItemByColor: nil];
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
    if (sender.isSelected) {
        // Deselect button that previously was selected
        sender.selected = !sender.selected;
    } else {
        // Deselect all buttons
        for (id color in self.colorButtons) {
            [color setSelected:false];
        }
        // Select the button that was tapped
        sender.selected = !sender.selected;
    }

    self.selectedColor = sender.isSelected ? sender.backgroundColor : nil;
    
    [self updateSelectedColorBarButtonItemByColor: self.selectedColor];
}

@end
