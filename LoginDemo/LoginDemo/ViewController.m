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
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

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
    
    // create a progress bar here:
    UIProgressView* progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    
    //[progressView setFrame:CGRectMake(self.btnCancel.frame.origin.x, self.btnCancel.frame.origin.y, self.btnLogin.frame.origin.x+self.btnLogin.frame.size.width - self.btnCancel.frame.origin.x, self.btnLogin.bounds.size.height)];
    
    NSLog(@"X: %f; Y is%f, length :%f",self.btnCancel.bounds.origin.x,self.btnCancel.bounds.origin.y,self.btnLogin.frame.origin.x+self.btnLogin.frame.size.width - self.btnCancel.bounds.origin.x);
    
    //[progressView setFrame:CGRectMake(50, 50, 100, 100)];
    
    
    [self.btnLogin setEnabled:NO];
    [self.btnCancel setEnabled:NO];
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"Loading" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    
    [progressView setFrame:CGRectMake(0, 0, actionSheet.bounds.size.width, actionSheet.bounds.size.height)];
    
   // UIAlertView* actionSheet = [[UIAlertView alloc]initWithTitle:@"Loading" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    progressView.progress = 0;
     [actionSheet setBounds:CGRectMake(0, 0, 300, 300)];
    
    //[self.view addSubview:progressView];
    
    [actionSheet addSubview:progressView];
    [actionSheet showInView:self.view];
   
    
    
    //[actionSheet dismissWithClickedButtonIndex:1 animated:YES];
    
    NSArray* userInfo = [[NSArray alloc]initWithObjects:actionSheet, progressView, nil];
    
    NSTimer* t = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(updatebar:) userInfo:userInfo repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:t forMode:NSRunLoopCommonModes];
    
    NSLog(@"Done");
}

- (void)updatebar:(NSTimer*)time
{
    UIProgressView* p = [[time userInfo] objectAtIndex:1];
    UIActionSheet* sheet = [[time userInfo] objectAtIndex:0];
    p.progress += 0.01;
    
    [sheet setNeedsDisplay];
    
    NSLog(@"p is %f", p.progress);
    if (p.progress >=1) {
        [time invalidate];
        [sheet dismissWithClickedButtonIndex:0 animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"did dismiss button index : %d", buttonIndex);
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"will dismiss button index : %d",buttonIndex);
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    
}
@end
