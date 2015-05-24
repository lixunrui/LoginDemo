//
//  ViewController.m
//  LoginDemo
//
//  Created by Raymond Li on 15/5/24.
//  Copyright (c) 2015年 Raymond Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[self txtUsername] addTarget:self action:@selector(updateLoginButton) forControlEvents:UIControlEventEditingChanged];
    [[self txtPassword] addTarget:self action:@selector(updateLoginButton) forControlEvents:UIControlEventEditingChanged];
    [[self txtPassword] addTarget:self action:@selector(updateLabelMessage) forControlEvents:UIControlEventEditingDidEnd];
    
    self.txtPassword.secureTextEntry = YES;
}

- (void)updateLoginButton
{
    BOOL textFieldNotEmpty = self.txtUsername.text.length > 0 && self.txtPassword.text.length > 0 && self.txtPassword.text.length >= 6;
  
    self.btnLogin.enabled = textFieldNotEmpty;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)updateLabelMessage
{
    if (self.txtPassword.text.length <6) {
        self.lblPassword.text = @"Should not less than 6";
    }
    else
    {
        self.lblPassword.text = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LoginClicked:(id)sender {
}

@end
