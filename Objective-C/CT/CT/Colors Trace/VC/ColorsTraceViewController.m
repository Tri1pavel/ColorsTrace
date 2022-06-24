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
}

@end
