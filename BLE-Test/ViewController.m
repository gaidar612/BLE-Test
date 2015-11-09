//
//  ViewController.m
//  BLE-Test
//
//  Created by Admin on 06.11.15.
//  Copyright © 2015 George. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onScan:(id)sender {
    self.labelText.text = @"";
    
    if (centralManager)
    {
        [centralManager stopScan];
        centralManager = nil;
    }
    
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central {

    CBCentralManagerState state = central.state;
    
    NSLog(@"State: %ld", state);
    
    if (state == CBCentralManagerStatePoweredOn)
    {
        [centralManager scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSString *id = [self getPeripheralId:peripheral];
    self.labelText.text = id;
    
    NSLog(@"Peripheral id: %@", id);
    
    [centralManager stopScan];
}

- (NSString *) getPeripheralId:(CBPeripheral *)aPeripheral
{
    SEL selector = NSSelectorFromString(@"identifier");
    
    if ([aPeripheral respondsToSelector:selector])
    {
        NSUUID *UUID = (NSUUID *)[aPeripheral performSelector: selector];
        return UUID.UUIDString;
    }
    
    selector = NSSelectorFromString(@"UUID");
    
    if ([aPeripheral respondsToSelector:selector])
    {
        CFUUIDRef UUID = (__bridge CFUUIDRef)[aPeripheral performSelector: selector];
        return (__bridge_transfer NSString *)CFUUIDCreateString(nil, UUID);
        
    }
    
    return nil;
}

@end
